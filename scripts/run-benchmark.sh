#!/usr/bin/env bash
set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export MANIFEST="$REPO_ROOT/manifest.json"
export PYTHONPATH="$REPO_ROOT/scripts${PYTHONPATH:+:$PYTHONPATH}"
# shellcheck source=lib.sh
source "$REPO_ROOT/scripts/lib.sh"

APP="${1:?usage: run-benchmark.sh <app> [ref-override]}"
REF_OVERRIDE="${2:-${REF_OVERRIDE:-}}"
export RUNNER_PROFILE="${RUNNER_PROFILE:-bladerunner}"

if ! python3 -m bench.manifest get "apps.${APP}.kind" | grep -q .; then
  echo "unknown app '$APP' (not in manifest.json)" >&2
  exit 2
fi

eval "$(python3 -m bench.manifest dump "$APP")"
[ -n "$REF_OVERRIDE" ] && REF="$REF_OVERRIDE"
SUBMODULES_FLAG=0
python3 -m bench.manifest bool "apps.${APP}.submodules" && SUBMODULES_FLAG=1

WORK_BASE="${RUNNER_TEMP:-$REPO_ROOT/.work}"
WORK_DIR="$WORK_BASE/bench-$APP"
APP_DIR="$WORK_DIR/src"
PHASES_FILE="$WORK_DIR/phases.tsv"
DERIVED_DATA="${XCODE_DERIVED_DATA:-$WORK_DIR/DerivedData}"

rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR"
: >"$PHASES_FILE"

log "=== ${DISPLAY_NAME} :: ${GIT_REPO} @ ${REF} ==="

clone_repo() {
  local sm=()
  [ "$SUBMODULES_FLAG" = "1" ] && sm=(--recurse-submodules --shallow-submodules)
  if printf '%s' "$REF" | grep -qE '^[0-9a-f]{7,40}$'; then
    git clone --filter=blob:none ${sm[@]+"${sm[@]}"} "$GIT_REPO" "$APP_DIR" || return 1
    git -C "$APP_DIR" checkout --quiet "$REF" || return 1
    if [ "$SUBMODULES_FLAG" = "1" ]; then
      git -C "$APP_DIR" submodule update --init --recursive --depth 1 || return 1
    fi
  else
    git clone --depth 1 --branch "$REF" ${sm[@]+"${sm[@]}"} "$GIT_REPO" "$APP_DIR" || return 1
  fi
  return 0
}
phase clone -- clone_repo

COMMIT="unknown"
[ -d "$APP_DIR/.git" ] && COMMIT="$(git -C "$APP_DIR" rev-parse HEAD 2>/dev/null || echo unknown)"

# Toolchain bootstrap is not timed: bootstrap noise, not build cost.
if [ -z "$PHASE_FAILED" ]; then
  "$REPO_ROOT/scripts/ensure-tools.sh" "$KIND" || log "WARN: ensure-tools reported issues"
fi

if [ -z "$PHASE_FAILED" ]; then
  export APP APP_DIR SCHEME PROJECT WORKSPACE DEST CONFIGURATION DERIVED_DATA
  export PHASES_FILE REPO_ROOT
  # shellcheck source=/dev/null
  source "$REPO_ROOT/benchmarks/${APP}/build.sh" || log "build script ended with failure"
fi

TS="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
STAMP="$(date -u '+%Y%m%dT%H%M%SZ')"
SHA7="$(printf '%s' "$COMMIT" | cut -c1-7)"
REL_OUT="results/$RUNNER_PROFILE/$APP/${STAMP}__${SHA7}.json"
OUT_FILE="$REPO_ROOT/$REL_OUT"

RUN_ID="${GITHUB_RUN_ID:-local}"
RUN_URL=""
[ -n "${GITHUB_RUN_ID:-}" ] && \
  RUN_URL="${GITHUB_SERVER_URL:-https://github.com}/${GITHUB_REPOSITORY:-}/actions/runs/${GITHUB_RUN_ID}"

python3 -m bench.emit_result \
  --out "$OUT_FILE" --phases "$PHASES_FILE" \
  --app "$APP" --display-name "$DISPLAY_NAME" --kind "$KIND" \
  --repo "$GIT_REPO" --ref "$REF" --commit "$COMMIT" \
  --timestamp "$TS" --run-id "$RUN_ID" --run-url "$RUN_URL" \
  --failed-phase "$PHASE_FAILED" --runner-profile "$RUNNER_PROFILE"

log "wrote $REL_OUT"
[ -n "${GITHUB_OUTPUT:-}" ] && echo "bench_file=$REL_OUT" >>"$GITHUB_OUTPUT"

[ -z "$PHASE_FAILED" ]
