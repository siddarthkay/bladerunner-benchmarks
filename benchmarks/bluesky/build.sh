#!/usr/bin/env bash
# Bluesky (social-app) -> Expo / React Native, pnpm.

_bsky_deps() {
  corepack enable >/dev/null 2>&1 || true
  pnpm install --frozen-lockfile || pnpm install
  pnpm intl:build
  # iOS-only prebuild: upstream's pnpm prebuild also does Android, which needs
  # a google-services.json that isn't in the repo.
  EXPO_NO_GIT_STATUS=1 pnpm exec expo prebuild --clean --platform ios
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
