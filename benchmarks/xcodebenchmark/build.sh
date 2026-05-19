#!/usr/bin/env bash
# XcodeBenchmark -> ecosystem-standard comparable workload, vendored Pods,
# no deps phase. Mirrors upstream benchmark.sh.

_xb_build() {
  NSUnbufferedIO=YES xcodebuild \
    -workspace XcodeBenchmark.xcworkspace \
    -scheme XcodeBenchmark \
    -destination "${DEST:-generic/platform=iOS}" \
    -derivedDataPath "$DERIVED_DATA" \
    CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO CODE_SIGN_IDENTITY="" \
    clean build 2>&1 | _xcpipe
}

phase build --cwd "$APP_DIR" -- _xb_build
