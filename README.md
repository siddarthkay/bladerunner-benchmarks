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
| XcodeBenchmark (anchor) | 2.1m | 17.1m | 8.3× |
| Wikipedia iOS | 1.6m | 6.3m | 4.0× |
| DuckDuckGo iOS | 2.1m | 8.0m | 3.7× |
| React Native (RN Tester) | 2.8m | 21.7m | 7.7× |
| Bluesky (social-app) | 5.4m | 32.6m | 6.0× |
| Mattermost Mobile | 3.8m | 31.6m | 8.4× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.1m | 15s | - | 1.8m | ❗ 19s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29489125189) | 2026-07-16 10:01:25 |
| Wikipedia iOS | ✅ | 1.6m | 20s | 13s | 1.0m | ±0s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29489125189) | 2026-07-16 10:03:23 |
| DuckDuckGo iOS | ✅ | 2.1m | 8s | 41s | 1.3m | ❗ 47s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29489125189) | 2026-07-16 10:05:52 |
| React Native (RN Tester) | ✅ | 2.8m | 25s | 48s | 1.6m | ⚡ 27s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29489125189) | 2026-07-16 10:09:08 |
| Bluesky (social-app) | ✅ | 5.4m | 11s | 1.7m | 3.5m | ❗ 8s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29489125189) | 2026-07-16 10:15:04 |
| Mattermost Mobile | ✅ | 3.8m | 11s | 39s | 2.9m | ⚡ 108s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29489125189) | 2026-07-16 10:19:27 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 17.1m | 15s | - | 16.8m | ❗ 68s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29489125189) | 2026-07-16 10:16:16 |
| Wikipedia iOS | ✅ | 6.3m | 14s | 32s | 5.6m | ⚡ 78s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29489125189) | 2026-07-16 10:23:06 |
| DuckDuckGo iOS | ✅ | 8.0m | 6s | 1.5m | 6.4m | ⚡ 258s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29489125189) | 2026-07-16 10:31:23 |
| React Native (RN Tester) | ✅ | 21.7m | 24s | 2.3m | 19.0m | ⚡ 11s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29489125189) | 2026-07-16 10:53:31 |
| Bluesky (social-app) | ✅ | 32.6m | 10s | 3.8m | 28.6m | ⚡ 522s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29489125189) | 2026-07-16 11:26:34 |
| Mattermost Mobile | ✅ | 31.6m | 10s | 7.2m | 24.2m | ⚡ 354s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29489125189) | 2026-07-16 11:58:46 |
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
