#!/usr/bin/env bash
# Shared helpers for the benchmark harness.

_epoch_ms() {
  python3 -c 'import time; print(int(time.time()*1000))'
}

log() {
  printf '%s  %s\n' "$(date -u '+%H:%M:%S')" "$*" >&2
}

PHASE_FAILED=""

phase() {
  local name="$1"; shift
  local cwd=""
  if [ "${1:-}" = "--cwd" ]; then cwd="$2"; shift 2; fi
  [ "${1:-}" = "--" ] && shift
  local start end rc secs
  start="$(_epoch_ms)"
  log "▶ phase:${name} :: $*"
  if [ -n "$cwd" ]; then
    ( set -eo pipefail; cd "$cwd" && "$@" )
  else
    ( set -eo pipefail; "$@" )
  fi
  rc=$?
  end="$(_epoch_ms)"
  secs="$(python3 -c "print(f'{($end - $start)/1000:.1f}')")"
  if [ "$rc" -eq 0 ]; then
    printf '%s\t%s\t%s\n' "$name" "$secs" "success" >>"$PHASES_FILE"
    log "✔ phase:${name} ok in ${secs}s"
  else
    printf '%s\t%s\t%s\n' "$name" "$secs" "failure" >>"$PHASES_FILE"
    log "✗ phase:${name} FAILED (rc=${rc}) after ${secs}s"
    [ -z "$PHASE_FAILED" ] && PHASE_FAILED="$name"
  fi
  return $rc
}

resolve_glob() {
  local matches
  # shellcheck disable=SC2206
  matches=( $1 )
  [ -e "${matches[0]}" ] && printf '%s\n' "${matches[0]}"
}

_xcpipe() {
  if command -v xcbeautify >/dev/null 2>&1; then xcbeautify; else cat; fi
}

xcb_resolve() {
  NSUnbufferedIO=YES xcodebuild -resolvePackageDependencies \
    "$1" "$2" -scheme "$SCHEME" \
    -clonedSourcePackagesDirPath "$DERIVED_DATA/SourcePackages" 2>&1 | _xcpipe
}

xcb_build() {
  NSUnbufferedIO=YES xcodebuild build \
    "$1" "$2" -scheme "$SCHEME" \
    -configuration "${CONFIGURATION:-Debug}" \
    -destination "${DEST:-generic/platform=iOS Simulator}" \
    -derivedDataPath "$DERIVED_DATA" \
    -clonedSourcePackagesDirPath "$DERIVED_DATA/SourcePackages" \
    -skipPackagePluginValidation -skipMacroValidation \
    ONLY_ACTIVE_ARCH=YES \
    CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO CODE_SIGN_IDENTITY="" \
    2>&1 | _xcpipe
}
