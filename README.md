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
| XcodeBenchmark (anchor) | 2.1m | 14.7m | 7.1× |
| Wikipedia iOS | 1.4m | 7.3m | 5.2× |
| DuckDuckGo iOS | 2.6m | 13.0m | 5.0× |
| React Native (RN Tester) | 2.6m | 14.2m | 5.4× |
| Bluesky (social-app) | 4.2m | 33.1m | 7.9× |
| Mattermost Mobile | 5.1m | 42.0m | 8.2× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.1m | 14s | - | 1.8m | ❗ 8s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28019736074) | 2026-06-23 10:32:02 |
| Wikipedia iOS | ✅ | 1.4m | 19s | 13s | 52s | ⚡ 25s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28019736074) | 2026-06-23 10:33:50 |
| DuckDuckGo iOS | ✅ | 2.6m | 8s | 40s | 1.8m | ❗ 73s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28019736074) | 2026-06-23 10:36:46 |
| React Native (RN Tester) | ✅ | 2.6m | 23s | 24s | 1.9m | ⚡ 144s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28019736074) | 2026-06-23 10:39:51 |
| Bluesky (social-app) | ✅ | 4.2m | 11s | 39s | 3.3m | ❗ 21s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28019736074) | 2026-06-23 10:44:32 |
| Mattermost Mobile | ✅ | 5.1m | 12s | 1.9m | 3.1m | ❗ 13s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28019736074) | 2026-06-23 10:50:16 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 14.7m | 12s | - | 14.5m | ⚡ 85s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28019736074) | 2026-06-23 10:44:26 |
| Wikipedia iOS | ✅ | 7.3m | 17s | 33s | 6.5m | ❗ 74s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28019736074) | 2026-06-23 10:52:13 |
| DuckDuckGo iOS | ✅ | 13.0m | 5s | 2.0m | 10.8m | ❗ 275s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28019736074) | 2026-06-23 11:05:42 |
| React Native (RN Tester) | ✅ | 14.2m | 13s | 1.4m | 12.7m | ⚡ 10s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28019736074) | 2026-06-23 11:20:29 |
| Bluesky (social-app) | ✅ | 33.1m | 6s | 2.8m | 30.2m | ⚡ 152s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28019736074) | 2026-06-23 11:54:03 |
| Mattermost Mobile | ✅ | 42.0m | 12s | 9.2m | 32.6m | ❗ 880s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28019736074) | 2026-06-23 12:38:43 |
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
