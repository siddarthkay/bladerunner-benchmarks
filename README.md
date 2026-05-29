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
| XcodeBenchmark (anchor) | 2.8m | 10.2m | 3.7× |
| Wikipedia iOS | 1.7m | 5.7m | 3.4× |
| DuckDuckGo iOS | 2.1m | 10.1m | 4.9× |
| React Native (RN Tester) | 2.9m | 14.8m | 5.1× |
| Bluesky (social-app) | 4.8m | 30.0m | 6.3× |
| Mattermost Mobile | 5.7m | 34.5m | 6.1× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.8m | 15s | - | 2.5m | ❗ 50s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26632415748) | 2026-05-29 10:38:35 |
| Wikipedia iOS | ✅ | 1.7m | 21s | 8s | 1.2m | ±0s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26632415748) | 2026-05-29 10:40:38 |
| DuckDuckGo iOS | ✅ | 2.1m | 8s | 18s | 1.6m | ⚡ 26s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26632415748) | 2026-05-29 10:43:04 |
| React Native (RN Tester) | ✅ | 2.9m | 20s | 50s | 1.7m | ⚡ 61s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26632415748) | 2026-05-29 10:46:23 |
| Bluesky (social-app) | ✅ | 4.8m | 10s | 1.5m | 3.1m | ⚡ 26s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26632415748) | 2026-05-29 10:51:41 |
| Mattermost Mobile | ✅ | 5.7m | 10s | 2.4m | 3.1m | ❗ 36s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26632415748) | 2026-05-29 10:57:59 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 10.2m | 10s | - | 10.0m | ⚡ 81s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26632415748) | 2026-05-29 10:45:47 |
| Wikipedia iOS | ✅ | 5.7m | 13s | 32s | 5.0m | ⚡ 112s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26632415748) | 2026-05-29 10:51:54 |
| DuckDuckGo iOS | ✅ | 10.1m | 6s | 1.6m | 8.5m | ❗ 44s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26632415748) | 2026-05-29 11:02:18 |
| React Native (RN Tester) | ✅ | 14.8m | 13s | 1.5m | 13.1m | ⚡ 36s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26632415748) | 2026-05-29 11:17:36 |
| Bluesky (social-app) | ✅ | 30.0m | 7s | 3.4m | 26.5m | ⚡ 231s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26632415748) | 2026-05-29 11:47:59 |
| Mattermost Mobile | ✅ | 34.5m | 7s | 6.8m | 27.6m | ⚡ 692s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26632415748) | 2026-05-29 12:22:59 |
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
