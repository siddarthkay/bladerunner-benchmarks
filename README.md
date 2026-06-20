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
| XcodeBenchmark (anchor) | 1.7m | 13.1m | 7.9× |
| Wikipedia iOS | 1.7m | 5.0m | 3.0× |
| DuckDuckGo iOS | 2.3m | 9.5m | 4.2× |
| React Native (RN Tester) | 2.6m | 16.9m | 6.5× |
| Bluesky (social-app) | 3.8m | 23.3m | 6.1× |
| Mattermost Mobile | 3.7m | 27.3m | 7.4× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.7m | 15s | - | 1.4m | ⚡ 36s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27868102242) | 2026-06-20 10:17:54 |
| Wikipedia iOS | ✅ | 1.7m | 19s | 13s | 1.1m | ❗ 4s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27868102242) | 2026-06-20 10:19:54 |
| DuckDuckGo iOS | ✅ | 2.3m | 8s | 46s | 1.4m | ⚡ 29s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27868102242) | 2026-06-20 10:22:30 |
| React Native (RN Tester) | ✅ | 2.6m | 23s | 24s | 1.8m | ⚡ 37s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27868102242) | 2026-06-20 10:25:30 |
| Bluesky (social-app) | ✅ | 3.8m | 10s | 39s | 3.0m | ⚡ 12s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27868102242) | 2026-06-20 10:29:49 |
| Mattermost Mobile | ✅ | 3.7m | 10s | 44s | 2.8m | ⚡ 68s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27868102242) | 2026-06-20 10:34:07 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 13.1m | 14s | - | 12.8m | ⚡ 140s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27868102242) | 2026-06-20 10:29:09 |
| Wikipedia iOS | ✅ | 5.0m | 14s | 31s | 4.2m | ⚡ 68s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27868102242) | 2026-06-20 10:34:22 |
| DuckDuckGo iOS | ✅ | 9.5m | 5s | 1.3m | 8.1m | ❗ 12s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27868102242) | 2026-06-20 10:44:09 |
| React Native (RN Tester) | ✅ | 16.9m | 17s | 1.5m | 15.2m | ⚡ 522s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27868102242) | 2026-06-20 11:01:35 |
| Bluesky (social-app) | ✅ | 23.3m | 5s | 2.8m | 20.4m | ⚡ 251s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27868102242) | 2026-06-20 11:25:16 |
| Mattermost Mobile | ✅ | 27.3m | 7s | 6.8m | 20.4m | ⚡ 629s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27868102242) | 2026-06-20 11:53:10 |
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
