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
| XcodeBenchmark (anchor) | 1.9m | 20.0m | 10.6× |
| Wikipedia iOS | 1.5m | 6.7m | 4.3× |
| DuckDuckGo iOS | 2.4m | 9.1m | 3.8× |
| React Native (RN Tester) | 3.1m | 19.1m | 6.1× |
| Bluesky (social-app) | 3.7m | 26.4m | 7.1× |
| Mattermost Mobile | 4.3m | 25.7m | 6.0× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.9m | 14s | - | 1.6m | ⚡ 13s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27495947851) | 2026-06-14 10:29:18 |
| Wikipedia iOS | ✅ | 1.5m | 18s | 13s | 1.0m | ⚡ 3s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27495947851) | 2026-06-14 10:31:11 |
| DuckDuckGo iOS | ✅ | 2.4m | 7s | 46s | 1.5m | ❗ 62s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27495947851) | 2026-06-14 10:33:54 |
| React Native (RN Tester) | ✅ | 3.1m | 21s | 44s | 2.0m | ❗ 24s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27495947851) | 2026-06-14 10:37:22 |
| Bluesky (social-app) | ✅ | 3.7m | 9s | 39s | 2.9m | ⚡ 98s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27495947851) | 2026-06-14 10:41:34 |
| Mattermost Mobile | ✅ | 4.3m | 10s | 43s | 3.4m | ⚡ 38s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27495947851) | 2026-06-14 10:46:25 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 20.0m | 12s | - | 19.8m | ❗ 580s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27495947851) | 2026-06-14 10:47:11 |
| Wikipedia iOS | ✅ | 6.7m | 13s | 33s | 5.9m | ❗ 65s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27495947851) | 2026-06-14 10:54:28 |
| DuckDuckGo iOS | ✅ | 9.1m | 8s | 2.0m | 7.0m | ⚡ 32s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27495947851) | 2026-06-14 11:03:48 |
| React Native (RN Tester) | ✅ | 19.1m | 15s | 1.4m | 17.5m | ❗ 269s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27495947851) | 2026-06-14 11:23:13 |
| Bluesky (social-app) | ✅ | 26.4m | 5s | 3.1m | 23.2m | ❗ 270s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27495947851) | 2026-06-14 11:50:10 |
| Mattermost Mobile | ✅ | 25.7m | 7s | 6.7m | 18.9m | ⚡ 291s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27495947851) | 2026-06-14 12:16:27 |
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
