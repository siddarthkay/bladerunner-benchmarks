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
| XcodeBenchmark (anchor) | 1.7m | 15.0m | 8.7× |
| Wikipedia iOS | 1.7m | 8.6m | 5.0× |
| DuckDuckGo iOS | 2.2m | 11.2m | 5.1× |
| React Native (RN Tester) | 3.2m | 18.6m | 5.8× |
| Bluesky (social-app) | 4.1m | 35.8m | 8.8× |
| Mattermost Mobile | 5.5m | 36.9m | 6.7× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.7m | 16s | - | 1.5m | ⚡ 1s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32354002973) | 2026-08-20 09:30:38 |
| Wikipedia iOS | ✅ | 1.7m | 27s | 7s | 1.2m | ❗ 3s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32354002973) | 2026-08-20 09:32:53 |
| DuckDuckGo iOS | ✅ | 2.2m | 8s | 41s | 1.4m | ❗ 8s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32354002973) | 2026-08-20 09:35:33 |
| React Native (RN Tester) | ✅ | 3.2m | 22s | 46s | 2.1m | ⚡ 3s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32354002973) | 2026-08-20 09:39:08 |
| Bluesky (social-app) | ✅ | 4.1m | 10s | 37s | 3.3m | ⚡ 88s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32354002973) | 2026-08-20 09:43:45 |
| Mattermost Mobile | ✅ | 5.5m | 12s | 1.9m | 3.4m | ⚡ 9s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32354002973) | 2026-08-20 09:49:53 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 15.0m | 16s | - | 14.8m | ⚡ 41s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32354002973) | 2026-08-20 09:43:38 |
| Wikipedia iOS | ✅ | 8.6m | 16s | 44s | 7.6m | ⚡ 42s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32354002973) | 2026-08-20 09:52:47 |
| DuckDuckGo iOS | ✅ | 11.2m | 6s | 1.9m | 9.2m | ❗ 22s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32354002973) | 2026-08-20 10:04:33 |
| React Native (RN Tester) | ✅ | 18.6m | 18s | 1.8m | 16.5m | ⚡ 32s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32354002973) | 2026-08-20 10:23:34 |
| Bluesky (social-app) | ✅ | 35.8m | 6s | 3.8m | 31.9m | ❗ 529s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32354002973) | 2026-08-20 10:59:52 |
| Mattermost Mobile | ✅ | 36.9m | 6s | 8.9m | 27.9m | ⚡ 37s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32354002973) | 2026-08-20 11:38:02 |
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
