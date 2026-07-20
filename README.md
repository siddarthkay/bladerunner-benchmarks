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
| XcodeBenchmark (anchor) | 2.3m | 17.2m | 7.5× |
| Wikipedia iOS | 1.4m | 8.0m | 5.6× |
| DuckDuckGo iOS | 2.4m | 9.5m | 4.0× |
| React Native (RN Tester) | 3.3m | 18.7m | 5.6× |
| Bluesky (social-app) | 5.5m | 41.5m | 7.5× |
| Mattermost Mobile | 5.6m | 31.4m | 5.6× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.3m | 17s | - | 2.0m | ❗ 36s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29734704215) | 2026-07-20 10:23:28 |
| Wikipedia iOS | ✅ | 1.4m | 23s | 7s | 56s | ⚡ 2s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29734704215) | 2026-07-20 10:25:19 |
| DuckDuckGo iOS | ✅ | 2.4m | 9s | 41s | 1.5m | ⚡ 21s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29734704215) | 2026-07-20 10:28:03 |
| React Native (RN Tester) | ✅ | 3.3m | 27s | 50s | 2.0m | ❗ 12s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29734704215) | 2026-07-20 10:31:46 |
| Bluesky (social-app) | ✅ | 5.5m | 13s | 1.9m | 3.4m | ❗ 101s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29734704215) | 2026-07-20 10:37:48 |
| Mattermost Mobile | ✅ | 5.6m | 11s | 2.0m | 3.5m | ❗ 14s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29734704215) | 2026-07-20 10:44:02 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 17.2m | 14s | - | 16.9m | ❗ 69s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29734704215) | 2026-07-20 10:38:05 |
| Wikipedia iOS | ✅ | 8.0m | 14s | 36s | 7.2m | ❗ 160s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29734704215) | 2026-07-20 10:46:40 |
| DuckDuckGo iOS | ✅ | 9.5m | 5s | 1.8m | 7.7m | ⚡ 210s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29734704215) | 2026-07-20 10:56:34 |
| React Native (RN Tester) | ✅ | 18.7m | 25s | 2.4m | 16.0m | ❗ 225s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29734704215) | 2026-07-20 11:15:48 |
| Bluesky (social-app) | ✅ | 41.5m | 9s | 4.5m | 36.9m | ❗ 268s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29734704215) | 2026-07-20 11:57:50 |
| Mattermost Mobile | ✅ | 31.4m | 7s | 7.1m | 24.2m | ⚡ 78s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29734704215) | 2026-07-20 12:30:23 |
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
