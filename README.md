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
| XcodeBenchmark (anchor) | 2.7m | 10.1m | 3.7× |
| Wikipedia iOS | 1.5m | 5.7m | 3.9× |
| DuckDuckGo iOS | 1.2m | 11.3m | 9.1× |
| React Native (RN Tester) | 2.4m | 15.4m | 6.3× |
| Bluesky (social-app) | 5.0m | 25.8m | 5.2× |
| Mattermost Mobile | 5.5m | 25.6m | 4.7× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.7m | 16s | - | 2.4m | ❗ 52s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26946280603) | 2026-06-04 10:34:22 |
| Wikipedia iOS | ✅ | 1.5m | 22s | 7s | 60s | ❗ 8s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26946280603) | 2026-06-04 10:36:13 |
| DuckDuckGo iOS | ✅ | 1.2m | 8s | 18s | 49s | ⚡ 63s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26946280603) | 2026-06-04 10:37:50 |
| React Native (RN Tester) | ✅ | 2.4m | 22s | 24s | 1.7m | ⚡ 25s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26946280603) | 2026-06-04 10:40:39 |
| Bluesky (social-app) | ✅ | 5.0m | 8s | 1.6m | 3.3m | ❗ 25s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26946280603) | 2026-06-04 10:46:07 |
| Mattermost Mobile | ✅ | 5.5m | 10s | 2.0m | 3.3m | ❗ 14s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26946280603) | 2026-06-04 10:52:13 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 10.1m | 11s | - | 10.0m | ⚡ 79s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26946280603) | 2026-06-04 10:41:33 |
| Wikipedia iOS | ✅ | 5.7m | 19s | 36s | 4.8m | ⚡ 228s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26946280603) | 2026-06-04 10:47:31 |
| DuckDuckGo iOS | ✅ | 11.3m | 6s | 2.0m | 9.2m | ⚡ 133s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26946280603) | 2026-06-04 10:59:07 |
| React Native (RN Tester) | ✅ | 15.4m | 15s | 1.6m | 13.5m | ❗ 134s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26946280603) | 2026-06-04 11:14:55 |
| Bluesky (social-app) | ✅ | 25.8m | 6s | 3.7m | 22.1m | ⚡ 213s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26946280603) | 2026-06-04 11:41:15 |
| Mattermost Mobile | ✅ | 25.6m | 6s | 6.2m | 19.4m | ⚡ 654s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26946280603) | 2026-06-04 12:07:31 |
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
