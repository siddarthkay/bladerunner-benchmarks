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
| XcodeBenchmark (anchor) | 2.0m | 16.8m | 8.4× |
| Wikipedia iOS | 1.5m | 8.6m | 5.6× |
| DuckDuckGo iOS | 2.6m | 9.9m | 3.7× |
| React Native (RN Tester) | 0s | 0s | - |
| Bluesky (social-app) | 5.1m | 35.0m | 6.9× |
| Mattermost Mobile | 3.9m | 35.9m | 9.3× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.0m | 16s | - | 1.7m | ⚡ 66s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27270658622) | 2026-06-10 10:44:22 |
| Wikipedia iOS | ✅ | 1.5m | 23s | 13s | 56s | ❗ 5s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27270658622) | 2026-06-10 10:46:18 |
| DuckDuckGo iOS | ✅ | 2.6m | 8s | 44s | 1.8m | ❗ 78s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27270658622) | 2026-06-10 10:49:18 |
| React Native (RN Tester) | ❌ clone | 0s | 0s | - | - | - | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `unknown`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27270658622) | 2026-06-10 10:49:40 |
| Bluesky (social-app) | ✅ | 5.1m | 10s | 1.7m | 3.2m | ❗ 57s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27270658622) | 2026-06-10 10:55:05 |
| Mattermost Mobile | ✅ | 3.9m | 10s | 38s | 3.1m | ⚡ 70s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27270658622) | 2026-06-10 10:59:37 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 16.8m | 12s | - | 16.5m | ❗ 219s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27270658622) | 2026-06-10 10:58:55 |
| Wikipedia iOS | ✅ | 8.6m | 16s | 41s | 7.7m | ❗ 44s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27270658622) | 2026-06-10 11:07:59 |
| DuckDuckGo iOS | ✅ | 9.9m | 7s | 1.9m | 7.9m | ⚡ 60s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27270658622) | 2026-06-10 11:18:16 |
| React Native (RN Tester) | ❌ clone | 0s | 0s | - | - | - | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `unknown`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27270658622) | 2026-06-10 11:18:33 |
| Bluesky (social-app) | ✅ | 35.0m | 8s | 3.6m | 31.3m | ❗ 292s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27270658622) | 2026-06-10 11:53:58 |
| Mattermost Mobile | ✅ | 35.9m | 8s | 8.3m | 27.4m | ⚡ 160s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27270658622) | 2026-06-10 12:30:51 |
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
