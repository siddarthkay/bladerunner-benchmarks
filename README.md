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
| XcodeBenchmark (anchor) | 1.9m | 11.9m | 6.4× |
| Wikipedia iOS | 1.5m | 7.5m | 5.1× |
| DuckDuckGo iOS | 1.8m | 12.5m | 6.8× |
| React Native (RN Tester) | 2.9m | 20.1m | 7.0× |
| Bluesky (social-app) | 5.5m | 28.6m | 5.2× |
| Mattermost Mobile | 6.5m | 31.3m | 4.8× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.9m | 16s | - | 1.6m | ⚡ 3s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31876998155) | 2026-08-15 09:29:12 |
| Wikipedia iOS | ✅ | 1.5m | 21s | 13s | 55s | ⚡ 2s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31876998155) | 2026-08-15 09:31:03 |
| DuckDuckGo iOS | ✅ | 1.8m | 9s | 18s | 1.4m | ⚡ 21s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31876998155) | 2026-08-15 09:33:13 |
| React Native (RN Tester) | ✅ | 2.9m | 25s | 50s | 1.6m | ⚡ 8s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31876998155) | 2026-08-15 09:36:28 |
| Bluesky (social-app) | ✅ | 5.5m | 10s | 1.9m | 3.4m | ❗ 104s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31876998155) | 2026-08-15 09:42:27 |
| Mattermost Mobile | ✅ | 6.5m | 13s | 3.4m | 3.0m | ❗ 73s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31876998155) | 2026-08-15 09:49:33 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 11.9m | 12s | - | 11.7m | ⚡ 21s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31876998155) | 2026-08-15 09:39:00 |
| Wikipedia iOS | ✅ | 7.5m | 15s | 42s | 6.6m | ⚡ 54s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31876998155) | 2026-08-15 09:46:49 |
| DuckDuckGo iOS | ✅ | 12.5m | 6s | 2.3m | 10.1m | ❗ 227s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31876998155) | 2026-08-15 09:59:41 |
| React Native (RN Tester) | ✅ | 20.1m | 16s | 1.7m | 18.1m | ❗ 263s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31876998155) | 2026-08-15 10:20:25 |
| Bluesky (social-app) | ✅ | 28.6m | 9s | 3.5m | 25.0m | ❗ 96s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31876998155) | 2026-08-15 10:49:45 |
| Mattermost Mobile | ✅ | 31.3m | 9s | 9.1m | 22.1m | ⚡ 91s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31876998155) | 2026-08-15 11:21:38 |
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
