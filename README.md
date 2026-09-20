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
| XcodeBenchmark (anchor) | 1.8m | 13.3m | 7.5× |
| Wikipedia iOS | 51s | 5.4m | - |
| DuckDuckGo iOS | 2.1m | 9.8m | 4.7× |
| React Native (RN Tester) | 2.7m | 18.0m | 6.6× |
| Bluesky (social-app) | 5.4m | 30.3m | 5.6× |
| Mattermost Mobile | 3.8m | 40.9m | 10.8× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.8m | 15s | - | 1.5m | ±0s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35502283199) | 2026-09-20 09:28:22 |
| Wikipedia iOS | ❌ build | 51s | 26s | 7s | 17s | - | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35502283199) | 2026-09-20 09:29:35 |
| DuckDuckGo iOS | ✅ | 2.1m | 8s | 42s | 1.3m | ❗ 17s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35502283199) | 2026-09-20 09:32:02 |
| React Native (RN Tester) | ✅ | 2.7m | 22s | 25s | 1.9m | ⚡ 26s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35502283199) | 2026-09-20 09:35:12 |
| Bluesky (social-app) | ✅ | 5.4m | 9s | 1.8m | 3.5m | ❗ 20s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35502283199) | 2026-09-20 09:41:06 |
| Mattermost Mobile | ✅ | 3.8m | 11s | 49s | 2.8m | ⚡ 7s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35502283199) | 2026-09-20 09:45:26 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 13.3m | 11s | - | 13.1m | ❗ 170s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35502283199) | 2026-09-20 09:39:43 |
| Wikipedia iOS | ✅ | 5.4m | 15s | 25s | 4.7m | ⚡ 144s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35502283199) | 2026-09-20 09:45:35 |
| DuckDuckGo iOS | ✅ | 9.8m | 6s | 2.1m | 7.6m | ❗ 43s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35502283199) | 2026-09-20 09:55:47 |
| React Native (RN Tester) | ✅ | 18.0m | 18s | 2.1m | 15.6m | ❗ 239s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35502283199) | 2026-09-20 10:14:21 |
| Bluesky (social-app) | ✅ | 30.3m | 7s | 4.3m | 25.9m | ❗ 152s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35502283199) | 2026-09-20 10:45:10 |
| Mattermost Mobile | ✅ | 40.9m | 8s | 9.3m | 31.5m | ❗ 299s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/35502283199) | 2026-09-20 11:26:49 |
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
