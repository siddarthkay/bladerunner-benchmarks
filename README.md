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
| XcodeBenchmark (anchor) | 2.3m | 15.4m | 6.8× |
| Wikipedia iOS | 1.6m | 6.1m | 3.8× |
| DuckDuckGo iOS | 2.7m | 9.3m | 3.4× |
| React Native (RN Tester) | 3.2m | 25.6m | 7.9× |
| Bluesky (social-app) | 4.0m | 27.5m | 6.8× |
| Mattermost Mobile | 4.8m | 37.8m | 7.8× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.3m | 15s | - | 2.0m | ±0s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27821477125) | 2026-06-19 10:57:18 |
| Wikipedia iOS | ✅ | 1.6m | 25s | 13s | 58s | ⚡ 16s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27821477125) | 2026-06-19 10:59:17 |
| DuckDuckGo iOS | ✅ | 2.7m | 7s | 46s | 1.9m | ❗ 31s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27821477125) | 2026-06-19 11:02:27 |
| React Native (RN Tester) | ✅ | 3.2m | 23s | 49s | 2.0m | ⚡ 8s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27821477125) | 2026-06-19 11:06:03 |
| Bluesky (social-app) | ✅ | 4.0m | 9s | 38s | 3.2m | ⚡ 64s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27821477125) | 2026-06-19 11:10:35 |
| Mattermost Mobile | ✅ | 4.8m | 9s | 40s | 4.0m | ⚡ 76s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27821477125) | 2026-06-19 11:16:04 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 15.4m | 14s | - | 15.2m | ❗ 275s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27821477125) | 2026-06-19 11:10:09 |
| Wikipedia iOS | ✅ | 6.1m | 12s | 27s | 5.5m | ⚡ 129s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27821477125) | 2026-06-19 11:16:41 |
| DuckDuckGo iOS | ✅ | 9.3m | 6s | 1.8m | 7.4m | ⚡ 274s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27821477125) | 2026-06-19 11:26:21 |
| React Native (RN Tester) | ✅ | 25.6m | 17s | 2.4m | 23.0m | ❗ 201s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27821477125) | 2026-06-19 11:52:29 |
| Bluesky (social-app) | ✅ | 27.5m | 8s | 3.7m | 23.6m | ⚡ 53s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27821477125) | 2026-06-19 12:20:40 |
| Mattermost Mobile | ✅ | 37.8m | 9s | 8.8m | 28.8m | ❗ 98s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27821477125) | 2026-06-19 12:59:07 |
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
