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
| XcodeBenchmark (anchor) | 1.7m | 15.9m | 9.1× |
| Wikipedia iOS | 1.6m | 7.6m | 4.8× |
| DuckDuckGo iOS | 1.4m | 12.3m | 9.0× |
| React Native (RN Tester) | 3.3m | 21.9m | 6.7× |
| Bluesky (social-app) | 5.3m | 41.3m | 7.8× |
| Mattermost Mobile | 5.6m | 37.5m | 6.7× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.7m | 15s | - | 1.5m | ⚡ 32s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29406430376) | 2026-07-15 10:00:31 |
| Wikipedia iOS | ✅ | 1.6m | 24s | 12s | 58s | ❗ 7s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29406430376) | 2026-07-15 10:02:30 |
| DuckDuckGo iOS | ✅ | 1.4m | 8s | 18s | 56s | ⚡ 116s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29406430376) | 2026-07-15 10:04:14 |
| React Native (RN Tester) | ✅ | 3.3m | 22s | 50s | 2.1m | ❗ 27s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29406430376) | 2026-07-15 10:07:57 |
| Bluesky (social-app) | ✅ | 5.3m | 12s | 1.8m | 3.3m | ❗ 74s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29406430376) | 2026-07-15 10:13:44 |
| Mattermost Mobile | ✅ | 5.6m | 11s | 1.9m | 3.5m | ❗ 6s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29406430376) | 2026-07-15 10:19:57 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 15.9m | 12s | - | 15.7m | ⚡ 18s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29406430376) | 2026-07-15 10:14:29 |
| Wikipedia iOS | ✅ | 7.6m | 15s | 43s | 6.7m | ⚡ 25s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29406430376) | 2026-07-15 10:22:39 |
| DuckDuckGo iOS | ✅ | 12.3m | 7s | 2.0m | 10.1m | ❗ 239s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29406430376) | 2026-07-15 10:35:17 |
| React Native (RN Tester) | ✅ | 21.9m | 15s | 2.2m | 19.5m | ⚡ 73s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29406430376) | 2026-07-15 10:57:47 |
| Bluesky (social-app) | ✅ | 41.3m | 8s | 4.8m | 36.4m | ❗ 550s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29406430376) | 2026-07-15 11:39:43 |
| Mattermost Mobile | ✅ | 37.5m | 7s | 9.5m | 27.9m | ⚡ 388s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29406430376) | 2026-07-15 12:18:14 |
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
