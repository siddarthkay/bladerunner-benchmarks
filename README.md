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
| XcodeBenchmark (anchor) | 1.9m | 14.2m | 7.4× |
| Wikipedia iOS | 1.4m | 6.0m | 4.3× |
| DuckDuckGo iOS | 2.5m | 8.2m | 3.3× |
| React Native (RN Tester) | 2.8m | 19.2m | 6.9× |
| Bluesky (social-app) | 5.8m | 27.9m | 4.8× |
| Mattermost Mobile | 5.2m | 28.4m | 5.4× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.9m | 15s | - | 1.7m | ⚡ 51s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26680954455) | 2026-05-30 10:00:49 |
| Wikipedia iOS | ✅ | 1.4m | 18s | 6s | 60s | ⚡ 16s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26680954455) | 2026-05-30 10:02:36 |
| DuckDuckGo iOS | ✅ | 2.5m | 8s | 42s | 1.7m | ❗ 24s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26680954455) | 2026-05-30 10:05:27 |
| React Native (RN Tester) | ✅ | 2.8m | 21s | 24s | 2.1m | ⚡ 6s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26680954455) | 2026-05-30 10:08:42 |
| Bluesky (social-app) | ✅ | 5.8m | 10s | 2.1m | 3.6m | ❗ 61s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26680954455) | 2026-05-30 10:15:02 |
| Mattermost Mobile | ✅ | 5.2m | 9s | 1.9m | 3.2m | ⚡ 27s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26680954455) | 2026-05-30 10:20:54 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 14.2m | 12s | - | 14.0m | ❗ 241s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26680954455) | 2026-05-30 10:12:49 |
| Wikipedia iOS | ✅ | 6.0m | 14s | 41s | 5.1m | ❗ 18s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26680954455) | 2026-05-30 10:19:13 |
| DuckDuckGo iOS | ✅ | 8.2m | 7s | 1.7m | 6.4m | ⚡ 115s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26680954455) | 2026-05-30 10:27:40 |
| React Native (RN Tester) | ✅ | 19.2m | 13s | 2.0m | 17.0m | ❗ 265s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26680954455) | 2026-05-30 10:47:16 |
| Bluesky (social-app) | ✅ | 27.9m | 7s | 3.3m | 24.6m | ⚡ 123s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26680954455) | 2026-05-30 11:15:38 |
| Mattermost Mobile | ✅ | 28.4m | 5s | 6.8m | 21.5m | ⚡ 364s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26680954455) | 2026-05-30 11:44:38 |
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
