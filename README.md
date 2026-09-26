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
| XcodeBenchmark (anchor) | 26s | 16.4m | - |
| Wikipedia iOS | 1.9m | 5.8m | 3.1× |
| DuckDuckGo iOS | 3.8m | 12.0m | - |
| React Native (RN Tester) | 3.8m | 21.1m | 5.5× |
| Bluesky (social-app) | 1.2m | 35.2m | - |
| Mattermost Mobile | 44s | 37.6m | - |

### bladerunner - Mac Studio · Xcode 27.0

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ❌ build | 26s | 16s | - | 10s | - | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36118820930) | 2026-09-25 09:32:05 |
| Wikipedia iOS | ✅ | 1.9m | 20s | 23s | 1.1m | - | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36118820930) | 2026-09-25 09:34:24 |
| DuckDuckGo iOS | ❌ build | 3.8m | 8s | 2.4m | 1.3m | - | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36118820930) | 2026-09-25 09:38:35 |
| React Native (RN Tester) | ✅ | 3.8m | 24s | 1.4m | 2.0m | ❗ 35s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36118820930) | 2026-09-25 09:42:55 |
| Bluesky (social-app) | ❌ deps | 1.2m | 10s | 60s | 0s | - | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36118820930) | 2026-09-25 09:44:48 |
| Mattermost Mobile | ❌ build | 44s | 15s | 27s | 2s | - | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35981600483) | 2026-09-24 09:47:03 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 16.4m | 12s | - | 16.2m | ❗ 46s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36118820930) | 2026-09-25 09:47:44 |
| Wikipedia iOS | ✅ | 5.8m | 17s | 34s | 5.0m | ⚡ 78s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36118820930) | 2026-09-25 09:54:06 |
| DuckDuckGo iOS | ✅ | 12.0m | 5s | 1.7m | 10.2m | ⚡ 48s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36118820930) | 2026-09-25 10:06:32 |
| React Native (RN Tester) | ✅ | 21.1m | 23s | 2.5m | 18.2m | ❗ 52s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36118820930) | 2026-09-25 10:28:18 |
| Bluesky (social-app) | ✅ | 35.2m | 8s | 3.2m | 31.8m | ⚡ 143s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36118820930) | 2026-09-25 11:04:05 |
| Mattermost Mobile | ✅ | 37.6m | 9s | 9.3m | 28.1m | ⚡ 23s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36118820930) | 2026-09-25 11:42:23 |
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
