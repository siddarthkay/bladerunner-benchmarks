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
| XcodeBenchmark (anchor) | 1.9m | 12.3m | 6.4× |
| Wikipedia iOS | 1.5m | 8.4m | 5.6× |
| DuckDuckGo iOS | 2.2m | 8.8m | 4.0× |
| React Native (RN Tester) | 3.0m | 15.7m | 5.2× |
| Bluesky (social-app) | 3.8m | 27.0m | 7.1× |
| Mattermost Mobile | 5.3m | 32.8m | 6.2× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.9m | 16s | - | 1.7m | ❗ 4s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31788929142) | 2026-08-14 09:41:19 |
| Wikipedia iOS | ✅ | 1.5m | 26s | 7s | 59s | ⚡ 2s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31788929142) | 2026-08-14 09:43:12 |
| DuckDuckGo iOS | ✅ | 2.2m | 12s | 43s | 1.3m | ⚡ 6s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31788929142) | 2026-08-14 09:45:46 |
| React Native (RN Tester) | ✅ | 3.0m | 28s | 58s | 1.6m | ±0s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31788929142) | 2026-08-14 09:49:10 |
| Bluesky (social-app) | ✅ | 3.8m | 12s | 41s | 2.9m | ❗ 5s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31788929142) | 2026-08-14 09:53:27 |
| Mattermost Mobile | ✅ | 5.3m | 14s | 2.1m | 3.0m | ⚡ 3s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31788929142) | 2026-08-14 09:59:23 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 12.3m | 12s | - | 12.1m | ⚡ 150s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31788929142) | 2026-08-14 09:51:26 |
| Wikipedia iOS | ✅ | 8.4m | 20s | 44s | 7.4m | ❗ 2s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31788929142) | 2026-08-14 10:00:17 |
| DuckDuckGo iOS | ✅ | 8.8m | 5s | 1.5m | 7.2m | ⚡ 162s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31788929142) | 2026-08-14 10:09:30 |
| React Native (RN Tester) | ✅ | 15.7m | 14s | 1.6m | 13.9m | ⚡ 468s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31788929142) | 2026-08-14 10:25:38 |
| Bluesky (social-app) | ✅ | 27.0m | 6s | 2.9m | 24.0m | ⚡ 672s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31788929142) | 2026-08-14 10:53:04 |
| Mattermost Mobile | ✅ | 32.8m | 8s | 8.6m | 24.1m | ❗ 368s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/31788929142) | 2026-08-14 11:26:48 |
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
