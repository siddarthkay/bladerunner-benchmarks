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
| XcodeBenchmark (anchor) | 2.3m | 14.4m | 6.3× |
| Wikipedia iOS | 1.5m | 7.1m | 4.7× |
| DuckDuckGo iOS | 2.6m | 11.0m | 4.3× |
| React Native (RN Tester) | 2.7m | 18.1m | 6.7× |
| Bluesky (social-app) | 5.2m | 26.6m | 5.1× |
| Mattermost Mobile | 4.1m | 38.2m | 9.4× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.3m | 16s | - | 2.0m | ❗ 28s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32564946790) | 2026-08-22 09:29:34 |
| Wikipedia iOS | ✅ | 1.5m | 19s | 13s | 58s | ⚡ 2s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32564946790) | 2026-08-22 09:31:24 |
| DuckDuckGo iOS | ✅ | 2.6m | 20s | 51s | 1.4m | ❗ 32s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32564946790) | 2026-08-22 09:34:18 |
| React Native (RN Tester) | ✅ | 2.7m | 21s | 46s | 1.6m | ⚡ 3s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32564946790) | 2026-08-22 09:37:23 |
| Bluesky (social-app) | ✅ | 5.2m | 10s | 1.6m | 3.4m | ❗ 4s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32564946790) | 2026-08-22 09:43:01 |
| Mattermost Mobile | ✅ | 4.1m | 11s | 47s | 3.1m | ❗ 28s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32564946790) | 2026-08-22 09:47:40 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 14.4m | 14s | - | 14.2m | ❗ 44s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32564946790) | 2026-08-22 09:41:32 |
| Wikipedia iOS | ✅ | 7.1m | 14s | 22s | 6.5m | ⚡ 31s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32564946790) | 2026-08-22 09:48:56 |
| DuckDuckGo iOS | ✅ | 11.0m | 6s | 2.2m | 8.7m | ⚡ 33s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32564946790) | 2026-08-22 10:00:19 |
| React Native (RN Tester) | ✅ | 18.1m | 14s | 1.9m | 16.0m | ⚡ 528s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32564946790) | 2026-08-22 10:18:57 |
| Bluesky (social-app) | ✅ | 26.6m | 6s | 3.1m | 23.4m | ⚡ 28s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32564946790) | 2026-08-22 10:46:05 |
| Mattermost Mobile | ✅ | 38.2m | 7s | 8.6m | 29.5m | ❗ 344s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32564946790) | 2026-08-22 11:25:12 |
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
