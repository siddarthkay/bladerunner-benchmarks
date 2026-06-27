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
| XcodeBenchmark (anchor) | 2.9m | 9.9m | 3.4× |
| Wikipedia iOS | 1.4m | 5.7m | 4.2× |
| DuckDuckGo iOS | 1.2m | 7.8m | 6.3× |
| React Native (RN Tester) | 2.9m | 15.1m | 5.2× |
| Bluesky (social-app) | 5.5m | 23.7m | 4.3× |
| Mattermost Mobile | 4.2m | 28.0m | 6.6× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.9m | 15s | - | 2.6m | ❗ 60s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28285868551) | 2026-06-27 10:02:03 |
| Wikipedia iOS | ✅ | 1.4m | 20s | 7s | 55s | ⚡ 10s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28285868551) | 2026-06-27 10:03:48 |
| DuckDuckGo iOS | ✅ | 1.2m | 7s | 18s | 50s | ⚡ 56s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28285868551) | 2026-06-27 10:05:22 |
| React Native (RN Tester) | ✅ | 2.9m | 20s | 54s | 1.7m | ❗ 16s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28285868551) | 2026-06-27 10:08:40 |
| Bluesky (social-app) | ✅ | 5.5m | 9s | 1.8m | 3.6m | ❗ 94s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28285868551) | 2026-06-27 10:14:37 |
| Mattermost Mobile | ✅ | 4.2m | 10s | 45s | 3.3m | ⚡ 29s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28285868551) | 2026-06-27 10:19:29 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 9.9m | 11s | - | 9.8m | ⚡ 325s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28285868551) | 2026-06-27 10:08:54 |
| Wikipedia iOS | ✅ | 5.7m | 13s | 29s | 5.0m | ❗ 36s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28285868551) | 2026-06-27 10:14:53 |
| DuckDuckGo iOS | ✅ | 7.8m | 5s | 1.5m | 6.2m | ⚡ 195s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28285868551) | 2026-06-27 10:22:57 |
| React Native (RN Tester) | ✅ | 15.1m | 15s | 1.4m | 13.5m | ⚡ 347s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28285868551) | 2026-06-27 10:38:28 |
| Bluesky (social-app) | ✅ | 23.7m | 6s | 2.7m | 21.0m | ⚡ 439s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28285868551) | 2026-06-27 11:02:38 |
| Mattermost Mobile | ✅ | 28.0m | 7s | 7.1m | 20.7m | ⚡ 426s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28285868551) | 2026-06-27 11:31:11 |
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
