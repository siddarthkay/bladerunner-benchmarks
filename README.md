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
| XcodeBenchmark (anchor) | 1.7m | 11.1m | 6.5× |
| Wikipedia iOS | 1.5m | 7.3m | 5.0× |
| DuckDuckGo iOS | 1.3m | 12.5m | 9.6× |
| React Native (RN Tester) | 3.1m | 17.9m | 5.7× |
| Bluesky (social-app) | 3.9m | 26.1m | 6.6× |
| Mattermost Mobile | 5.2m | 37.5m | 7.2× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.7m | 15s | - | 1.4m | ⚡ 5s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30153579005) | 2026-07-25 09:58:02 |
| Wikipedia iOS | ✅ | 1.5m | 18s | 13s | 57s | ⚡ 6s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30153579005) | 2026-07-25 09:59:51 |
| DuckDuckGo iOS | ✅ | 1.3m | 8s | 18s | 52s | ⚡ 3s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30153579005) | 2026-07-25 10:01:29 |
| React Native (RN Tester) | ✅ | 3.1m | 25s | 44s | 2.0m | ❗ 6s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30153579005) | 2026-07-25 10:05:02 |
| Bluesky (social-app) | ✅ | 3.9m | 9s | 38s | 3.2m | ⚡ 94s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30153579005) | 2026-07-25 10:09:28 |
| Mattermost Mobile | ✅ | 5.2m | 11s | 1.9m | 3.1m | ❗ 75s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30153579005) | 2026-07-25 10:15:20 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 11.1m | 10s | - | 10.9m | ⚡ 224s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30153579005) | 2026-07-25 10:07:11 |
| Wikipedia iOS | ✅ | 7.3m | 12s | 29s | 6.6m | ❗ 74s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30153579005) | 2026-07-25 10:14:49 |
| DuckDuckGo iOS | ✅ | 12.5m | 5s | 2.0m | 10.3m | ❗ 151s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30153579005) | 2026-07-25 10:27:37 |
| React Native (RN Tester) | ✅ | 17.9m | 18s | 2.0m | 15.6m | ❗ 246s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30153579005) | 2026-07-25 10:46:13 |
| Bluesky (social-app) | ✅ | 26.1m | 7s | 3.3m | 22.6m | ❗ 107s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30153579005) | 2026-07-25 11:12:53 |
| Mattermost Mobile | ✅ | 37.5m | 5s | 7.5m | 29.9m | ❗ 268s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30153579005) | 2026-07-25 11:51:16 |
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
