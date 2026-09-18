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
| XcodeBenchmark (anchor) | 2.5m | 14.3m | 5.8× |
| Wikipedia iOS | 53s | 6.3m | - |
| DuckDuckGo iOS | 2.2m | 12.9m | 5.9× |
| React Native (RN Tester) | 2.7m | 23.1m | 8.5× |
| Bluesky (social-app) | 5.5m | 21.8m | 4.0× |
| Mattermost Mobile | 5.2m | 36.8m | 7.1× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.5m | 15s | - | 2.2m | ❗ 40s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35329739766) | 2026-09-18 09:32:05 |
| Wikipedia iOS | ❌ build | 53s | 24s | 13s | 16s | - | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35329739766) | 2026-09-18 09:33:19 |
| DuckDuckGo iOS | ✅ | 2.2m | 9s | 42s | 1.3m | ⚡ 17s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35329739766) | 2026-09-18 09:35:50 |
| React Native (RN Tester) | ✅ | 2.7m | 23s | 25s | 1.9m | ⚡ 30s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35329739766) | 2026-09-18 09:38:57 |
| Bluesky (social-app) | ✅ | 5.5m | 11s | 1.9m | 3.4m | ❗ 102s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35329739766) | 2026-09-18 09:44:55 |
| Mattermost Mobile | ✅ | 5.2m | 10s | 2.1m | 2.9m | ⚡ 19s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35329739766) | 2026-09-18 09:50:47 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 14.3m | 15s | - | 14.1m | ⚡ 78s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35329739766) | 2026-09-18 09:43:51 |
| Wikipedia iOS | ✅ | 6.3m | 20s | 47s | 5.2m | ⚡ 93s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35329739766) | 2026-09-18 09:50:41 |
| DuckDuckGo iOS | ✅ | 12.9m | 8s | 2.2m | 10.6m | ❗ 257s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35329739766) | 2026-09-18 10:03:56 |
| React Native (RN Tester) | ✅ | 23.1m | 20s | 2.3m | 20.5m | ❗ 377s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35329739766) | 2026-09-18 10:27:50 |
| Bluesky (social-app) | ✅ | 21.8m | 7s | 2.8m | 18.8m | ⚡ 402s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35329739766) | 2026-09-18 10:50:14 |
| Mattermost Mobile | ✅ | 36.8m | 8s | 8.4m | 28.3m | ⚡ 221s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35329739766) | 2026-09-18 11:27:38 |
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
