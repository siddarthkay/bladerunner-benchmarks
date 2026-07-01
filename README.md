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
| XcodeBenchmark (anchor) | 2.4m | 15.9m | 6.7× |
| Wikipedia iOS | 1.8m | 6.4m | 3.6× |
| DuckDuckGo iOS | 2.2m | 12.8m | 5.7× |
| React Native (RN Tester) | 3.3m | 17.5m | 5.3× |
| Bluesky (social-app) | 5.5m | 35.4m | 6.4× |
| Mattermost Mobile | 4.1m | 43.2m | 10.6× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.4m | 15s | - | 2.1m | ⚡ 8s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28511242336) | 2026-07-01 10:36:20 |
| Wikipedia iOS | ✅ | 1.8m | 27s | 7s | 1.2m | ❗ 3s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28511242336) | 2026-07-01 10:38:28 |
| DuckDuckGo iOS | ✅ | 2.2m | 7s | 43s | 1.4m | ❗ 9s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28511242336) | 2026-07-01 10:41:03 |
| React Native (RN Tester) | ✅ | 3.3m | 23s | 48s | 2.1m | ❗ 28s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28511242336) | 2026-07-01 10:44:44 |
| Bluesky (social-app) | ✅ | 5.5m | 12s | 1.8m | 3.5m | ❗ 86s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28511242336) | 2026-07-01 10:50:44 |
| Mattermost Mobile | ✅ | 4.1m | 10s | 38s | 3.3m | ⚡ 61s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28511242336) | 2026-07-01 10:55:22 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 15.9m | 11s | - | 15.7m | ❗ 182s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28511242336) | 2026-07-01 10:49:33 |
| Wikipedia iOS | ✅ | 6.4m | 13s | 28s | 5.7m | ❗ 81s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28511242336) | 2026-07-01 10:56:22 |
| DuckDuckGo iOS | ✅ | 12.8m | 7s | 2.0m | 10.7m | ⚡ 119s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28511242336) | 2026-07-01 11:09:37 |
| React Native (RN Tester) | ✅ | 17.5m | 18s | 2.1m | 15.1m | ⚡ 443s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28511242336) | 2026-07-01 11:27:40 |
| Bluesky (social-app) | ✅ | 35.4m | 9s | 3.7m | 31.5m | ❗ 398s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28511242336) | 2026-07-01 12:03:46 |
| Mattermost Mobile | ✅ | 43.2m | 7s | 9.9m | 33.3m | ❗ 344s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28511242336) | 2026-07-01 12:47:49 |
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
