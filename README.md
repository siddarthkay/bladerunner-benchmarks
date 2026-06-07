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
| XcodeBenchmark (anchor) | 2.2m | 10.4m | 4.7× |
| Wikipedia iOS | 1.5m | 6.5m | 4.4× |
| DuckDuckGo iOS | 1.3m | 11.4m | 8.6× |
| React Native (RN Tester) | 3.8m | 14.1m | 3.7× |
| Bluesky (social-app) | 5.2m | 30.5m | 5.8× |
| Mattermost Mobile | 4.0m | 30.2m | 7.6× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.2m | 15s | - | 2.0m | ❗ 15s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27089575369) | 2026-06-07 10:15:18 |
| Wikipedia iOS | ✅ | 1.5m | 20s | 13s | 57s | ❗ 9s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27089575369) | 2026-06-07 10:17:07 |
| DuckDuckGo iOS | ✅ | 1.3m | 7s | 18s | 55s | ❗ 4s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27089575369) | 2026-06-07 10:18:48 |
| React Native (RN Tester) | ✅ | 3.8m | 21s | 1.4m | 2.0m | ❗ 53s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27089575369) | 2026-06-07 10:23:03 |
| Bluesky (social-app) | ✅ | 5.2m | 9s | 1.8m | 3.3m | ❗ 75s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27089575369) | 2026-06-07 10:28:45 |
| Mattermost Mobile | ✅ | 4.0m | 9s | 37s | 3.2m | ⚡ 76s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27089575369) | 2026-06-07 10:33:19 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 10.4m | 10s | - | 10.3m | ⚡ 121s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27089575369) | 2026-06-07 10:23:13 |
| Wikipedia iOS | ✅ | 6.5m | 11s | 24s | 5.9m | ❗ 26s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27089575369) | 2026-06-07 10:30:03 |
| DuckDuckGo iOS | ✅ | 11.4m | 5s | 1.8m | 9.5m | ❗ 184s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27089575369) | 2026-06-07 10:41:45 |
| React Native (RN Tester) | ✅ | 14.1m | 12s | 1.4m | 12.5m | ❗ 67s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27089575369) | 2026-06-07 10:56:16 |
| Bluesky (social-app) | ✅ | 30.5m | 7s | 4.4m | 26.1m | ❗ 185s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27089575369) | 2026-06-07 11:27:21 |
| Mattermost Mobile | ✅ | 30.2m | 6s | 7.0m | 23.1m | ❗ 170s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27089575369) | 2026-06-07 11:58:08 |
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
