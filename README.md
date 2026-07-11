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
| XcodeBenchmark (anchor) | 3.4m | 19.2m | 5.7× |
| Wikipedia iOS | 1.7m | 6.9m | 4.2× |
| DuckDuckGo iOS | 2.3m | 9.7m | 4.3× |
| React Native (RN Tester) | 2.8m | 19.5m | 6.9× |
| Bluesky (social-app) | 4.1m | 30.4m | 7.4× |
| Mattermost Mobile | 5.1m | 26.9m | 5.3× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 3.4m | 14s | - | 3.1m | ❗ 88s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29148331251) | 2026-07-11 09:53:04 |
| Wikipedia iOS | ✅ | 1.7m | 20s | 13s | 1.1m | ❗ 7s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29148331251) | 2026-07-11 09:55:05 |
| DuckDuckGo iOS | ✅ | 2.3m | 7s | 43s | 1.4m | ❗ 5s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29148331251) | 2026-07-11 09:57:42 |
| React Native (RN Tester) | ✅ | 2.8m | 22s | 50s | 1.6m | ⚡ 3s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29148331251) | 2026-07-11 10:00:57 |
| Bluesky (social-app) | ✅ | 4.1m | 11s | 38s | 3.3m | ❗ 17s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29148331251) | 2026-07-11 10:05:32 |
| Mattermost Mobile | ✅ | 5.1m | 10s | 1.9m | 3.0m | ⚡ 48s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29148331251) | 2026-07-11 10:11:13 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 19.2m | 14s | - | 19.0m | ❗ 406s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29148331251) | 2026-07-11 10:08:41 |
| Wikipedia iOS | ✅ | 6.9m | 14s | 35s | 6.1m | ⚡ 21s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29148331251) | 2026-07-11 10:16:34 |
| DuckDuckGo iOS | ✅ | 9.7m | 5s | 1.4m | 8.2m | ❗ 33s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29148331251) | 2026-07-11 10:26:33 |
| React Native (RN Tester) | ✅ | 19.5m | 14s | 1.8m | 17.4m | ❗ 382s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29148331251) | 2026-07-11 10:46:30 |
| Bluesky (social-app) | ✅ | 30.4m | 8s | 4.0m | 26.2m | ⚡ 309s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29148331251) | 2026-07-11 11:17:25 |
| Mattermost Mobile | ✅ | 26.9m | 7s | 6.8m | 20.0m | ❗ 70s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29148331251) | 2026-07-11 11:44:53 |
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
