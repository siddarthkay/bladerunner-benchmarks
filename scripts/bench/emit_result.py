#!/usr/bin/env python3
import argparse
import json
import os
import shutil
import socket
import subprocess


def _run(cmd):
    try:
        out = subprocess.run(cmd, capture_output=True, text=True, timeout=10)
        return (out.stdout or "").strip()
    except (FileNotFoundError, subprocess.TimeoutExpired, OSError):
        return ""


def _first_line(s):
    return s.splitlines()[0].strip() if s else ""


def _tool_version(name, args=("--version",)):
    if shutil.which(name):
        return _first_line(_run([name, *args]))
    return ""


def _sysctl(key):
    return _run(["sysctl", "-n", key])


def collect_runner(profile):
    mem_raw = _sysctl("hw.memsize")
    cores_raw = _sysctl("hw.ncpu")
    if profile == "bladerunner":
        model = "Mac Studio"
    else:
        model = _sysctl("machdep.cpu.brand_string") or _sysctl("hw.model")
    return {
        "label": profile,
        "hostname": socket.gethostname(),
        "os": _run(["sw_vers", "-productVersion"]),
        "arch": _run(["uname", "-m"]),
        "model": model,
        "cpu_cores": int(cores_raw) if cores_raw.isdigit() else None,
        "mem_gb": round(int(mem_raw) / 1e9, 1) if mem_raw.isdigit() else None,
        "xcode": " ".join(_run(["xcodebuild", "-version"]).split()),
    }


def collect_tooling():
    return {
        "node": _tool_version("node"),
        "pnpm": _tool_version("pnpm"),
        "yarn": _tool_version("yarn"),
        "ruby": _tool_version("ruby"),
        "cocoapods": _tool_version("pod"),
    }


def read_phases(path):
    phases = []
    total = 0.0
    if not path or not os.path.exists(path):
        return phases, total
    with open(path) as f:
        for line in f:
            line = line.rstrip("\n")
            if not line:
                continue
            name, secs, status = line.split("\t")
            secs = float(secs)
            total += secs
            phases.append({"name": name, "seconds": secs, "status": status})
    return phases, total


def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument("--out", required=True)
    p.add_argument("--phases", required=True)
    p.add_argument("--app", required=True)
    p.add_argument("--display-name", required=True)
    p.add_argument("--kind", required=True)
    p.add_argument("--repo", required=True)
    p.add_argument("--ref", required=True)
    p.add_argument("--commit", required=True)
    p.add_argument("--timestamp", required=True)
    p.add_argument("--run-id", default="local")
    p.add_argument("--run-url", default="")
    p.add_argument("--failed-phase", default="")
    p.add_argument("--runner-profile", default="bladerunner",
                   help="bladerunner | github (becomes runner.label)")
    return p.parse_args()


def main():
    args = parse_args()
    phases, total = read_phases(args.phases)
    failed = args.failed_phase or None
    result = {
        "schema": 1,
        "app": args.app,
        "display_name": args.display_name,
        "kind": args.kind,
        "status": "failure" if failed else "success",
        "failed_phase": failed,
        "timestamp": args.timestamp,
        "repo": args.repo,
        "ref": args.ref,
        "commit": args.commit,
        "run_id": args.run_id,
        "run_url": args.run_url,
        "runner": collect_runner(args.runner_profile),
        "tooling": collect_tooling(),
        "phases": phases,
        "total_seconds": round(total, 1),
    }
    os.makedirs(os.path.dirname(args.out), exist_ok=True)
    with open(args.out, "w") as f:
        json.dump(result, f, indent=2)
        f.write("\n")
    print(json.dumps({"status": result["status"], "total_seconds": result["total_seconds"]}))


if __name__ == "__main__":
    main()
