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
| XcodeBenchmark (anchor) | 1.8m | 17.3m | 9.7× |
| Wikipedia iOS | 1.7m | 8.3m | 5.0× |
| DuckDuckGo iOS | 2.4m | 10.8m | 4.5× |
| React Native (RN Tester) | 3.3m | 19.6m | 5.9× |
| Bluesky (social-app) | 5.8m | 35.7m | 6.2× |
| Mattermost Mobile | 5.5m | 32.5m | 5.9× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.8m | 18s | - | 1.5m | ⚡ 11s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33378321800) | 2026-08-31 09:36:45 |
| Wikipedia iOS | ✅ | 1.7m | 41s | 7s | 52s | ❗ 11s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33378321800) | 2026-08-31 09:38:48 |
| DuckDuckGo iOS | ✅ | 2.4m | 11s | 44s | 1.5m | ❗ 28s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33378321800) | 2026-08-31 09:41:33 |
| React Native (RN Tester) | ✅ | 3.3m | 29s | 55s | 1.9m | ❗ 8s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33378321800) | 2026-08-31 09:45:18 |
| Bluesky (social-app) | ✅ | 5.8m | 13s | 2.2m | 3.3m | ❗ 119s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33378321800) | 2026-08-31 09:51:36 |
| Mattermost Mobile | ✅ | 5.5m | 13s | 2.2m | 3.0m | ⚡ 8s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33378321800) | 2026-08-31 09:57:40 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 17.3m | 14s | - | 17.1m | ❗ 438s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33378321800) | 2026-08-31 09:52:07 |
| Wikipedia iOS | ✅ | 8.3m | 18s | 45s | 7.3m | ❗ 121s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33378321800) | 2026-08-31 10:00:57 |
| DuckDuckGo iOS | ✅ | 10.8m | 7s | 2.1m | 8.6m | ⚡ 13s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33378321800) | 2026-08-31 10:12:09 |
| React Native (RN Tester) | ✅ | 19.6m | 17s | 1.8m | 17.5m | ❗ 360s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33378321800) | 2026-08-31 10:32:20 |
| Bluesky (social-app) | ✅ | 35.7m | 8s | 3.2m | 32.4m | ❗ 560s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33378321800) | 2026-08-31 11:08:42 |
| Mattermost Mobile | ✅ | 32.5m | 8s | 7.0m | 25.4m | ❗ 237s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33378321800) | 2026-08-31 11:42:16 |
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
