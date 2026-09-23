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
| XcodeBenchmark (anchor) | 2.3m | 14.9m | 6.5× |
| Wikipedia iOS | 56s | 8.3m | - |
| DuckDuckGo iOS | 1.8m | 12.9m | 7.0× |
| React Native (RN Tester) | 3.0m | 21.7m | 7.3× |
| Bluesky (social-app) | 4.0m | 21.4m | 5.4× |
| Mattermost Mobile | 5.3m | 36.4m | 6.9× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.3m | 16s | - | 2.0m | ❗ 36s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35843247890) | 2026-09-23 09:32:47 |
| Wikipedia iOS | ❌ build | 56s | 25s | 14s | 17s | - | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35843247890) | 2026-09-23 09:34:05 |
| DuckDuckGo iOS | ✅ | 1.8m | 8s | 19s | 1.4m | ⚡ 21s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35843247890) | 2026-09-23 09:36:18 |
| React Native (RN Tester) | ✅ | 3.0m | 23s | 57s | 1.7m | ❗ 1s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35843247890) | 2026-09-23 09:39:39 |
| Bluesky (social-app) | ✅ | 4.0m | 10s | 39s | 3.2m | ⚡ 7s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35843247890) | 2026-09-23 09:44:10 |
| Mattermost Mobile | ✅ | 5.3m | 10s | 2.1m | 3.0m | ❗ 70s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35843247890) | 2026-09-23 09:50:07 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 14.9m | 11s | - | 14.8m | ❗ 102s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35843247890) | 2026-09-23 09:45:10 |
| Wikipedia iOS | ✅ | 8.3m | 18s | 36s | 7.5m | ⚡ 28s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35843247890) | 2026-09-23 09:54:04 |
| DuckDuckGo iOS | ✅ | 12.9m | 7s | 2.6m | 10.2m | ⚡ 44s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35843247890) | 2026-09-23 10:07:26 |
| React Native (RN Tester) | ✅ | 21.7m | 18s | 2.3m | 19.1m | ⚡ 659s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35843247890) | 2026-09-23 10:29:46 |
| Bluesky (social-app) | ✅ | 21.4m | 7s | 2.5m | 18.8m | ⚡ 259s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35843247890) | 2026-09-23 10:51:41 |
| Mattermost Mobile | ✅ | 36.4m | 8s | 8.0m | 28.3m | ⚡ 74s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35843247890) | 2026-09-23 11:28:44 |
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
