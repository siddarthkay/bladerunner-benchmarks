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
| XcodeBenchmark (anchor) | 1.9m | 15.7m | 8.4× |
| Wikipedia iOS | 1.4m | 5.1m | 3.6× |
| DuckDuckGo iOS | 1.4m | 13.6m | 9.7× |
| React Native (RN Tester) | 3.3m | 22.8m | 6.9× |
| Bluesky (social-app) | 4.3m | 30.4m | 7.1× |
| Mattermost Mobile | 7.6m | 43.9m | 5.8× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.9m | 15s | - | 1.6m | ⚡ 9s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33858542529) | 2026-09-04 09:31:35 |
| Wikipedia iOS | ✅ | 1.4m | 23s | 7s | 56s | ⚡ 9s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33858542529) | 2026-09-04 09:33:24 |
| DuckDuckGo iOS | ✅ | 1.4m | 8s | 19s | 57s | ⚡ 43s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33858542529) | 2026-09-04 09:35:10 |
| React Native (RN Tester) | ✅ | 3.3m | 23s | 47s | 2.1m | ❗ 6s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33858542529) | 2026-09-04 09:38:50 |
| Bluesky (social-app) | ✅ | 4.3m | 9s | 39s | 3.5m | ⚡ 52s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33858542529) | 2026-09-04 09:43:37 |
| Mattermost Mobile | ✅ | 7.6m | 12s | 4.5m | 3.0m | ❗ 240s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33858542529) | 2026-09-04 09:51:49 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 15.7m | 11s | - | 15.5m | ❗ 331s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33858542529) | 2026-09-04 09:45:14 |
| Wikipedia iOS | ✅ | 5.1m | 17s | 27s | 4.3m | ⚡ 150s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33858542529) | 2026-09-04 09:50:46 |
| DuckDuckGo iOS | ✅ | 13.6m | 6s | 2.2m | 11.3m | ❗ 129s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33858542529) | 2026-09-04 10:04:40 |
| React Native (RN Tester) | ✅ | 22.8m | 21s | 2.0m | 20.5m | ❗ 201s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33858542529) | 2026-09-04 10:28:16 |
| Bluesky (social-app) | ✅ | 30.4m | 9s | 3.8m | 26.4m | ⚡ 283s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33858542529) | 2026-09-04 10:59:22 |
| Mattermost Mobile | ✅ | 43.9m | 8s | 13.2m | 30.6m | ❗ 124s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33858542529) | 2026-09-04 11:44:14 |
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
