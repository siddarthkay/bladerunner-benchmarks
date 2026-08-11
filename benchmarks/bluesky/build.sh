#!/usr/bin/env bash
# Bluesky (social-app) -> Expo / React Native, pnpm.

# Both pods have to be pinned: MMKV 2.4.0 declares "MMKVCore ~> 2.4.0", which
# still resolves up to the broken MMKVCore 2.4.1.
MMKV_POD_VERSION="2.4.0"

_bsky_pin_mmkv() {
  local podfile="ios/Podfile"
  [ -f "$podfile" ] || { log "no ios/Podfile to pin MMKV in"; return 1; }
  if grep -q "pod 'MMKV'" "$podfile"; then
    log "MMKV already pinned in Podfile"
    return 0
  fi
  awk -v scheme="$SCHEME" -v version="$MMKV_POD_VERSION" -v q="'" '
    !done && $0 ~ "^[[:space:]]*target[[:space:]]+[" q "\"]" scheme "[" q "\"][[:space:]]+do" {
      print
      print "  pod " q "MMKV" q ", " q version q
      print "  pod " q "MMKVCore" q ", " q version q
      done = 1
      next
    }
    { print }
  ' "$podfile" >"$podfile.pinned" && mv "$podfile.pinned" "$podfile"
  if ! grep -q "pod 'MMKV', '$MMKV_POD_VERSION'" "$podfile" ||
     ! grep -q "pod 'MMKVCore', '$MMKV_POD_VERSION'" "$podfile"; then
    log "failed to pin MMKV: no 'target ${SCHEME} do' block in $podfile"
    return 1
  fi
  log "pinned MMKV + MMKVCore to $MMKV_POD_VERSION in $podfile"
}

_bsky_deps() {
  corepack enable >/dev/null 2>&1 || true
  pnpm install --frozen-lockfile || pnpm install
  pnpm intl:build
  # iOS-only prebuild: upstream's pnpm prebuild also does Android, which needs
  # a google-services.json that isn't in the repo.
  EXPO_NO_GIT_STATUS=1 pnpm exec expo prebuild --clean --no-install --platform ios
  _bsky_pin_mmkv || return 1
  if [ -f ios/Podfile ] && [ ! -d ios/Pods ]; then
    ( cd ios && pod install )
  fi
}

_bsky_build() {
  local ws
  ws="$(resolve_glob "$WORKSPACE")"
  [ -n "$ws" ] || { log "no workspace matched '$WORKSPACE'"; return 1; }
  xcb_build -workspace "$ws"
}

phase deps  --cwd "$APP_DIR" -- _bsky_deps
phase build --cwd "$APP_DIR" -- _bsky_build
