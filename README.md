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
| XcodeBenchmark (anchor) | 1.8m | 11.5m | 6.6× |
| Wikipedia iOS | 1.5m | 8.8m | 6.0× |
| DuckDuckGo iOS | 1.3m | 12.8m | 10.1× |
| React Native (RN Tester) | 2.5m | 18.0m | 7.2× |
| Bluesky (social-app) | 4.0m | 5.8m | - |
| Mattermost Mobile | 5.5m | 43.2m | 7.9× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.8m | 15s | - | 1.5m | ⚡ 44s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30899584887) | 2026-08-04 10:13:53 |
| Wikipedia iOS | ✅ | 1.5m | 24s | 7s | 57s | ⚡ 7s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30899584887) | 2026-08-04 10:15:45 |
| DuckDuckGo iOS | ✅ | 1.3m | 10s | 18s | 48s | ⚡ 2s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30899584887) | 2026-08-04 10:17:26 |
| React Native (RN Tester) | ✅ | 2.5m | 27s | 25s | 1.6m | ⚡ 51s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30899584887) | 2026-08-04 10:20:22 |
| Bluesky (social-app) | ✅ | 4.0m | 13s | 39s | 3.2m | ⚡ 25s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30899584887) | 2026-08-04 10:26:16 |
| Mattermost Mobile | ✅ | 5.5m | 12s | 2.0m | 3.3m | ❗ 85s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30899584887) | 2026-08-04 10:32:25 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 11.5m | 14s | - | 11.2m | ⚡ 128s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30899584887) | 2026-08-04 10:23:25 |
| Wikipedia iOS | ✅ | 8.8m | 15s | 45s | 7.8m | ❗ 102s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30899584887) | 2026-08-04 10:32:47 |
| DuckDuckGo iOS | ✅ | 12.8m | 6s | 2.2m | 10.5m | ❗ 33s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30899584887) | 2026-08-04 10:46:01 |
| React Native (RN Tester) | ✅ | 18.0m | 16s | 1.8m | 16.0m | ⚡ 111s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30899584887) | 2026-08-04 11:04:33 |
| Bluesky (social-app) | ❌ build | 5.8m | 8s | 2.8m | 2.9m | - | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30899584887) | 2026-08-04 11:10:51 |
| Mattermost Mobile | ✅ | 43.2m | 9s | 10.0m | 33.1m | ❗ 150s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30899584887) | 2026-08-04 11:54:41 |
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
