#!/usr/bin/env python3
"""Regenerate the README leaderboard from results/<profile>/<app>/*.json.

Renders:
  - a comparison table (one row per app, one column per profile + speedup)
  - one detail table per profile
  - a Prometheus-format metrics file at results/metrics.prom that the
    monitoring stack (bladerunner-infra) scrapes from raw.githubusercontent
    to drive the "bladerunner slower than github" alert
"""
import datetime
import glob
import json
import os
import re

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
RESULTS_DIR = os.path.join(ROOT, "results")
README = os.path.join(ROOT, "README.md")
MANIFEST = os.path.join(ROOT, "manifest.json")
METRICS_PROM = os.path.join(RESULTS_DIR, "metrics.prom")
START = "<!-- LEADERBOARD:START -->"
END = "<!-- LEADERBOARD:END -->"

# Render profiles in this order; any unknown profile is appended alphabetically.
PROFILE_ORDER = ["bladerunner", "github"]


def load_runs():
    """{profile: {app: [runs sorted by timestamp]}}"""
    runs = {}
    for path in glob.glob(os.path.join(RESULTS_DIR, "*", "*", "*.json")):
        try:
            with open(path) as f:
                data = json.load(f)
        except (ValueError, OSError) as e:
            print(f"WARN: skipping {path}: {e}", file=__import__("sys").stderr)
            continue
        rel = os.path.relpath(path, RESULTS_DIR)
        profile = rel.split(os.sep)[0]
        app = data.get("app", "unknown")
        runs.setdefault(profile, {}).setdefault(app, []).append(data)
    for profile in runs:
        for app in runs[profile]:
            runs[profile][app].sort(key=lambda r: r.get("timestamp", ""))
    return runs


def app_order():
    try:
        with open(MANIFEST) as f:
            return list(json.load(f)["apps"].keys())
    except (ValueError, OSError, KeyError):
        return []


def profile_order(runs):
    seen = set(runs)
    ordered = [p for p in PROFILE_ORDER if p in seen]
    ordered += sorted(p for p in seen if p not in PROFILE_ORDER)
    return ordered


def phase_secs(run, name):
    for p in run.get("phases", []):
        if p["name"] == name:
            return p["seconds"]
    return None


def fmt(secs):
    if secs is None:
        return "-"
    if secs >= 60:
        return f"{secs/60:.1f}m"
    return f"{secs:.0f}s"


def delta_cell(latest, prev):
    if not prev or latest.get("status") != "success" or prev.get("status") != "success":
        return "-"
    d = latest["total_seconds"] - prev["total_seconds"]
    if abs(d) < 1:
        return "±0s"
    arrow = "❗" if d > 0 else "⚡"
    return f"{arrow} {abs(d):.0f}s"


def run_link(run):
    ref = run.get("ref", "?")
    sha = (run.get("commit") or "")[:7]
    label = f"`{ref}` @ `{sha}`" if sha else f"`{ref}`"
    url = run.get("run_url")
    return f"[{label}]({url})" if url else label


def profile_subtitle(latest):
    runner = latest.get("runner", {})
    model = runner.get("model") or ""
    xcode = runner.get("xcode") or ""
    m = re.search(r"Xcode\s+\S+", xcode)
    parts = []
    if model:
        parts.append(model)
    if m:
        parts.append(m.group(0))
    return " · ".join(parts)


def build_detail_table(app_runs):
    rows = [
        "| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |",
        "|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|",
    ]
    order = app_order()
    apps = order + [a for a in sorted(app_runs) if a not in order]
    any_row = False
    for app in apps:
        history = app_runs.get(app)
        if not history:
            continue
        any_row = True
        latest = history[-1]
        prev = history[-2] if len(history) > 1 else None
        status = "✅" if latest.get("status") == "success" else f"❌ {latest.get('failed_phase','')}"
        rows.append(
            "| {name} | {status} | {total} | {clone} | {deps} | {build} | {delta} | {built} | {when} |".format(
                name=latest.get("display_name", app),
                status=status,
                total=fmt(latest.get("total_seconds")),
                clone=fmt(phase_secs(latest, "clone")),
                deps=fmt(phase_secs(latest, "deps")),
                build=fmt(phase_secs(latest, "build")),
                delta=delta_cell(latest, prev),
                built=run_link(latest),
                when=latest.get("timestamp", "").replace("T", " ").replace("Z", ""),
            )
        )
    if not any_row:
        return "_No runs recorded yet for this profile._"
    return "\n".join(rows)


