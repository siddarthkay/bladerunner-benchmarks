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
| XcodeBenchmark (anchor) | 1.8m | 14.2m | 8.0× |
| Wikipedia iOS | 57s | 10.9m | - |
| DuckDuckGo iOS | 1.9m | 12.1m | 6.5× |
| React Native (RN Tester) | 2.8m | 17.7m | 6.4× |
| Bluesky (social-app) | 5.1m | 35.3m | 7.0× |
| Mattermost Mobile | 3.8m | 38.1m | 9.9× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.8m | 17s | - | 1.5m | ⚡ 25s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34584379527) | 2026-09-11 09:31:05 |
| Wikipedia iOS | ❌ build | 57s | 20s | 14s | 24s | - | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34584379527) | 2026-09-11 09:32:26 |
| DuckDuckGo iOS | ✅ | 1.9m | 8s | 18s | 1.4m | ⚡ 15s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34584379527) | 2026-09-11 09:34:38 |
| React Native (RN Tester) | ✅ | 2.8m | 24s | 49s | 1.6m | ❗ 8s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34584379527) | 2026-09-11 09:37:48 |
| Bluesky (social-app) | ✅ | 5.1m | 12s | 1.8m | 3.1m | ⚡ 9s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34584379527) | 2026-09-11 09:43:20 |
| Mattermost Mobile | ✅ | 3.8m | 11s | 44s | 2.9m | ⚡ 88s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34584379527) | 2026-09-11 09:47:48 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 14.2m | 13s | - | 14.0m | ⚡ 231s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34584379527) | 2026-09-11 09:43:28 |
| Wikipedia iOS | ✅ | 10.9m | 17s | 46s | 9.9m | ❗ 191s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34584379527) | 2026-09-11 09:54:59 |
| DuckDuckGo iOS | ✅ | 12.1m | 7s | 2.0m | 9.9m | ❗ 4s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34584379527) | 2026-09-11 10:07:39 |
| React Native (RN Tester) | ✅ | 17.7m | 15s | 2.2m | 15.3m | ⚡ 355s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34584379527) | 2026-09-11 10:25:57 |
| Bluesky (social-app) | ✅ | 35.3m | 7s | 4.5m | 30.8m | ❗ 70s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34584379527) | 2026-09-11 11:01:59 |
| Mattermost Mobile | ✅ | 38.1m | 9s | 8.9m | 29.1m | ❗ 708s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34584379527) | 2026-09-11 11:41:26 |
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
