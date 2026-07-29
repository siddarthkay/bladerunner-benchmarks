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
| XcodeBenchmark (anchor) | 2.7m | 13.5m | 5.0× |
| Wikipedia iOS | 1.5m | 8.9m | 6.1× |
| DuckDuckGo iOS | 2.2m | 11.7m | 5.4× |
| React Native (RN Tester) | 3.2m | 20.1m | 6.3× |
| Bluesky (social-app) | 5.6m | 24.0m | 4.3× |
| Mattermost Mobile | 5.5m | 45.2m | 8.3× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.7m | 16s | - | 2.4m | ❗ 60s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30442640575) | 2026-07-29 10:14:23 |
| Wikipedia iOS | ✅ | 1.5m | 24s | 6s | 58s | ⚡ 8s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30442640575) | 2026-07-29 10:16:14 |
| DuckDuckGo iOS | ✅ | 2.2m | 9s | 42s | 1.3m | ⚡ 9s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30442640575) | 2026-07-29 10:18:49 |
| React Native (RN Tester) | ✅ | 3.2m | 23s | 49s | 2.0m | ❗ 20s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30442640575) | 2026-07-29 10:22:22 |
| Bluesky (social-app) | ✅ | 5.6m | 12s | 1.8m | 3.5m | ❗ 103s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30442640575) | 2026-07-29 10:28:26 |
| Mattermost Mobile | ✅ | 5.5m | 12s | 1.9m | 3.4m | ❗ 30s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30442640575) | 2026-07-29 10:34:34 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 13.5m | 14s | - | 13.2m | ⚡ 242s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30442640575) | 2026-07-29 10:24:56 |
| Wikipedia iOS | ✅ | 8.9m | 15s | 42s | 7.9m | ❗ 32s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30442640575) | 2026-07-29 10:34:20 |
| DuckDuckGo iOS | ✅ | 11.7m | 7s | 2.5m | 9.1m | ⚡ 15s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30442640575) | 2026-07-29 10:46:30 |
| React Native (RN Tester) | ✅ | 20.1m | 20s | 2.6m | 17.1m | ❗ 452s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30442640575) | 2026-07-29 11:07:12 |
| Bluesky (social-app) | ✅ | 24.0m | 9s | 3.6m | 20.2m | ❗ 125s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30442640575) | 2026-07-29 11:31:47 |
| Mattermost Mobile | ✅ | 45.2m | 7s | 10.2m | 34.9m | ⚡ 140s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30442640575) | 2026-07-29 12:17:46 |
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
