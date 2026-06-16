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
| XcodeBenchmark (anchor) | 2.1m | 15.6m | 7.3× |
| Wikipedia iOS | 1.5m | 8.3m | 5.6× |
| DuckDuckGo iOS | 1.4m | 11.9m | 8.7× |
| React Native (RN Tester) | 2.9m | 17.5m | 6.1× |
| Bluesky (social-app) | 5.3m | 22.9m | 4.4× |
| Mattermost Mobile | 5.8m | 29.1m | 5.0× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.1m | 20s | - | 1.8m | ⚡ 77s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27612746660) | 2026-06-16 11:01:36 |
| Wikipedia iOS | ✅ | 1.5m | 25s | 7s | 58s | ⚡ 4s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27612746660) | 2026-06-16 11:03:28 |
| DuckDuckGo iOS | ✅ | 1.4m | 10s | 20s | 52s | ❗ 3s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27612746660) | 2026-06-16 11:05:12 |
| React Native (RN Tester) | ✅ | 2.9m | 28s | 28s | 1.9m | ⚡ 4s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27612746660) | 2026-06-16 11:08:29 |
| Bluesky (social-app) | ✅ | 5.3m | 11s | 1.7m | 3.3m | ❗ 77s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27612746660) | 2026-06-16 11:14:16 |
| Mattermost Mobile | ✅ | 5.8m | 20s | 2.1m | 3.4m | ❗ 21s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27612746660) | 2026-06-16 11:20:45 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 15.6m | 13s | - | 15.4m | ⚡ 95s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27612746660) | 2026-06-16 11:14:53 |
| Wikipedia iOS | ✅ | 8.3m | 12s | 30s | 7.6m | ❗ 110s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27612746660) | 2026-06-16 11:23:36 |
| DuckDuckGo iOS | ✅ | 11.9m | 5s | 2.2m | 9.6m | ❗ 257s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27612746660) | 2026-06-16 11:35:58 |
| React Native (RN Tester) | ✅ | 17.5m | 17s | 1.7m | 15.5m | ⚡ 98s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27612746660) | 2026-06-16 11:53:48 |
| Bluesky (social-app) | ✅ | 22.9m | 5s | 2.7m | 20.2m | ⚡ 708s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27612746660) | 2026-06-16 12:17:16 |
| Mattermost Mobile | ✅ | 29.1m | 7s | 6.7m | 22.3m | ⚡ 209s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27612746660) | 2026-06-16 12:47:10 |
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
