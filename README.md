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
| XcodeBenchmark (anchor) | 3.0m | 12.7m | 4.2× |
| Wikipedia iOS | 1.5m | 6.7m | 4.6× |
| DuckDuckGo iOS | 1.9m | 7.8m | 4.0× |
| React Native (RN Tester) | 3.1m | 14.4m | 4.6× |
| Bluesky (social-app) | 5.4m | 21.4m | 3.9× |
| Mattermost Mobile | 5.4m | 38.1m | 7.0× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 3.0m | 15s | - | 2.8m | ❗ 80s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30197379193) | 2026-07-26 10:01:03 |
| Wikipedia iOS | ✅ | 1.5m | 19s | 13s | 56s | ±0s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30197379193) | 2026-07-26 10:02:52 |
| DuckDuckGo iOS | ✅ | 1.9m | 8s | 18s | 1.5m | ❗ 39s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30197379193) | 2026-07-26 10:05:09 |
| React Native (RN Tester) | ✅ | 3.1m | 26s | 45s | 2.0m | ±0s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30197379193) | 2026-07-26 10:08:45 |
| Bluesky (social-app) | ✅ | 5.4m | 11s | 1.8m | 3.5m | ❗ 90s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30197379193) | 2026-07-26 10:14:41 |
| Mattermost Mobile | ✅ | 5.4m | 11s | 2.2m | 3.0m | ❗ 14s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30197379193) | 2026-07-26 10:20:48 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 12.7m | 11s | - | 12.6m | ❗ 100s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30197379193) | 2026-07-26 10:10:33 |
| Wikipedia iOS | ✅ | 6.7m | 15s | 28s | 6.0m | ⚡ 34s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30197379193) | 2026-07-26 10:17:36 |
| DuckDuckGo iOS | ✅ | 7.8m | 6s | 1.5m | 6.3m | ⚡ 277s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30197379193) | 2026-07-26 10:25:46 |
| React Native (RN Tester) | ✅ | 14.4m | 22s | 1.5m | 12.5m | ⚡ 212s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30197379193) | 2026-07-26 10:40:33 |
| Bluesky (social-app) | ✅ | 21.4m | 5s | 2.6m | 18.7m | ⚡ 278s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30197379193) | 2026-07-26 11:02:27 |
| Mattermost Mobile | ✅ | 38.1m | 6s | 7.3m | 30.8m | ❗ 40s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30197379193) | 2026-07-26 11:41:09 |
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
