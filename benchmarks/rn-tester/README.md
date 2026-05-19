# React Native (RN Tester) - notes

`yarn install` at the monorepo root, then `bundler` + CocoaPods in
`packages/rn-tester`, then `xcodebuild` of the generated workspace.

## Why `RCT_USE_PREBUILT_RNCORE=0 RCT_USE_RN_DEP=0`

RN 0.85's prebuilt mode has CocoaPods plugins that download tarballs from Maven
Central mid-resolution and then disagree with themselves about the version
("could not find compatible versions for pod …" / "differs from version stored
in Pods/Local Podspecs"). The drift is re-created on every retry; `pod update`
and `--repo-update` don't help.

RN exposes two separate toggles (see `scripts/react_native_pods.rb`):
- `RCT_USE_PREBUILT_RNCORE` for the React-Core-prebuilt pod
- `RCT_USE_RN_DEP` for `ReactNativeDependencies`

Setting both to 0 makes `pod install` build them from source the way RN 0.84
and earlier did - slower but deterministic, and closer to how most RN CI runs.
