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
| XcodeBenchmark (anchor) | 1.9m | 11.5m | 5.9× |
| Wikipedia iOS | 1.7m | 7.6m | 4.5× |
| DuckDuckGo iOS | 2.5m | 9.4m | 3.8× |
| React Native (RN Tester) | 3.9m | 15.4m | 3.9× |
| Bluesky (social-app) | 5.2m | 33.8m | 6.5× |
| Mattermost Mobile | 5.1m | 46.0m | 9.0× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.9m | 15s | - | 1.7m | ❗ 9s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26569742706) | 2026-05-28 10:42:32 |
| Wikipedia iOS | ✅ | 1.7m | 21s | 13s | 1.1m | ❗ 8s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26569742706) | 2026-05-28 10:44:34 |
| DuckDuckGo iOS | ✅ | 2.5m | 9s | 44s | 1.6m | ⚡ 95s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26569742706) | 2026-05-28 10:47:25 |
| React Native (RN Tester) | ✅ | 3.9m | 21s | 1.3m | 2.3m | ❗ 25s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26569742706) | 2026-05-28 10:51:49 |
| Bluesky (social-app) | ✅ | 5.2m | 9s | 1.5m | 3.5m | ❗ 81s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26569742706) | 2026-05-28 10:57:37 |
| Mattermost Mobile | ✅ | 5.1m | 9s | 36s | 4.3m | ⚡ 16s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26569742706) | 2026-05-28 11:03:17 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 11.5m | 13s | - | 11.3m | ❗ 4s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26569742706) | 2026-05-28 10:51:55 |
| Wikipedia iOS | ✅ | 7.6m | 15s | 36s | 6.7m | ❗ 167s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26569742706) | 2026-05-28 10:59:52 |
| DuckDuckGo iOS | ✅ | 9.4m | 7s | 1.6m | 7.7m | ❗ 29s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26569742706) | 2026-05-28 11:09:39 |
| React Native (RN Tester) | ✅ | 15.4m | 19s | 2.1m | 13.0m | ❗ 130s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26569742706) | 2026-05-28 11:25:34 |
| Bluesky (social-app) | ✅ | 33.8m | 4s | 3.1m | 30.6m | ❗ 292s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26569742706) | 2026-05-28 11:59:49 |
| Mattermost Mobile | ✅ | 46.0m | 7s | 9.5m | 36.4m | - | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26569742706) | 2026-05-28 12:46:52 |
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
