#!/usr/bin/env python3
"""Manifest accessors for shell harness.

Subcommands:
  get <dotted.path>       print value (empty if missing), exit 0
  bool <dotted.path>      exit 0 if value is truthy, 1 otherwise
  apps                    newline-separated app keys
  apps-json               JSON array of app keys (for the Actions matrix)
  dump <app>              shell-eval'able KEY='value' lines for one app
"""
import json
import os
import shlex
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
MANIFEST_PATH = os.environ.get("MANIFEST") or os.path.join(ROOT, "manifest.json")


def _load():
    with open(MANIFEST_PATH) as f:
        return json.load(f)


def _walk(data, path):
    cur = data
    for part in path.split("."):
        if isinstance(cur, dict) and part in cur:
            cur = cur[part]
        else:
            return None
    return cur


def _stringify(v):
    if v is None:
        return ""
    if isinstance(v, bool):
        return "true" if v else "false"
    return str(v)


def cmd_get(path):
    print(_stringify(_walk(_load(), path)))


def cmd_bool(path):
    sys.exit(0 if _walk(_load(), path) else 1)


def cmd_apps():
    print("\n".join(_load()["apps"].keys()))


def cmd_apps_json():
    print(json.dumps(list(_load()["apps"].keys())))


def cmd_dump(app):
    data = _load()
    app_cfg = data.get("apps", {}).get(app)
    if app_cfg is None:
        sys.exit(f"unknown app '{app}'")
    fields = {
        "DISPLAY_NAME": app_cfg.get("display_name", ""),
        "KIND": app_cfg.get("kind", ""),
        "GIT_REPO": app_cfg.get("repo", ""),
        "REF": app_cfg.get("ref", ""),
        "SUBMODULES": "true" if app_cfg.get("submodules") else "false",
        "PROJECT": app_cfg.get("project", ""),
        "WORKSPACE": app_cfg.get("workspace", ""),
        "SCHEME": app_cfg.get("scheme", ""),
        "DEST": app_cfg.get("destination") or data.get("destination", ""),
        "CONFIGURATION": data.get("configuration", "Debug"),
    }
    for k, v in fields.items():
        print(f"{k}={shlex.quote(_stringify(v))}")


def main(argv):
    if len(argv) < 2:
        sys.exit(__doc__)
    sub = argv[1]
    if sub == "get" and len(argv) == 3:
        cmd_get(argv[2])
    elif sub == "bool" and len(argv) == 3:
        cmd_bool(argv[2])
    elif sub == "apps" and len(argv) == 2:
        cmd_apps()
    elif sub == "apps-json" and len(argv) == 2:
        cmd_apps_json()
    elif sub == "dump" and len(argv) == 3:
        cmd_dump(argv[2])
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
