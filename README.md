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
| XcodeBenchmark (anchor) | 1.6m | 16.8m | 10.2× |
| Wikipedia iOS | 1.3m | 6.1m | 4.7× |
| DuckDuckGo iOS | 2.2m | 10.8m | 4.9× |
| React Native (RN Tester) | 2.7m | 20.6m | 7.6× |
| Bluesky (social-app) | 5.2m | 36.5m | 7.0× |
| Mattermost Mobile | 5.3m | 33.5m | 6.3× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.6m | 16s | - | 1.4m | ⚡ 15s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32121699488) | 2026-08-18 09:30:08 |
| Wikipedia iOS | ✅ | 1.3m | 21s | 7s | 51s | ⚡ 10s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32121699488) | 2026-08-18 09:31:48 |
| DuckDuckGo iOS | ✅ | 2.2m | 8s | 40s | 1.4m | ❗ 54s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32121699488) | 2026-08-18 09:34:23 |
| React Native (RN Tester) | ✅ | 2.7m | 25s | 24s | 1.9m | ⚡ 34s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32121699488) | 2026-08-18 09:37:29 |
| Bluesky (social-app) | ✅ | 5.2m | 11s | 1.8m | 3.2m | ⚡ 13s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32121699488) | 2026-08-18 09:43:11 |
| Mattermost Mobile | ✅ | 5.3m | 11s | 2.0m | 3.1m | ❗ 44s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32121699488) | 2026-08-18 09:49:08 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 16.8m | 15s | - | 16.5m | ❗ 224s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32121699488) | 2026-08-18 09:44:56 |
| Wikipedia iOS | ✅ | 6.1m | 16s | 40s | 5.1m | ⚡ 78s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32121699488) | 2026-08-18 09:51:32 |
| DuckDuckGo iOS | ✅ | 10.8m | 5s | 2.1m | 8.6m | ⚡ 28s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32121699488) | 2026-08-18 10:02:38 |
| React Native (RN Tester) | ✅ | 20.6m | 29s | 2.1m | 18.1m | ❗ 151s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32121699488) | 2026-08-18 10:23:52 |
| Bluesky (social-app) | ✅ | 36.5m | 8s | 4.4m | 31.9m | ❗ 412s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32121699488) | 2026-08-18 11:01:01 |
| Mattermost Mobile | ✅ | 33.5m | 8s | 6.9m | 26.5m | ❗ 118s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32121699488) | 2026-08-18 11:35:36 |
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
