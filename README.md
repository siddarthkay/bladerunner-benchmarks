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
| XcodeBenchmark (anchor) | 1.7m | 11.7m | 6.7× |
| Wikipedia iOS | 1.5m | 5.0m | 3.3× |
| DuckDuckGo iOS | 2.4m | 11.8m | 5.0× |
| React Native (RN Tester) | 3.3m | 18.5m | 5.7× |
| Bluesky (social-app) | 3.9m | 27.5m | 7.0× |
| Mattermost Mobile | 4.2m | 28.3m | 6.8× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.7m | 17s | - | 1.5m | ⚡ 23s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27684033186) | 2026-06-17 11:00:06 |
| Wikipedia iOS | ✅ | 1.5m | 22s | 12s | 57s | ❗ 2s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27684033186) | 2026-06-17 11:02:06 |
| DuckDuckGo iOS | ✅ | 2.4m | 9s | 46s | 1.4m | ❗ 59s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27684033186) | 2026-06-17 11:04:49 |
| React Native (RN Tester) | ✅ | 3.3m | 24s | 51s | 2.0m | ❗ 24s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27684033186) | 2026-06-17 11:08:28 |
| Bluesky (social-app) | ✅ | 3.9m | 10s | 38s | 3.1m | ⚡ 81s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27684033186) | 2026-06-17 11:12:54 |
| Mattermost Mobile | ✅ | 4.2m | 10s | 43s | 3.3m | ⚡ 97s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27684033186) | 2026-06-17 11:17:44 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 11.7m | 12s | - | 11.5m | ⚡ 233s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27684033186) | 2026-06-17 11:09:46 |
| Wikipedia iOS | ✅ | 5.0m | 14s | 28s | 4.3m | ⚡ 198s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27684033186) | 2026-06-17 11:15:05 |
| DuckDuckGo iOS | ✅ | 11.8m | 6s | 1.9m | 9.8m | ⚡ 7s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27684033186) | 2026-06-17 11:27:09 |
| React Native (RN Tester) | ✅ | 18.5m | 18s | 2.0m | 16.2m | ❗ 62s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27684033186) | 2026-06-17 11:46:11 |
| Bluesky (social-app) | ✅ | 27.5m | 7s | 2.9m | 24.4m | ❗ 272s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27684033186) | 2026-06-17 12:14:09 |
| Mattermost Mobile | ✅ | 28.3m | 10s | 8.1m | 20.1m | ⚡ 49s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27684033186) | 2026-06-17 12:43:15 |
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
