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
| XcodeBenchmark (anchor) | 2.0m | 18.2m | 9.2× |
| Wikipedia iOS | 1.6m | 5.0m | 3.0× |
| DuckDuckGo iOS | 1.5m | 7.6m | 5.1× |
| React Native (RN Tester) | 3.5m | 21.5m | 6.1× |
| Bluesky (social-app) | 5.7m | 25.4m | 4.4× |
| Mattermost Mobile | 4.1m | 29.9m | 7.4× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.0m | 22s | - | 1.6m | ❗ 5s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31939050849) | 2026-08-16 09:29:26 |
| Wikipedia iOS | ✅ | 1.6m | 26s | 7s | 1.1m | ❗ 9s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31939050849) | 2026-08-16 09:31:24 |
| DuckDuckGo iOS | ✅ | 1.5m | 10s | 18s | 1.0m | ⚡ 22s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31939050849) | 2026-08-16 09:33:12 |
| React Native (RN Tester) | ✅ | 3.5m | 34s | 1.0m | 1.9m | ❗ 38s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31939050849) | 2026-08-16 09:37:06 |
| Bluesky (social-app) | ✅ | 5.7m | 17s | 2.2m | 3.2m | ❗ 14s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31939050849) | 2026-08-16 09:43:21 |
| Mattermost Mobile | ✅ | 4.1m | 15s | 52s | 2.9m | ⚡ 148s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31939050849) | 2026-08-16 09:48:00 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 18.2m | 14s | - | 17.9m | ❗ 373s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31939050849) | 2026-08-16 09:45:20 |
| Wikipedia iOS | ✅ | 5.0m | 12s | 25s | 4.3m | ⚡ 153s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31939050849) | 2026-08-16 09:50:39 |
| DuckDuckGo iOS | ✅ | 7.6m | 5s | 1.4m | 6.1m | ⚡ 296s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31939050849) | 2026-08-16 09:58:34 |
| React Native (RN Tester) | ✅ | 21.5m | 22s | 2.3m | 18.8m | ❗ 83s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31939050849) | 2026-08-16 10:20:27 |
| Bluesky (social-app) | ✅ | 25.4m | 8s | 3.1m | 22.2m | ⚡ 190s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31939050849) | 2026-08-16 10:46:34 |
| Mattermost Mobile | ✅ | 29.9m | 8s | 8.4m | 21.3m | ⚡ 86s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31939050849) | 2026-08-16 11:17:07 |
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
