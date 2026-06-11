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
| XcodeBenchmark (anchor) | 1.8m | 13.0m | 7.2× |
| Wikipedia iOS | 1.5m | 7.2m | 4.8× |
| DuckDuckGo iOS | 2.5m | 7.9m | 3.2× |
| React Native (RN Tester) | 3.1m | 17.2m | 5.6× |
| Bluesky (social-app) | 5.1m | 33.0m | 6.4× |
| Mattermost Mobile | 3.9m | 35.7m | 9.1× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.8m | 15s | - | 1.5m | ⚡ 12s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27341894292) | 2026-06-11 10:57:46 |
| Wikipedia iOS | ✅ | 1.5m | 20s | 7s | 1.0m | ⚡ 3s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27341894292) | 2026-06-11 10:59:38 |
| DuckDuckGo iOS | ✅ | 2.5m | 8s | 45s | 1.6m | ⚡ 10s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27341894292) | 2026-06-11 11:02:31 |
| React Native (RN Tester) | ✅ | 3.1m | 24s | 48s | 1.9m | - | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27341894292) | 2026-06-11 11:06:03 |
| Bluesky (social-app) | ✅ | 5.1m | 8s | 1.6m | 3.4m | ❗ 5s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27341894292) | 2026-06-11 11:11:42 |
| Mattermost Mobile | ✅ | 3.9m | 10s | 36s | 3.1m | ❗ 2s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27341894292) | 2026-06-11 11:16:17 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 13.0m | 12s | - | 12.8m | ⚡ 226s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27341894292) | 2026-06-11 11:08:42 |
| Wikipedia iOS | ✅ | 7.2m | 19s | 34s | 6.3m | ⚡ 88s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27341894292) | 2026-06-11 11:16:16 |
| DuckDuckGo iOS | ✅ | 7.9m | 6s | 1.3m | 6.4m | ⚡ 123s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27341894292) | 2026-06-11 11:24:31 |
| React Native (RN Tester) | ✅ | 17.2m | 17s | 1.7m | 15.2m | - | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27341894292) | 2026-06-11 11:42:06 |
| Bluesky (social-app) | ✅ | 33.0m | 7s | 3.3m | 29.6m | ⚡ 122s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27341894292) | 2026-06-11 12:15:46 |
| Mattermost Mobile | ✅ | 35.7m | 9s | 8.5m | 27.0m | ⚡ 10s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27341894292) | 2026-06-11 12:52:24 |
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
