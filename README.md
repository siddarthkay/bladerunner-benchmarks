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
| XcodeBenchmark (anchor) | 2.0m | 16.2m | 8.2× |
| Wikipedia iOS | 1.8m | 6.1m | 3.3× |
| DuckDuckGo iOS | 1.4m | 8.4m | 6.2× |
| React Native (RN Tester) | 5.0m | 14.4m | 2.9× |
| Bluesky (social-app) | 3.8m | 35.7m | 9.3× |
| Mattermost Mobile | 4.9m | 27.3m | 5.6× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.0m | 15s | - | 1.7m | ⚡ 12s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27948563127) | 2026-06-22 11:15:24 |
| Wikipedia iOS | ✅ | 1.8m | 26s | 7s | 1.3m | ❗ 20s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27948563127) | 2026-06-22 11:17:37 |
| DuckDuckGo iOS | ✅ | 1.4m | 7s | 18s | 56s | ❗ 4s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27948563127) | 2026-06-22 11:19:20 |
| React Native (RN Tester) | ✅ | 5.0m | 2.7m | 24s | 1.9m | ❗ 131s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27948563127) | 2026-06-22 11:24:47 |
| Bluesky (social-app) | ✅ | 3.8m | 11s | 39s | 3.0m | ⚡ 92s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27948563127) | 2026-06-22 11:29:07 |
| Mattermost Mobile | ✅ | 4.9m | 11s | 42s | 4.0m | ⚡ 10s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27948563127) | 2026-06-22 11:34:39 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 16.2m | 14s | - | 15.9m | ❗ 326s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27948563127) | 2026-06-22 11:29:25 |
| Wikipedia iOS | ✅ | 6.1m | 13s | 24s | 5.5m | ⚡ 1s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27948563127) | 2026-06-22 11:35:53 |
| DuckDuckGo iOS | ✅ | 8.4m | 5s | 1.5m | 6.8m | ⚡ 310s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27948563127) | 2026-06-22 11:44:35 |
| React Native (RN Tester) | ✅ | 14.4m | 18s | 1.4m | 12.7m | ❗ 78s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27948563127) | 2026-06-22 11:59:26 |
| Bluesky (social-app) | ✅ | 35.7m | 7s | 4.3m | 31.3m | ❗ 110s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27948563127) | 2026-06-22 12:35:38 |
| Mattermost Mobile | ✅ | 27.3m | 7s | 7.6m | 19.5m | ⚡ 76s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27948563127) | 2026-06-22 13:03:57 |
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
