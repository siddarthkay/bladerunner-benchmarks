#!/usr/bin/env bash
# React Native -> RN Tester app from the facebook/react-native monorepo.
# RCT_USE_*=0 disables the RN 0.85 prebuilt-pod path.

_rnt_deps() {
  corepack enable >/dev/null 2>&1 || true
  yarn install --frozen-lockfile || yarn install
  cd packages/rn-tester
  bundle install
  RCT_USE_PREBUILT_RNCORE=0 RCT_USE_RN_DEP=0 bundle exec pod install
}

_rnt_build() { xcb_build -workspace "$WORKSPACE"; }

phase deps  --cwd "$APP_DIR" -- _rnt_deps
phase build --cwd "$APP_DIR" -- _rnt_build
