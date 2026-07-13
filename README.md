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
| XcodeBenchmark (anchor) | 1.8m | 13.1m | 7.3× |
| Wikipedia iOS | 1.4m | 8.6m | 6.0× |
| DuckDuckGo iOS | 1.8m | 13.7m | 7.6× |
| React Native (RN Tester) | 3.3m | 18.8m | 5.7× |
| Bluesky (social-app) | 5.7m | 27.4m | 4.8× |
| Mattermost Mobile | 5.4m | 35.6m | 6.6× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.8m | 17s | - | 1.5m | ⚡ 33s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29242781600) | 2026-07-13 10:29:32 |
| Wikipedia iOS | ✅ | 1.4m | 24s | 6s | 56s | ⚡ 3s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29242781600) | 2026-07-13 10:31:22 |
| DuckDuckGo iOS | ✅ | 1.8m | 8s | 18s | 1.4m | ❗ 3s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29242781600) | 2026-07-13 10:33:34 |
| React Native (RN Tester) | ✅ | 3.3m | 25s | 51s | 2.1m | ❗ 45s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29242781600) | 2026-07-13 10:37:17 |
| Bluesky (social-app) | ✅ | 5.7m | 12s | 1.8m | 3.7m | ❗ 96s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29242781600) | 2026-07-13 10:43:28 |
| Mattermost Mobile | ✅ | 5.4m | 11s | 1.8m | 3.4m | ❗ 15s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29242781600) | 2026-07-13 10:49:29 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 13.1m | 10s | - | 12.9m | ❗ 185s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29242781600) | 2026-07-13 10:40:35 |
| Wikipedia iOS | ✅ | 8.6m | 12s | 40s | 7.7m | ❗ 123s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29242781600) | 2026-07-13 10:49:39 |
| DuckDuckGo iOS | ✅ | 13.7m | 8s | 2.5m | 11.0m | ❗ 329s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29242781600) | 2026-07-13 11:03:43 |
| React Native (RN Tester) | ✅ | 18.8m | 18s | 2.2m | 16.2m | ❗ 11s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29242781600) | 2026-07-13 11:23:09 |
| Bluesky (social-app) | ✅ | 27.4m | 10s | 3.4m | 23.9m | ⚡ 23s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29242781600) | 2026-07-13 11:51:11 |
| Mattermost Mobile | ✅ | 35.6m | 7s | 7.9m | 27.6m | ❗ 511s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29242781600) | 2026-07-13 12:27:50 |
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
