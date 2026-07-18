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
| XcodeBenchmark (anchor) | 1.9m | 12.1m | 6.5× |
| Wikipedia iOS | 1.6m | 7.2m | 4.6× |
| DuckDuckGo iOS | 1.8m | 10.6m | 5.7× |
| React Native (RN Tester) | 3.3m | 19.1m | 5.8× |
| Bluesky (social-app) | 4.9m | 27.7m | 5.7× |
| Mattermost Mobile | 5.3m | 34.2m | 6.4× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.9m | 14s | - | 1.6m | ⚡ 23s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29639757615) | 2026-07-18 09:50:20 |
| Wikipedia iOS | ✅ | 1.6m | 23s | 13s | 59s | ❗ 11s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29639757615) | 2026-07-18 09:52:19 |
| DuckDuckGo iOS | ✅ | 1.8m | 8s | 18s | 1.4m | ±0s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29639757615) | 2026-07-18 09:54:29 |
| React Native (RN Tester) | ✅ | 3.3m | 22s | 51s | 2.1m | ❗ 29s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29639757615) | 2026-07-18 09:58:10 |
| Bluesky (social-app) | ✅ | 4.9m | 10s | 1.8m | 3.0m | ⚡ 20s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29639757615) | 2026-07-18 10:03:36 |
| Mattermost Mobile | ✅ | 5.3m | 10s | 1.8m | 3.3m | ❗ 20s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29639757615) | 2026-07-18 10:09:34 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 12.1m | 11s | - | 11.9m | ⚡ 153s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29639757615) | 2026-07-18 10:00:19 |
| Wikipedia iOS | ✅ | 7.2m | 14s | 34s | 6.4m | ❗ 161s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29639757615) | 2026-07-18 10:07:49 |
| DuckDuckGo iOS | ✅ | 10.6m | 8s | 2.1m | 8.3m | ⚡ 364s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29639757615) | 2026-07-18 10:18:44 |
| React Native (RN Tester) | ✅ | 19.1m | 15s | 1.4m | 17.4m | ❗ 165s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29639757615) | 2026-07-18 10:38:15 |
| Bluesky (social-app) | ✅ | 27.7m | 6s | 3.2m | 24.4m | ⚡ 239s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29639757615) | 2026-07-18 11:06:30 |
| Mattermost Mobile | ✅ | 34.2m | 7s | 8.2m | 25.8m | ❗ 108s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29639757615) | 2026-07-18 11:41:55 |
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
