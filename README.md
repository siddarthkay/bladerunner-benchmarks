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
| XcodeBenchmark (anchor) | 1.8m | 13.9m | 7.6× |
| Wikipedia iOS | 1.5m | 9.8m | 6.5× |
| DuckDuckGo iOS | 1.8m | 11.2m | 6.2× |
| React Native (RN Tester) | 3.1m | 20.7m | 6.8× |
| Bluesky (social-app) | 5.1m | 7.4m | - |
| Mattermost Mobile | 3.8m | 28.5m | 7.6× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.8m | 15s | - | 1.6m | ❗ 11s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31305998193) | 2026-08-09 09:31:19 |
| Wikipedia iOS | ✅ | 1.5m | 23s | 13s | 54s | ❗ 3s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31305998193) | 2026-08-09 09:33:12 |
| DuckDuckGo iOS | ✅ | 1.8m | 9s | 18s | 1.3m | ❗ 29s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31305998193) | 2026-08-09 09:35:20 |
| React Native (RN Tester) | ✅ | 3.1m | 32s | 54s | 1.6m | ❗ 41s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31305998193) | 2026-08-09 09:38:51 |
| Bluesky (social-app) | ✅ | 5.1m | 10s | 1.8m | 3.2m | ❗ 75s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31305998193) | 2026-08-09 09:44:27 |
| Mattermost Mobile | ✅ | 3.8m | 14s | 45s | 2.8m | ⚡ 103s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31305998193) | 2026-08-09 09:48:48 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 13.9m | 12s | - | 13.7m | ❗ 172s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31305998193) | 2026-08-09 09:43:16 |
| Wikipedia iOS | ✅ | 9.8m | 15s | 39s | 8.9m | ❗ 131s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31305998193) | 2026-08-09 09:53:27 |
| DuckDuckGo iOS | ✅ | 11.2m | 5s | 1.6m | 9.5m | ❗ 4s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31305998193) | 2026-08-09 10:05:05 |
| React Native (RN Tester) | ✅ | 20.7m | 15s | 1.7m | 18.8m | ❗ 386s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31305998193) | 2026-08-09 10:26:16 |
| Bluesky (social-app) | ❌ build | 7.4m | 10s | 3.5m | 3.8m | - | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31305998193) | 2026-08-09 10:34:17 |
| Mattermost Mobile | ✅ | 28.5m | 8s | 7.1m | 21.2m | ⚡ 165s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31305998193) | 2026-08-09 11:03:26 |
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
