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
| XcodeBenchmark (anchor) | 1.7m | 17.9m | 10.6× |
| Wikipedia iOS | 1.7m | 5.0m | 3.0× |
| DuckDuckGo iOS | 3.0m | 9.7m | 3.2× |
| React Native (RN Tester) | 2.6m | 15.3m | 5.8× |
| Bluesky (social-app) | 4.0m | 29.0m | 7.3× |
| Mattermost Mobile | 4.5m | 30.3m | 6.7× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.7m | 16s | - | 1.4m | ⚡ 6s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27410817254) | 2026-06-12 10:47:17 |
| Wikipedia iOS | ✅ | 1.7m | 22s | 7s | 1.2m | ❗ 10s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27410817254) | 2026-06-12 10:49:17 |
| DuckDuckGo iOS | ✅ | 3.0m | 8s | 41s | 2.2m | ❗ 33s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27410817254) | 2026-06-12 10:52:40 |
| React Native (RN Tester) | ✅ | 2.6m | 22s | 27s | 1.8m | ⚡ 27s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27410817254) | 2026-06-12 10:55:42 |
| Bluesky (social-app) | ✅ | 4.0m | 10s | 39s | 3.2m | ⚡ 70s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27410817254) | 2026-06-12 11:00:10 |
| Mattermost Mobile | ✅ | 4.5m | 9s | 37s | 3.7m | ❗ 35s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27410817254) | 2026-06-12 11:05:19 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 17.9m | 13s | - | 17.7m | ❗ 297s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27410817254) | 2026-06-12 11:03:17 |
| Wikipedia iOS | ✅ | 5.0m | 13s | 25s | 4.3m | ⚡ 133s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27410817254) | 2026-06-12 11:08:39 |
| DuckDuckGo iOS | ✅ | 9.7m | 6s | 1.4m | 8.1m | ❗ 110s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27410817254) | 2026-06-12 11:18:39 |
| React Native (RN Tester) | ✅ | 15.3m | 15s | 1.5m | 13.6m | ⚡ 112s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27410817254) | 2026-06-12 11:34:17 |
| Bluesky (social-app) | ✅ | 29.0m | 6s | 3.4m | 25.4m | ⚡ 242s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27410817254) | 2026-06-12 12:03:42 |
| Mattermost Mobile | ✅ | 30.3m | 8s | 8.0m | 22.2m | ⚡ 321s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27410817254) | 2026-06-12 12:34:42 |
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
