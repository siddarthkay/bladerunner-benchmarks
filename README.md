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
| XcodeBenchmark (anchor) | 1.8m | 10.4m | 5.9× |
| Wikipedia iOS | 53s | 7.8m | - |
| DuckDuckGo iOS | 1.8m | 9.1m | 5.0× |
| React Native (RN Tester) | 3.2m | 14.1m | 4.4× |
| Bluesky (social-app) | 5.1m | 27.8m | 5.5× |
| Mattermost Mobile | 3.9m | 35.9m | 9.2× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.8m | 15s | - | 1.5m | ⚡ 40s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35434662819) | 2026-09-19 09:28:18 |
| Wikipedia iOS | ❌ build | 53s | 21s | 13s | 18s | - | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35434662819) | 2026-09-19 09:29:31 |
| DuckDuckGo iOS | ✅ | 1.8m | 7s | 18s | 1.4m | ⚡ 22s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35434662819) | 2026-09-19 09:31:38 |
| React Native (RN Tester) | ✅ | 3.2m | 26s | 51s | 1.9m | ❗ 27s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35434662819) | 2026-09-19 09:35:14 |
| Bluesky (social-app) | ✅ | 5.1m | 9s | 1.8m | 3.1m | ⚡ 25s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35434662819) | 2026-09-19 09:40:48 |
| Mattermost Mobile | ✅ | 3.9m | 10s | 52s | 2.8m | ⚡ 78s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35434662819) | 2026-09-19 09:45:14 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 10.4m | 10s | - | 10.3m | ⚡ 231s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35434662819) | 2026-09-19 09:36:48 |
| Wikipedia iOS | ✅ | 7.8m | 14s | 36s | 7.0m | ❗ 89s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35434662819) | 2026-09-19 09:44:58 |
| DuckDuckGo iOS | ✅ | 9.1m | 5s | 1.7m | 7.3m | ⚡ 228s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35434662819) | 2026-09-19 09:54:27 |
| React Native (RN Tester) | ✅ | 14.1m | 19s | 1.9m | 11.9m | ⚡ 542s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35434662819) | 2026-09-19 10:08:58 |
| Bluesky (social-app) | ✅ | 27.8m | 6s | 3.1m | 24.6m | ❗ 360s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35434662819) | 2026-09-19 10:37:11 |
| Mattermost Mobile | ✅ | 35.9m | 8s | 9.0m | 26.8m | ⚡ 50s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35434662819) | 2026-09-19 11:13:55 |
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
