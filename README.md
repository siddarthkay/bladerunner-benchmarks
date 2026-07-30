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
| XcodeBenchmark (anchor) | 2.8m | 16.6m | 6.0× |
| Wikipedia iOS | 1.4m | 8.6m | 6.0× |
| DuckDuckGo iOS | 1.9m | 12.7m | 6.8× |
| React Native (RN Tester) | 2.5m | 16.6m | 6.5× |
| Bluesky (social-app) | 5.2m | 15.3m | - |
| Mattermost Mobile | 5.0m | 39.0m | 7.8× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.8m | 15s | - | 2.5m | ❗ 4s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30533227817) | 2026-07-30 10:07:48 |
| Wikipedia iOS | ✅ | 1.4m | 23s | 7s | 57s | ⚡ 1s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30533227817) | 2026-07-30 10:09:38 |
| DuckDuckGo iOS | ✅ | 1.9m | 7s | 18s | 1.5m | ⚡ 18s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30533227817) | 2026-07-30 10:11:52 |
| React Native (RN Tester) | ✅ | 2.5m | 24s | 24s | 1.7m | ⚡ 38s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30533227817) | 2026-07-30 10:14:49 |
| Bluesky (social-app) | ✅ | 5.2m | 12s | 1.8m | 3.2m | ⚡ 20s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30533227817) | 2026-07-30 10:20:33 |
| Mattermost Mobile | ✅ | 5.0m | 11s | 1.8m | 3.0m | ⚡ 26s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30533227817) | 2026-07-30 10:26:09 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 16.6m | 11s | - | 16.4m | ❗ 186s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30533227817) | 2026-07-30 10:21:19 |
| Wikipedia iOS | ✅ | 8.6m | 14s | 44s | 7.7m | ⚡ 15s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30533227817) | 2026-07-30 10:30:21 |
| DuckDuckGo iOS | ✅ | 12.7m | 6s | 1.9m | 10.7m | ❗ 57s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30533227817) | 2026-07-30 10:43:27 |
| React Native (RN Tester) | ✅ | 16.6m | 16s | 1.6m | 14.7m | ⚡ 207s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30533227817) | 2026-07-30 11:00:32 |
| Bluesky (social-app) | ❌ build | 15.3m | 8s | 3.1m | 12.1m | - | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30533227817) | 2026-07-30 11:16:17 |
| Mattermost Mobile | ✅ | 39.0m | 9s | 9.1m | 29.8m | ⚡ 372s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30533227817) | 2026-07-30 11:55:57 |
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
