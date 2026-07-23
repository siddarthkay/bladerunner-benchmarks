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
| XcodeBenchmark (anchor) | 1.8m | 16.5m | 9.3× |
| Wikipedia iOS | 1.6m | 6.4m | 3.9× |
| DuckDuckGo iOS | 2.5m | 11.3m | 4.5× |
| React Native (RN Tester) | 3.4m | 19.4m | 5.8× |
| Bluesky (social-app) | 5.8m | 37.7m | 6.5× |
| Mattermost Mobile | 5.6m | 31.0m | 5.5× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.8m | 20s | - | 1.4m | ⚡ 1s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29997916711) | 2026-07-23 10:07:31 |
| Wikipedia iOS | ✅ | 1.6m | 29s | 6s | 1.0m | ❗ 10s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29997916711) | 2026-07-23 10:09:32 |
| DuckDuckGo iOS | ✅ | 2.5m | 10s | 50s | 1.5m | ❗ 74s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29997916711) | 2026-07-23 10:12:29 |
| React Native (RN Tester) | ✅ | 3.4m | 1.0m | 30s | 1.8m | ❗ 37s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29997916711) | 2026-07-23 10:16:20 |
| Bluesky (social-app) | ✅ | 5.8m | 13s | 2.2m | 3.4m | ❗ 107s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29997916711) | 2026-07-23 10:22:40 |
| Mattermost Mobile | ✅ | 5.6m | 16s | 2.3m | 3.0m | ❗ 89s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29997916711) | 2026-07-23 10:28:58 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 16.5m | 13s | - | 16.3m | ❗ 13s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29997916711) | 2026-07-23 10:21:57 |
| Wikipedia iOS | ✅ | 6.4m | 15s | 29s | 5.7m | ⚡ 104s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29997916711) | 2026-07-23 10:28:49 |
| DuckDuckGo iOS | ✅ | 11.3m | 7s | 2.3m | 8.8m | ⚡ 68s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29997916711) | 2026-07-23 10:40:29 |
| React Native (RN Tester) | ✅ | 19.4m | 18s | 1.6m | 17.5m | ⚡ 5s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29997916711) | 2026-07-23 11:00:25 |
| Bluesky (social-app) | ✅ | 37.7m | 8s | 3.8m | 33.7m | ❗ 262s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29997916711) | 2026-07-23 11:38:46 |
| Mattermost Mobile | ✅ | 31.0m | 8s | 8.0m | 22.9m | ⚡ 634s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29997916711) | 2026-07-23 12:10:38 |
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
