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
| XcodeBenchmark (anchor) | 1.7m | 16.0m | 9.5× |
| Wikipedia iOS | 1.5m | 5.4m | 3.6× |
| DuckDuckGo iOS | 2.7m | 13.0m | 4.8× |
| React Native (RN Tester) | 3.1m | 15.0m | 4.8× |
| Bluesky (social-app) | 3.8m | 37.1m | 9.7× |
| Mattermost Mobile | 5.4m | 32.7m | 6.1× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.7m | 15s | - | 1.4m | ⚡ 10s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29682439789) | 2026-07-19 09:58:28 |
| Wikipedia iOS | ✅ | 1.5m | 20s | 13s | 56s | ⚡ 6s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29682439789) | 2026-07-19 10:00:19 |
| DuckDuckGo iOS | ✅ | 2.7m | 8s | 44s | 1.8m | ❗ 51s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29682439789) | 2026-07-19 10:03:24 |
| React Native (RN Tester) | ✅ | 3.1m | 23s | 45s | 2.0m | ⚡ 10s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29682439789) | 2026-07-19 10:06:57 |
| Bluesky (social-app) | ✅ | 3.8m | 11s | 38s | 3.0m | ⚡ 65s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29682439789) | 2026-07-19 10:11:18 |
| Mattermost Mobile | ✅ | 5.4m | 10s | 2.0m | 3.3m | ❗ 3s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29682439789) | 2026-07-19 10:17:16 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 16.0m | 16s | - | 15.8m | ❗ 236s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29682439789) | 2026-07-19 10:12:41 |
| Wikipedia iOS | ✅ | 5.4m | 14s | 30s | 4.6m | ⚡ 109s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29682439789) | 2026-07-19 10:18:33 |
| DuckDuckGo iOS | ✅ | 13.0m | 6s | 2.1m | 10.8m | ❗ 147s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29682439789) | 2026-07-19 10:31:50 |
| React Native (RN Tester) | ✅ | 15.0m | 14s | 1.6m | 13.1m | ⚡ 244s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29682439789) | 2026-07-19 10:47:15 |
| Bluesky (social-app) | ✅ | 37.1m | 7s | 4.7m | 32.3m | ❗ 561s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29682439789) | 2026-07-19 11:24:53 |
| Mattermost Mobile | ✅ | 32.7m | 7s | 9.1m | 23.5m | ⚡ 91s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29682439789) | 2026-07-19 11:58:41 |
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
