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
| XcodeBenchmark (anchor) | 1.7m | 15.7m | 9.0× |
| Wikipedia iOS | 1.7m | 9.3m | 5.6× |
| DuckDuckGo iOS | 2.1m | 10.9m | 5.3× |
| React Native (RN Tester) | 3.3m | 19.1m | 5.9× |
| Bluesky (social-app) | 5.5m | 27.0m | 4.9× |
| Mattermost Mobile | 5.7m | 37.5m | 6.6× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.7m | 20s | - | 1.4m | ❗ 6s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32237717738) | 2026-08-19 09:30:15 |
| Wikipedia iOS | ✅ | 1.7m | 23s | 13s | 1.1m | ❗ 22s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32237717738) | 2026-08-19 09:32:17 |
| DuckDuckGo iOS | ✅ | 2.1m | 9s | 41s | 1.2m | ⚡ 8s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32237717738) | 2026-08-19 09:34:42 |
| React Native (RN Tester) | ✅ | 3.3m | 25s | 52s | 2.0m | ❗ 33s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32237717738) | 2026-08-19 09:38:22 |
| Bluesky (social-app) | ✅ | 5.5m | 12s | 1.9m | 3.4m | ❗ 19s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32237717738) | 2026-08-19 09:44:25 |
| Mattermost Mobile | ✅ | 5.7m | 12s | 2.1m | 3.4m | ❗ 22s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32237717738) | 2026-08-19 09:50:43 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 15.7m | 11s | - | 15.5m | ⚡ 64s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32237717738) | 2026-08-19 09:44:03 |
| Wikipedia iOS | ✅ | 9.3m | 16s | 44s | 8.3m | ❗ 196s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32237717738) | 2026-08-19 09:53:59 |
| DuckDuckGo iOS | ✅ | 10.9m | 8s | 2.3m | 8.5m | ❗ 6s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32237717738) | 2026-08-19 10:05:16 |
| React Native (RN Tester) | ✅ | 19.1m | 23s | 2.1m | 16.6m | ⚡ 92s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32237717738) | 2026-08-19 10:24:57 |
| Bluesky (social-app) | ✅ | 27.0m | 8s | 3.4m | 23.5m | ⚡ 572s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32237717738) | 2026-08-19 10:52:27 |
| Mattermost Mobile | ✅ | 37.5m | 12s | 7.9m | 29.4m | ❗ 242s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32237717738) | 2026-08-19 11:30:35 |
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
