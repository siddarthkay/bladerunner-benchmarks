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
| XcodeBenchmark (anchor) | 1.6m | 17.9m | 10.9× |
| Wikipedia iOS | 1.5m | 7.7m | 5.2× |
| DuckDuckGo iOS | 2.1m | 14.4m | 6.9× |
| React Native (RN Tester) | 2.6m | 22.3m | 8.4× |
| Bluesky (social-app) | 3.7m | 6.9m | - |
| Mattermost Mobile | 4.7m | 41.3m | 8.9× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.6m | 15s | - | 1.4m | ⚡ 11s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31376328326) | 2026-08-10 09:51:12 |
| Wikipedia iOS | ✅ | 1.5m | 26s | 6s | 57s | ⚡ 2s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31376328326) | 2026-08-10 09:53:04 |
| DuckDuckGo iOS | ✅ | 2.1m | 8s | 43s | 1.2m | ❗ 18s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31376328326) | 2026-08-10 09:55:32 |
| React Native (RN Tester) | ✅ | 2.6m | 22s | 26s | 1.8m | ⚡ 25s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31376328326) | 2026-08-10 09:58:35 |
| Bluesky (social-app) | ✅ | 3.7m | 12s | 38s | 2.9m | ⚡ 82s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31376328326) | 2026-08-10 10:02:50 |
| Mattermost Mobile | ✅ | 4.7m | 12s | 40s | 3.8m | ❗ 54s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31376328326) | 2026-08-10 10:08:07 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 17.9m | 12s | - | 17.7m | ❗ 240s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31376328326) | 2026-08-10 10:07:12 |
| Wikipedia iOS | ✅ | 7.7m | 14s | 53s | 6.5m | ⚡ 131s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31376328326) | 2026-08-10 10:15:27 |
| DuckDuckGo iOS | ✅ | 14.4m | 7s | 2.7m | 11.6m | ❗ 196s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31376328326) | 2026-08-10 10:30:18 |
| React Native (RN Tester) | ✅ | 22.3m | 17s | 2.5m | 19.5m | ❗ 93s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31376328326) | 2026-08-10 10:53:20 |
| Bluesky (social-app) | ❌ build | 6.9m | 6s | 3.1m | 3.6m | - | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31376328326) | 2026-08-10 11:00:41 |
| Mattermost Mobile | ✅ | 41.3m | 10s | 10.7m | 30.4m | ❗ 771s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31376328326) | 2026-08-10 11:43:01 |
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
