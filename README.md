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
| XcodeBenchmark (anchor) | 1.8m | 14.8m | 8.4× |
| Wikipedia iOS | 1.6m | 6.0m | 3.9× |
| DuckDuckGo iOS | 1.3m | 9.9m | 7.4× |
| React Native (RN Tester) | 3.0m | 13.8m | 4.5× |
| Bluesky (social-app) | 5.5m | 24.3m | 4.4× |
| Mattermost Mobile | 3.9m | 33.0m | 8.4× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.8m | 16s | - | 1.5m | ±0s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30084678375) | 2026-07-24 10:03:34 |
| Wikipedia iOS | ✅ | 1.6m | 22s | 13s | 58s | ⚡ 4s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30084678375) | 2026-07-24 10:05:31 |
| DuckDuckGo iOS | ✅ | 1.3m | 9s | 18s | 53s | ⚡ 71s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30084678375) | 2026-07-24 10:07:18 |
| React Native (RN Tester) | ✅ | 3.0m | 34s | 46s | 1.7m | ⚡ 18s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30084678375) | 2026-07-24 10:10:50 |
| Bluesky (social-app) | ✅ | 5.5m | 11s | 1.9m | 3.5m | ⚡ 17s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30084678375) | 2026-07-24 10:16:50 |
| Mattermost Mobile | ✅ | 3.9m | 10s | 40s | 3.1m | ⚡ 101s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30084678375) | 2026-07-24 10:21:32 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 14.8m | 12s | - | 14.6m | ⚡ 104s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30084678375) | 2026-07-24 10:16:27 |
| Wikipedia iOS | ✅ | 6.0m | 13s | 22s | 5.4m | ⚡ 22s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30084678375) | 2026-07-24 10:22:53 |
| DuckDuckGo iOS | ✅ | 9.9m | 7s | 2.1m | 7.7m | ⚡ 80s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30084678375) | 2026-07-24 10:33:06 |
| React Native (RN Tester) | ✅ | 13.8m | 17s | 1.8m | 11.7m | ⚡ 332s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30084678375) | 2026-07-24 10:47:17 |
| Bluesky (social-app) | ✅ | 24.3m | 6s | 2.7m | 21.5m | ⚡ 806s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30084678375) | 2026-07-24 11:12:02 |
| Mattermost Mobile | ✅ | 33.0m | 8s | 8.3m | 24.5m | ❗ 119s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30084678375) | 2026-07-24 11:45:42 |
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
