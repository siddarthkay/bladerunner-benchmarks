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
| XcodeBenchmark (anchor) | 1.9m | 17.4m | 9.4× |
| Wikipedia iOS | 1.7m | 6.6m | 3.8× |
| DuckDuckGo iOS | 2.5m | 12.7m | 5.0× |
| React Native (RN Tester) | 3.2m | 20.2m | 6.2× |
| Bluesky (social-app) | 5.4m | 32.3m | 6.0× |
| Mattermost Mobile | 4.0m | 34.8m | 8.7× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.9m | 17s | - | 1.6m | ⚡ 2s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32711971979) | 2026-08-24 09:33:42 |
| Wikipedia iOS | ✅ | 1.7m | 32s | 13s | 59s | ❗ 3s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32711971979) | 2026-08-24 09:35:49 |
| DuckDuckGo iOS | ✅ | 2.5m | 10s | 50s | 1.5m | ❗ 26s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32711971979) | 2026-08-24 09:38:42 |
| React Native (RN Tester) | ✅ | 3.2m | 25s | 47s | 2.0m | ❗ 38s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32711971979) | 2026-08-24 09:42:19 |
| Bluesky (social-app) | ✅ | 5.4m | 12s | 2.0m | 3.2m | ❗ 92s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32711971979) | 2026-08-24 09:48:14 |
| Mattermost Mobile | ✅ | 4.0m | 15s | 42s | 3.1m | ⚡ 46s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32711971979) | 2026-08-24 09:52:53 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 17.4m | 13s | - | 17.2m | ❗ 95s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32711971979) | 2026-08-24 09:49:05 |
| Wikipedia iOS | ✅ | 6.6m | 14s | 38s | 5.8m | ❗ 69s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32711971979) | 2026-08-24 09:56:17 |
| DuckDuckGo iOS | ✅ | 12.7m | 7s | 1.8m | 10.8m | ❗ 220s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32711971979) | 2026-08-24 10:09:21 |
| React Native (RN Tester) | ✅ | 20.2m | 19s | 2.3m | 17.5m | ⚡ 71s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32711971979) | 2026-08-24 10:30:09 |
| Bluesky (social-app) | ✅ | 32.3m | 8s | 3.4m | 28.8m | ❗ 561s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32711971979) | 2026-08-24 11:03:01 |
| Mattermost Mobile | ✅ | 34.8m | 10s | 8.0m | 26.6m | ❗ 190s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32711971979) | 2026-08-24 11:38:30 |
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
