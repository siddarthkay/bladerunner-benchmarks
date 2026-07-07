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
| XcodeBenchmark (anchor) | 2.3m | 13.0m | 5.6× |
| Wikipedia iOS | 1.5m | 8.6m | 5.8× |
| DuckDuckGo iOS | 1.4m | 12.4m | 9.2× |
| React Native (RN Tester) | 2.6m | 19.8m | 7.6× |
| Bluesky (social-app) | 5.8m | 27.2m | 4.7× |
| Mattermost Mobile | 5.1m | 32.5m | 6.4× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.3m | 16s | - | 2.0m | ❗ 32s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28859328664) | 2026-07-07 10:29:48 |
| Wikipedia iOS | ✅ | 1.5m | 20s | 13s | 57s | ⚡ 11s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28859328664) | 2026-07-07 10:31:40 |
| DuckDuckGo iOS | ✅ | 1.4m | 8s | 18s | 55s | ⚡ 64s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28859328664) | 2026-07-07 10:33:22 |
| React Native (RN Tester) | ✅ | 2.6m | 22s | 25s | 1.9m | ⚡ 11s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28859328664) | 2026-07-07 10:36:22 |
| Bluesky (social-app) | ✅ | 5.8m | 10s | 2.4m | 3.2m | ❗ 35s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28859328664) | 2026-07-07 10:42:42 |
| Mattermost Mobile | ✅ | 5.1m | 10s | 1.9m | 3.0m | ❗ 15s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28859328664) | 2026-07-07 10:48:23 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 13.0m | 11s | - | 12.8m | ❗ 83s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28859328664) | 2026-07-07 10:40:17 |
| Wikipedia iOS | ✅ | 8.6m | 17s | 39s | 7.7m | ⚡ 43s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28859328664) | 2026-07-07 10:49:22 |
| DuckDuckGo iOS | ✅ | 12.4m | 6s | 1.8m | 10.5m | ⚡ 70s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28859328664) | 2026-07-07 11:02:16 |
| React Native (RN Tester) | ✅ | 19.8m | 15s | 1.7m | 17.9m | ❗ 192s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28859328664) | 2026-07-07 11:22:37 |
| Bluesky (social-app) | ✅ | 27.2m | 6s | 2.8m | 24.3m | ⚡ 324s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28859328664) | 2026-07-07 11:50:19 |
| Mattermost Mobile | ✅ | 32.5m | 8s | 9.9m | 22.4m | ⚡ 405s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28859328664) | 2026-07-07 12:23:24 |
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
