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
| XcodeBenchmark (anchor) | 1.8m | 11.4m | 6.2× |
| Wikipedia iOS | 1.7m | 7.8m | 4.6× |
| DuckDuckGo iOS | 2.4m | 12.4m | 5.2× |
| React Native (RN Tester) | 2.5m | 15.0m | 6.0× |
| Bluesky (social-app) | 3.9m | 22.5m | 5.8× |
| Mattermost Mobile | 4.7m | 39.4m | 8.4× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.8m | 15s | - | 1.6m | ⚡ 6s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28702647094) | 2026-07-04 10:01:29 |
| Wikipedia iOS | ✅ | 1.7m | 27s | 14s | 1.0m | ❗ 6s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28702647094) | 2026-07-04 10:03:31 |
| DuckDuckGo iOS | ✅ | 2.4m | 8s | 46s | 1.5m | ❗ 15s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28702647094) | 2026-07-04 10:06:20 |
| React Native (RN Tester) | ✅ | 2.5m | 26s | 25s | 1.6m | ⚡ 40s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28702647094) | 2026-07-04 10:09:14 |
| Bluesky (social-app) | ✅ | 3.9m | 12s | 39s | 3.0m | ⚡ 70s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28702647094) | 2026-07-04 10:13:38 |
| Mattermost Mobile | ✅ | 4.7m | 10s | 45s | 3.8m | ❗ 31s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28702647094) | 2026-07-04 10:18:57 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 11.4m | 15s | - | 11.1m | ⚡ 120s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28702647094) | 2026-07-04 10:10:50 |
| Wikipedia iOS | ✅ | 7.8m | 14s | 34s | 7.0m | ❗ 158s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28702647094) | 2026-07-04 10:18:59 |
| DuckDuckGo iOS | ✅ | 12.4m | 8s | 2.2m | 10.1m | ❗ 263s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28702647094) | 2026-07-04 10:31:45 |
| React Native (RN Tester) | ✅ | 15.0m | 19s | 2.3m | 12.3m | ⚡ 294s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28702647094) | 2026-07-04 10:47:12 |
| Bluesky (social-app) | ✅ | 22.5m | 6s | 2.8m | 19.6m | ⚡ 256s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28702647094) | 2026-07-04 11:10:02 |
| Mattermost Mobile | ✅ | 39.4m | 7s | 8.8m | 30.4m | ❗ 242s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28702647094) | 2026-07-04 11:50:02 |
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
