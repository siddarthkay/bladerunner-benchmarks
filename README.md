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
| XcodeBenchmark (anchor) | 2.1m | 10.3m | 4.9× |
| Wikipedia iOS | 1.6m | 5.6m | 3.5× |
| DuckDuckGo iOS | 1.3m | 9.6m | 7.2× |
| React Native (RN Tester) | 2.7m | 14.6m | 5.4× |
| Bluesky (social-app) | 5.4m | 21.9m | 4.1× |
| Mattermost Mobile | 4.9m | 30.5m | 6.3× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.1m | 14s | - | 1.9m | ❗ 25s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27463837534) | 2026-06-13 10:15:03 |
| Wikipedia iOS | ✅ | 1.6m | 18s | 7s | 1.2m | ⚡ 3s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27463837534) | 2026-06-13 10:17:00 |
| DuckDuckGo iOS | ✅ | 1.3m | 7s | 18s | 54s | ⚡ 103s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27463837534) | 2026-06-13 10:18:40 |
| React Native (RN Tester) | ✅ | 2.7m | 21s | 27s | 1.9m | ❗ 4s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27463837534) | 2026-06-13 10:21:50 |
| Bluesky (social-app) | ✅ | 5.4m | 9s | 1.8m | 3.5m | ❗ 84s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27463837534) | 2026-06-13 10:28:06 |
| Mattermost Mobile | ✅ | 4.9m | 10s | 42s | 4.0m | ❗ 23s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27463837534) | 2026-06-13 10:33:34 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 10.3m | 12s | - | 10.1m | ⚡ 458s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27463837534) | 2026-06-13 10:23:04 |
| Wikipedia iOS | ✅ | 5.6m | 13s | 24s | 5.0m | ❗ 40s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27463837534) | 2026-06-13 10:28:57 |
| DuckDuckGo iOS | ✅ | 9.6m | 7s | 1.9m | 7.7m | ⚡ 4s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27463837534) | 2026-06-13 10:38:55 |
| React Native (RN Tester) | ✅ | 14.6m | 14s | 1.5m | 12.8m | ⚡ 41s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27463837534) | 2026-06-13 10:53:52 |
| Bluesky (social-app) | ✅ | 21.9m | 5s | 2.6m | 19.2m | ⚡ 422s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27463837534) | 2026-06-13 11:16:13 |
| Mattermost Mobile | ✅ | 30.5m | 7s | 6.6m | 23.9m | ❗ 12s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27463837534) | 2026-06-13 11:47:16 |
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