def build_comparison_table(runs, profiles):
    base_p = profiles[0]
    others = profiles[1:]
    header = ["App"] + profiles
    if others:
        header += [f"{op} ÷ {base_p}" for op in others]
    align = ["|-----"] + ["|------:" for _ in header[1:]] + ["|"]
    rows = ["| " + " | ".join(header) + " |", "".join(align)]

    order = app_order()
    apps_set = set()
    for p in profiles:
        apps_set.update(runs.get(p, {}).keys())
    apps = order + sorted(apps_set - set(order))

    any_row = False
    for app in apps:
        if app not in apps_set:
            continue
        any_row = True
        cells = []
        latest_per = {}
        for p in profiles:
            hist = runs.get(p, {}).get(app, [])
            latest_per[p] = hist[-1] if hist else None
            cells.append(fmt(latest_per[p]["total_seconds"]) if hist else "-")
        display = next(
            (r.get("display_name", app) for r in latest_per.values() if r),
            app,
        )
        base = latest_per.get(base_p)
        for op in others:
            other = latest_per.get(op)
            if base and other and base.get("status") == "success" and other.get("status") == "success":
                bs = base["total_seconds"]
                os_ = other["total_seconds"]
                if bs > 0:
                    cells.append(f"{os_/bs:.1f}×")
                    continue
            cells.append("-")
        rows.append("| " + display + " | " + " | ".join(cells) + " |")

    if not any_row:
        return None
    return "\n".join(rows)


def render(runs):
    profiles = profile_order(runs)
    if not profiles:
        return ("_No benchmark runs recorded yet. "
                "The table is generated automatically after the first run._")

    sections = []
    if len(profiles) > 1:
        cmp = build_comparison_table(runs, profiles)
        if cmp:
            sections.append("### Comparison\n\n" + cmp)

    for p in profiles:
        app_runs = runs.get(p, {})
        latest_any = next(
            (h[-1] for h in app_runs.values() if h),
            None,
        )
        subtitle = profile_subtitle(latest_any) if latest_any else ""
        header = f"### {p}" + (f" - {subtitle}" if subtitle else "")
        sections.append(header + "\n\n" + build_detail_table(app_runs))

    return "\n\n".join(sections)


def _ts_to_epoch(iso):
    """Parse an ISO-8601 UTC timestamp to a unix epoch; return 0 on failure."""
    if not iso:
        return 0
    try:
        # Tolerate both "2026-05-26T07:52:45Z" and missing trailing Z.
        s = iso.rstrip("Z")
        return int(datetime.datetime.fromisoformat(s).replace(
            tzinfo=datetime.timezone.utc).timestamp())
    except ValueError:
        return 0


def render_metrics(runs):
    """Emit Prometheus textfile metrics for the latest run of every (profile, app).

    Exposed series:
      bladerunner_benchmark_build_seconds{profile,app}     - phase=build, latest run
      bladerunner_benchmark_total_seconds{profile,app}     - clone+deps+build
      bladerunner_benchmark_timestamp_seconds{profile,app} - unix ts of that run
      bladerunner_benchmark_status{profile,app}            - 1 success, 0 failure
    """
    lines = [
        "# HELP bladerunner_benchmark_build_seconds Last build-phase wall-time.",
        "# TYPE bladerunner_benchmark_build_seconds gauge",
        "# HELP bladerunner_benchmark_total_seconds Last total wall-time (clone+deps+build).",
        "# TYPE bladerunner_benchmark_total_seconds gauge",
        "# HELP bladerunner_benchmark_timestamp_seconds Unix timestamp of the last run.",
        "# TYPE bladerunner_benchmark_timestamp_seconds gauge",
        "# HELP bladerunner_benchmark_status Latest run status (1=success, 0=failure).",
        "# TYPE bladerunner_benchmark_status gauge",
    ]
    for profile in sorted(runs):
        for app in sorted(runs[profile]):
            history = runs[profile][app]
            if not history:
                continue
            latest = history[-1]
            labels = f'profile="{profile}",app="{app}"'
            build = phase_secs(latest, "build")
            total = latest.get("total_seconds")
            ts = _ts_to_epoch(latest.get("timestamp", ""))
            status = 1 if latest.get("status") == "success" else 0
            if build is not None:
                lines.append(f"bladerunner_benchmark_build_seconds{{{labels}}} {build}")
            if total is not None:
                lines.append(f"bladerunner_benchmark_total_seconds{{{labels}}} {total}")
            if ts:
                lines.append(f"bladerunner_benchmark_timestamp_seconds{{{labels}}} {ts}")
            lines.append(f"bladerunner_benchmark_status{{{labels}}} {status}")
    return "\n".join(lines) + "\n"


def main():
    runs = load_runs()

    body = render(runs)
    with open(README) as f:
        text = f.read()
    if START not in text or END not in text:
        raise SystemExit("README is missing LEADERBOARD markers")
    pre = text.split(START)[0]
    post = text.split(END)[1]
    new = f"{pre}{START}\n{body}\n{END}{post}"
    if new != text:
        tmp = README + ".tmp"
        with open(tmp, "w") as f:
            f.write(new)
        os.replace(tmp, README)
        print("leaderboard updated")
    else:
        print("leaderboard unchanged")

    metrics = render_metrics(runs)
    existing = ""
    if os.path.exists(METRICS_PROM):
        with open(METRICS_PROM) as f:
            existing = f.read()
    if metrics != existing:
        tmp = METRICS_PROM + ".tmp"
        with open(tmp, "w") as f:
            f.write(metrics)
        os.replace(tmp, METRICS_PROM)
        print("metrics.prom updated")
    else:
        print("metrics.prom unchanged")


if __name__ == "__main__":
    main()
