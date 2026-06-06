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
| XcodeBenchmark (anchor) | 2.0m | 12.4m | 6.4× |
| Wikipedia iOS | 1.3m | 6.1m | 4.5× |
| DuckDuckGo iOS | 1.3m | 8.4m | 6.6× |
| React Native (RN Tester) | 2.9m | 13.0m | 4.5× |
| Bluesky (social-app) | 4.0m | 27.4m | 6.9× |
| Mattermost Mobile | 5.2m | 27.4m | 5.2× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.0m | 16s | - | 1.7m | ❗ 4s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27059246238) | 2026-06-06 10:01:07 |
| Wikipedia iOS | ✅ | 1.3m | 19s | 7s | 55s | ⚡ 4s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27059246238) | 2026-06-06 10:02:48 |
| DuckDuckGo iOS | ✅ | 1.3m | 8s | 18s | 50s | ⚡ 35s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27059246238) | 2026-06-06 10:04:25 |
| React Native (RN Tester) | ✅ | 2.9m | 20s | 54s | 1.7m | ⚡ 20s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27059246238) | 2026-06-06 10:07:46 |
| Bluesky (social-app) | ✅ | 4.0m | 9s | 38s | 3.2m | ❗ 2s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27059246238) | 2026-06-06 10:12:16 |
| Mattermost Mobile | ✅ | 5.2m | 9s | 1.9m | 3.2m | ❗ 84s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27059246238) | 2026-06-06 10:18:04 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 12.4m | 14s | - | 12.2m | ⚡ 27s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27059246238) | 2026-06-06 10:11:18 |
| Wikipedia iOS | ✅ | 6.1m | 14s | 35s | 5.3m | ⚡ 14s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27059246238) | 2026-06-06 10:17:42 |
| DuckDuckGo iOS | ✅ | 8.4m | 6s | 1.6m | 6.6m | ⚡ 124s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27059246238) | 2026-06-06 10:26:17 |
| React Native (RN Tester) | ✅ | 13.0m | 12s | 1.3m | 11.5m | ⚡ 472s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27059246238) | 2026-06-06 10:39:35 |
| Bluesky (social-app) | ✅ | 27.4m | 7s | 2.9m | 24.4m | ⚡ 213s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27059246238) | 2026-06-06 11:07:24 |
| Mattermost Mobile | ✅ | 27.4m | 6s | 6.8m | 20.5m | ⚡ 345s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27059246238) | 2026-06-06 11:35:35 |
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
