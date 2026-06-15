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
| XcodeBenchmark (anchor) | 3.4m | 17.2m | 5.0× |
| Wikipedia iOS | 1.6m | 6.5m | 4.1× |
| DuckDuckGo iOS | 1.3m | 7.6m | 5.8× |
| React Native (RN Tester) | 2.9m | 19.1m | 6.5× |
| Bluesky (social-app) | 4.0m | 34.7m | 8.7× |
| Mattermost Mobile | 5.5m | 32.6m | 6.0× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 3.4m | 15s | - | 3.2m | ❗ 91s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27542778486) | 2026-06-15 11:26:03 |
| Wikipedia iOS | ✅ | 1.6m | 19s | 13s | 1.0m | ❗ 1s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27542778486) | 2026-06-15 11:28:00 |
| DuckDuckGo iOS | ✅ | 1.3m | 8s | 19s | 53s | ⚡ 63s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27542778486) | 2026-06-15 11:29:41 |
| React Native (RN Tester) | ✅ | 2.9m | 24s | 52s | 1.6m | ⚡ 11s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27542778486) | 2026-06-15 11:32:57 |
| Bluesky (social-app) | ✅ | 4.0m | 10s | 39s | 3.2m | ❗ 15s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27542778486) | 2026-06-15 11:37:26 |
| Mattermost Mobile | ✅ | 5.5m | 10s | 1.9m | 3.4m | ❗ 72s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27542778486) | 2026-06-15 11:43:32 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 17.2m | 15s | - | 16.9m | ⚡ 168s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27542778486) | 2026-06-15 11:39:31 |
| Wikipedia iOS | ✅ | 6.5m | 13s | 23s | 5.9m | ⚡ 13s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27542778486) | 2026-06-15 11:46:25 |
| DuckDuckGo iOS | ✅ | 7.6m | 4s | 1.3m | 6.3m | ⚡ 89s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27542778486) | 2026-06-15 11:54:20 |
| React Native (RN Tester) | ✅ | 19.1m | 21s | 2.5m | 16.2m | ±0s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27542778486) | 2026-06-15 12:13:54 |
| Bluesky (social-app) | ✅ | 34.7m | 6s | 3.3m | 31.4m | ❗ 497s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27542778486) | 2026-06-15 12:49:13 |
| Mattermost Mobile | ✅ | 32.6m | 8s | 9.0m | 23.5m | ❗ 416s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27542778486) | 2026-06-15 13:22:53 |
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
