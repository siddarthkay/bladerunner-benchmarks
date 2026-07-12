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
| XcodeBenchmark (anchor) | 2.4m | 10.0m | 4.2× |
| Wikipedia iOS | 1.5m | 6.5m | 4.4× |
| DuckDuckGo iOS | 1.8m | 8.2m | 4.7× |
| React Native (RN Tester) | 2.6m | 18.6m | 7.2× |
| Bluesky (social-app) | 4.1m | 27.8m | 6.8× |
| Mattermost Mobile | 5.1m | 27.1m | 5.3× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.4m | 15s | - | 2.1m | ⚡ 61s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29188289882) | 2026-07-12 09:59:11 |
| Wikipedia iOS | ✅ | 1.5m | 18s | 13s | 58s | ⚡ 10s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29188289882) | 2026-07-12 10:01:01 |
| DuckDuckGo iOS | ✅ | 1.8m | 8s | 17s | 1.3m | ⚡ 31s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29188289882) | 2026-07-12 10:03:06 |
| React Native (RN Tester) | ✅ | 2.6m | 24s | 28s | 1.7m | ⚡ 14s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29188289882) | 2026-07-12 10:06:05 |
| Bluesky (social-app) | ✅ | 4.1m | 9s | 38s | 3.3m | ⚡ 1s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29188289882) | 2026-07-12 10:10:38 |
| Mattermost Mobile | ✅ | 5.1m | 11s | 2.0m | 2.9m | ❗ 3s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29188289882) | 2026-07-12 10:16:24 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 10.0m | 10s | - | 9.8m | ⚡ 555s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29188289882) | 2026-07-12 10:06:31 |
| Wikipedia iOS | ✅ | 6.5m | 12s | 29s | 5.9m | ⚡ 24s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29188289882) | 2026-07-12 10:13:19 |
| DuckDuckGo iOS | ✅ | 8.2m | 7s | 1.6m | 6.4m | ⚡ 91s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29188289882) | 2026-07-12 10:21:52 |
| React Native (RN Tester) | ✅ | 18.6m | 19s | 2.4m | 15.8m | ⚡ 54s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29188289882) | 2026-07-12 10:40:48 |
| Bluesky (social-app) | ✅ | 27.8m | 8s | 3.1m | 24.6m | ⚡ 157s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29188289882) | 2026-07-12 11:09:11 |
| Mattermost Mobile | ✅ | 27.1m | 9s | 6.9m | 20.0m | ❗ 13s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29188289882) | 2026-07-12 11:36:49 |
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
