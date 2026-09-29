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
| XcodeBenchmark (anchor) | 37s | 18.4m | - |
| Wikipedia iOS | 2.6m | 11.7m | 4.4× |
| DuckDuckGo iOS | 6.2m | 13.8m | - |
| React Native (RN Tester) | 6.4m | 24.2m | 3.8× |
| Bluesky (social-app) | 7.8m | 32.3m | - |
| Mattermost Mobile | 2.3m | 34.9m | - |

### bladerunner - Mac Studio · Xcode 27.0

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ❌ build | 37s | 28s | - | 9s | - | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36549867422) | 2026-09-29 09:59:12 |
| Wikipedia iOS | ✅ | 2.6m | 52s | 40s | 1.1m | ❗ 45s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36549867422) | 2026-09-29 10:02:18 |
| DuckDuckGo iOS | ❌ build | 6.2m | 13s | 4.6m | 1.3m | - | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36549867422) | 2026-09-29 10:08:56 |
| React Native (RN Tester) | ✅ | 6.4m | 1.1m | 3.2m | 2.1m | ❗ 148s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36549867422) | 2026-09-29 10:15:52 |
| Bluesky (social-app) | ❌ deps | 7.8m | 59s | 6.8m | 0s | - | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36549867422) | 2026-09-29 10:24:50 |
| Mattermost Mobile | ❌ deps | 2.3m | 29s | 1.8m | 3s | - | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36549867422) | 2026-09-29 10:27:42 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 18.4m | 15s | - | 18.1m | ❗ 13s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36549867422) | 2026-09-29 10:16:38 |
| Wikipedia iOS | ✅ | 11.7m | 22s | 51s | 10.5m | ❗ 222s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36549867422) | 2026-09-29 10:28:55 |
| DuckDuckGo iOS | ✅ | 13.8m | 6s | 2.3m | 11.5m | ⚡ 33s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36549867422) | 2026-09-29 10:43:22 |
| React Native (RN Tester) | ✅ | 24.2m | 22s | 2.8m | 21.1m | ❗ 47s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36549867422) | 2026-09-29 11:08:19 |
| Bluesky (social-app) | ✅ | 32.3m | 7s | 4.4m | 27.8m | ⚡ 774s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36549867422) | 2026-09-29 11:41:27 |
| Mattermost Mobile | ✅ | 34.9m | 10s | 8.3m | 26.4m | ⚡ 643s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/36549867422) | 2026-09-29 12:17:12 |
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
