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
| XcodeBenchmark (anchor) | 2.1m | 16.2m | 7.6× |
| Wikipedia iOS | 1.1m | 9.0m | - |
| DuckDuckGo iOS | 2.7m | 12.0m | 4.4× |
| React Native (RN Tester) | 2.9m | 19.7m | 6.8× |
| Bluesky (social-app) | 3.9m | 31.8m | 8.2× |
| Mattermost Mobile | 4.1m | 38.2m | 9.3× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.1m | 17s | - | 1.8m | ❗ 18s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34335012027) | 2026-09-09 09:32:40 |
| Wikipedia iOS | ❌ build | 1.1m | 30s | 13s | 21s | - | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34335012027) | 2026-09-09 09:34:06 |
| DuckDuckGo iOS | ✅ | 2.7m | 10s | 48s | 1.7m | ❗ 52s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34335012027) | 2026-09-09 09:37:09 |
| React Native (RN Tester) | ✅ | 2.9m | 23s | 29s | 2.0m | ⚡ 32s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34335012027) | 2026-09-09 09:40:26 |
| Bluesky (social-app) | ✅ | 3.9m | 10s | 39s | 3.1m | ⚡ 96s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34335012027) | 2026-09-09 09:44:49 |
| Mattermost Mobile | ✅ | 4.1m | 12s | 51s | 3.1m | ⚡ 172s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34335012027) | 2026-09-09 09:49:33 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 16.2m | 11s | - | 16.0m | ❗ 110s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34335012027) | 2026-09-09 09:46:36 |
| Wikipedia iOS | ✅ | 9.0m | 16s | 48s | 8.0m | ❗ 110s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34335012027) | 2026-09-09 09:56:10 |
| DuckDuckGo iOS | ✅ | 12.0m | 5s | 1.9m | 10.1m | ⚡ 131s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34335012027) | 2026-09-09 10:08:44 |
| React Native (RN Tester) | ✅ | 19.7m | 16s | 2.2m | 17.2m | ⚡ 169s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34335012027) | 2026-09-09 10:29:09 |
| Bluesky (social-app) | ✅ | 31.8m | 7s | 3.7m | 28.0m | ❗ 158s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34335012027) | 2026-09-09 11:01:51 |
| Mattermost Mobile | ✅ | 38.2m | 8s | 8.3m | 29.8m | ⚡ 280s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34335012027) | 2026-09-09 11:40:50 |
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
