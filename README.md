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
| XcodeBenchmark (anchor) | 3.0m | 12.3m | 4.2× |
| Wikipedia iOS | 1.7m | 5.5m | 3.3× |
| DuckDuckGo iOS | 2.4m | 10.0m | 4.2× |
| React Native (RN Tester) | 2.4m | 13.5m | 5.6× |
| Bluesky (social-app) | 4.5m | 28.0m | 6.3× |
| Mattermost Mobile | 5.3m | 27.1m | 5.1× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 3.0m | 15s | - | 2.7m | ❗ 45s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27132990098) | 2026-06-08 11:01:09 |
| Wikipedia iOS | ✅ | 1.7m | 21s | 7s | 1.2m | ❗ 11s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27132990098) | 2026-06-08 11:03:11 |
| DuckDuckGo iOS | ✅ | 2.4m | 7s | 44s | 1.5m | ❗ 62s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27132990098) | 2026-06-08 11:05:54 |
| React Native (RN Tester) | ✅ | 2.4m | 21s | 24s | 1.7m | ⚡ 82s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27132990098) | 2026-06-08 11:08:47 |
| Bluesky (social-app) | ✅ | 4.5m | 9s | 38s | 3.7m | ⚡ 46s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27132990098) | 2026-06-08 11:13:48 |
| Mattermost Mobile | ✅ | 5.3m | 10s | 2.0m | 3.2m | ❗ 81s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27132990098) | 2026-06-08 11:19:43 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 12.3m | 15s | - | 12.1m | ❗ 114s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27132990098) | 2026-06-08 11:10:17 |
| Wikipedia iOS | ✅ | 5.5m | 12s | 23s | 4.9m | ⚡ 62s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27132990098) | 2026-06-08 11:16:06 |
| DuckDuckGo iOS | ✅ | 10.0m | 5s | 1.7m | 8.2m | ⚡ 85s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27132990098) | 2026-06-08 11:26:27 |
| React Native (RN Tester) | ✅ | 13.5m | 12s | 1.4m | 11.9m | ⚡ 36s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27132990098) | 2026-06-08 11:40:25 |
| Bluesky (social-app) | ✅ | 28.0m | 7s | 3.2m | 24.7m | ⚡ 150s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27132990098) | 2026-06-08 12:08:52 |
| Mattermost Mobile | ✅ | 27.1m | 8s | 6.8m | 20.1m | ⚡ 187s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27132990098) | 2026-06-08 12:36:27 |
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
