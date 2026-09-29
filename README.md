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
| XcodeBenchmark (anchor) | 24s | 18.2m | - |
| Wikipedia iOS | 1.9m | 8.0m | 4.2× |
| DuckDuckGo iOS | 4.2m | 14.4m | - |
| React Native (RN Tester) | 3.9m | 23.4m | 6.0× |
| Bluesky (social-app) | 1.1m | 45.2m | - |
| Mattermost Mobile | 44s | 45.7m | - |

### bladerunner - Mac Studio · Xcode 27.0

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ❌ build | 24s | 15s | - | 9s | - | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36405088163) | 2026-09-28 09:42:58 |
| Wikipedia iOS | ✅ | 1.9m | 24s | 22s | 1.1m | ❗ 1s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36405088163) | 2026-09-28 09:45:18 |
| DuckDuckGo iOS | ❌ build | 4.2m | 8s | 2.8m | 1.3m | - | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36405088163) | 2026-09-28 09:49:55 |
| React Native (RN Tester) | ✅ | 3.9m | 27s | 1.4m | 2.0m | ❗ 5s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36405088163) | 2026-09-28 09:54:23 |
| Bluesky (social-app) | ❌ deps | 1.1m | 12s | 56s | 0s | - | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36405088163) | 2026-09-28 09:56:13 |
| Mattermost Mobile | ❌ build | 44s | 15s | 27s | 2s | - | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35981600483) | 2026-09-24 09:47:03 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 18.2m | 14s | - | 17.9m | ❗ 475s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36405088163) | 2026-09-28 10:00:23 |
| Wikipedia iOS | ✅ | 8.0m | 20s | 45s | 6.9m | ❗ 6s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36405088163) | 2026-09-28 10:08:56 |
| DuckDuckGo iOS | ✅ | 14.4m | 7s | 1.8m | 12.4m | ❗ 36s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36405088163) | 2026-09-28 10:23:58 |
| React Native (RN Tester) | ✅ | 23.4m | 20s | 2.7m | 20.4m | ❗ 216s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36405088163) | 2026-09-28 10:48:08 |
| Bluesky (social-app) | ✅ | 45.2m | 8s | 5.5m | 39.5m | ❗ 878s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36405088163) | 2026-09-28 11:34:11 |
| Mattermost Mobile | ✅ | 45.7m | 8s | 11.1m | 34.5m | ❗ 688s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36405088163) | 2026-09-28 12:20:56 |
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
