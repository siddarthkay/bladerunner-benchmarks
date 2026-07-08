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
| XcodeBenchmark (anchor) | 2.0m | 13.0m | 6.6× |
| Wikipedia iOS | 1.7m | 7.0m | 4.2× |
| DuckDuckGo iOS | 1.8m | 13.0m | 7.2× |
| React Native (RN Tester) | 2.9m | 15.2m | 5.2× |
| Bluesky (social-app) | 5.1m | 42.3m | 8.2× |
| Mattermost Mobile | 5.1m | 39.0m | 7.7× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.0m | 16s | - | 1.7m | ⚡ 19s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28934197841) | 2026-07-08 10:03:35 |
| Wikipedia iOS | ✅ | 1.7m | 20s | 7s | 1.3m | ❗ 12s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28934197841) | 2026-07-08 10:05:39 |
| DuckDuckGo iOS | ✅ | 1.8m | 8s | 18s | 1.4m | ❗ 27s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28934197841) | 2026-07-08 10:07:49 |
| React Native (RN Tester) | ✅ | 2.9m | 24s | 47s | 1.8m | ❗ 19s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28934197841) | 2026-07-08 10:11:10 |
| Bluesky (social-app) | ✅ | 5.1m | 11s | 1.8m | 3.2m | ⚡ 41s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28934197841) | 2026-07-08 10:16:47 |
| Mattermost Mobile | ✅ | 5.1m | 11s | 1.9m | 3.0m | ⚡ 1s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28934197841) | 2026-07-08 10:22:28 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 13.0m | 12s | - | 12.8m | ❗ 2s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28934197841) | 2026-07-08 10:14:17 |
| Wikipedia iOS | ✅ | 7.0m | 14s | 37s | 6.2m | ⚡ 94s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28934197841) | 2026-07-08 10:21:46 |
| DuckDuckGo iOS | ✅ | 13.0m | 5s | 2.2m | 10.6m | ❗ 32s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28934197841) | 2026-07-08 10:35:02 |
| React Native (RN Tester) | ✅ | 15.2m | 17s | 1.6m | 13.3m | ⚡ 277s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28934197841) | 2026-07-08 10:50:47 |
| Bluesky (social-app) | ✅ | 42.3m | 7s | 4.6m | 37.5m | ❗ 905s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28934197841) | 2026-07-08 11:33:42 |
| Mattermost Mobile | ✅ | 39.0m | 9s | 8.8m | 30.0m | ❗ 390s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28934197841) | 2026-07-08 12:13:34 |
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
