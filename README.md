# bladerunner-benchmarks

Nightly cold-build benchmarks for popular open-source iOS and React Native apps,
run on two macOS runners:

- **bladerunner**: Ultra fast MacOS runners by [bladerunner](https://bladerunner.sh).
- **github**: `macos-26` GitHub-hosted runner (free tier, arm64, Xcode 26.4.1).

Each run starts from a clean sandbox: fresh clone, fresh dependencies, fresh compile.

## Leaderboard

<!-- LEADERBOARD:START -->
### Comparison

| App | bladerunner | github | github ÷ bladerunner |
|-----|------:|------:|------:|
| XcodeBenchmark (anchor) | 23s | 10.2m | - |
| Wikipedia iOS | 1.9m | 7.9m | 4.2× |
| DuckDuckGo iOS | 3.7m | 13.8m | - |
| React Native (RN Tester) | 3.8m | 19.8m | 5.2× |
| Bluesky (social-app) | 1.2m | 30.6m | - |
| Mattermost Mobile | 44s | 34.2m | - |

### bladerunner - Mac Studio · Xcode 27.0

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ❌ build | 23s | 14s | - | 9s | - | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36232796002) | 2026-09-26 09:47:20 |
| Wikipedia iOS | ✅ | 1.9m | 23s | 23s | 1.1m | ❗ 1s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36232796002) | 2026-09-26 09:49:36 |
| DuckDuckGo iOS | ❌ build | 3.7m | 8s | 2.4m | 1.3m | - | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36232796002) | 2026-09-26 09:53:45 |
| React Native (RN Tester) | ✅ | 3.8m | 24s | 1.4m | 2.0m | ±0s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36232796002) | 2026-09-26 09:58:04 |
| Bluesky (social-app) | ❌ deps | 1.2m | 10s | 1.0m | 0s | - | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36232796002) | 2026-09-26 09:59:56 |
| Mattermost Mobile | ❌ build | 44s | 15s | 27s | 2s | - | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35981600483) | 2026-09-24 09:47:03 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 10.2m | 11s | - | 10.1m | ⚡ 368s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36232796002) | 2026-09-26 09:56:50 |
| Wikipedia iOS | ✅ | 7.9m | 16s | 34s | 7.0m | ❗ 123s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36232796002) | 2026-09-26 10:05:08 |
| DuckDuckGo iOS | ✅ | 13.8m | 5s | 1.9m | 11.8m | ❗ 105s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36232796002) | 2026-09-26 10:19:20 |
| React Native (RN Tester) | ✅ | 19.8m | 17s | 2.2m | 17.3m | ⚡ 74s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36232796002) | 2026-09-26 10:39:46 |
| Bluesky (social-app) | ✅ | 30.6m | 6s | 3.9m | 26.6m | ⚡ 276s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36232796002) | 2026-09-26 11:11:06 |
| Mattermost Mobile | ✅ | 34.2m | 8s | 6.8m | 27.2m | ⚡ 201s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36232796002) | 2026-09-26 11:46:17 |
<!-- LEADERBOARD:END -->


## Methodology

- Builds target the iOS Simulator in `Debug` with `CODE_SIGNING_ALLOWED=NO`.
- Each app is defined in [`manifest.json`](./manifest.json) with a pinned `ref`,
  scheme, and project/workspace. The pinned SHA keeps a workload stable across
  runs; bump it to refresh. The built SHA is recorded in every result.
- The harness times `clone`, `deps`, and `build` separately, so a regression
  points at network, tooling, or the compiler.
- XcodeBenchmark is the anchor workload. It vendors its Pods, making its number
  directly comparable across CI providers.
- Jobs run on the `bladerunner-macos` runner label. Runner metadata (macOS, Xcode,
  cores, RAM) is captured per run.

## Apps benchmarked

| App | Upstream | Type |
|-----|----------|------|
| Wikipedia iOS | `wikimedia/wikipedia-ios` | Native (Swift/Obj-C, SwiftPM) |
| DuckDuckGo iOS | `duckduckgo/iOS` | Native (Swift, SwiftPM) |
| React Native (RN Tester) | `facebook/react-native` | React Native (yarn + CocoaPods) |
| Bluesky | `bluesky-social/social-app` | React Native / Expo (pnpm) |
| Mattermost Mobile | `mattermost/mattermost-mobile` | React Native (npm + CocoaPods) |

## How it runs

- Nightly GitHub Actions cron.
- A matrix job builds each app; a `publish` job aggregates results, regenerates
  the leaderboard, and commits back.
- Raw results live under `results/<profile>/<app>/<timestamp>__<sha>.json`
  ([`results/`](./results)). One JSON per run.
