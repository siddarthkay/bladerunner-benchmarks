#!/usr/bin/env bash
# Mattermost Mobile - React Native, npm. Pod install is driven by mattermost's
# npm postinstall, so we MUST NOT run `pod install` again (see ./README.md).

_mm_deps() {
  # bladerunner has Node 26; upstream pins engines to ^18|^20|^22.11 with
  # engine-strict=true. Override at env level only.
  export npm_config_engine_strict=false
  git apply "$REPO_ROOT/benchmarks/mattermost/patches/"*.patch
  npm ci || npm install
}

_mm_build() { xcb_build -workspace "$WORKSPACE"; }

phase deps  --cwd "$APP_DIR" -- _mm_deps
phase build --cwd "$APP_DIR" -- _mm_build
