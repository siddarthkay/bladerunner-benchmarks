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
| XcodeBenchmark (anchor) | 1.8m | 13.7m | 7.5× |
| Wikipedia iOS | 1.5m | 7.6m | 5.0× |
| DuckDuckGo iOS | 2.0m | 11.6m | 5.7× |
| React Native (RN Tester) | 2.8m | 26.9m | 9.8× |
| Bluesky (social-app) | 5.1m | 27.1m | 5.3× |
| Mattermost Mobile | 3.6m | 32.5m | 9.0× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.8m | 16s | - | 1.6m | ❗ 6s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32468029618) | 2026-08-21 09:30:52 |
| Wikipedia iOS | ✅ | 1.5m | 25s | 13s | 54s | ⚡ 12s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32468029618) | 2026-08-21 09:32:45 |
| DuckDuckGo iOS | ✅ | 2.0m | 8s | 18s | 1.6m | ⚡ 11s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32468029618) | 2026-08-21 09:35:07 |
| React Native (RN Tester) | ✅ | 2.8m | 24s | 45s | 1.6m | ⚡ 27s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32468029618) | 2026-08-21 09:38:16 |
| Bluesky (social-app) | ✅ | 5.1m | 10s | 1.8m | 3.1m | ❗ 62s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32468029618) | 2026-08-21 09:43:52 |
| Mattermost Mobile | ✅ | 3.6m | 10s | 42s | 2.7m | ⚡ 116s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32468029618) | 2026-08-21 09:48:03 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 13.7m | 12s | - | 13.5m | ⚡ 80s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32468029618) | 2026-08-21 09:42:24 |
| Wikipedia iOS | ✅ | 7.6m | 15s | 40s | 6.7m | ⚡ 64s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32468029618) | 2026-08-21 09:50:21 |
| DuckDuckGo iOS | ✅ | 11.6m | 6s | 2.4m | 9.0m | ❗ 18s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32468029618) | 2026-08-21 10:02:21 |
| React Native (RN Tester) | ✅ | 26.9m | 22s | 2.5m | 24.0m | ❗ 502s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32468029618) | 2026-08-21 10:29:47 |
| Bluesky (social-app) | ✅ | 27.1m | 8s | 3.0m | 24.0m | ⚡ 519s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32468029618) | 2026-08-21 10:57:33 |
| Mattermost Mobile | ✅ | 32.5m | 8s | 7.1m | 25.3m | ⚡ 264s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32468029618) | 2026-08-21 11:30:41 |
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
