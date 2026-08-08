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
| XcodeBenchmark (anchor) | 1.6m | 11.1m | 6.7× |
| Wikipedia iOS | 1.5m | 7.7m | 5.2× |
| DuckDuckGo iOS | 1.3m | 11.1m | 8.5× |
| React Native (RN Tester) | 2.4m | 14.3m | 6.0× |
| Bluesky (social-app) | 3.9m | 6.7m | - |
| Mattermost Mobile | 5.5m | 31.2m | 5.7× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.6m | 15s | - | 1.4m | ⚡ 15s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31250642544) | 2026-08-08 09:30:41 |
| Wikipedia iOS | ✅ | 1.5m | 25s | 7s | 56s | ⚡ 5s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31250642544) | 2026-08-08 09:32:30 |
| DuckDuckGo iOS | ✅ | 1.3m | 8s | 18s | 53s | ⚡ 60s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31250642544) | 2026-08-08 09:34:09 |
| React Native (RN Tester) | ✅ | 2.4m | 23s | 24s | 1.6m | ⚡ 58s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31250642544) | 2026-08-08 09:36:57 |
| Bluesky (social-app) | ✅ | 3.9m | 10s | 38s | 3.1m | ⚡ 1s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31250642544) | 2026-08-08 09:41:22 |
| Mattermost Mobile | ✅ | 5.5m | 11s | 2.0m | 3.3m | ❗ 17s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31250642544) | 2026-08-08 09:47:28 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 11.1m | 11s | - | 10.9m | ⚡ 246s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31250642544) | 2026-08-08 09:39:54 |
| Wikipedia iOS | ✅ | 7.7m | 16s | 38s | 6.8m | ❗ 46s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31250642544) | 2026-08-08 09:47:54 |
| DuckDuckGo iOS | ✅ | 11.1m | 7s | 1.9m | 9.0m | ⚡ 82s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31250642544) | 2026-08-08 09:59:21 |
| React Native (RN Tester) | ✅ | 14.3m | 15s | 1.5m | 12.5m | ⚡ 380s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31250642544) | 2026-08-08 10:14:07 |
| Bluesky (social-app) | ❌ build | 6.7m | 7s | 3.0m | 3.6m | - | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31250642544) | 2026-08-08 10:21:18 |
| Mattermost Mobile | ✅ | 31.2m | 6s | 7.7m | 23.5m | ⚡ 304s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31250642544) | 2026-08-08 10:53:05 |
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
