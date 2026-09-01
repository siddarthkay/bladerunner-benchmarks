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
| XcodeBenchmark (anchor) | 1.9m | 16.9m | 8.8× |
| Wikipedia iOS | 1.7m | 8.5m | 5.1× |
| DuckDuckGo iOS | 1.8m | 11.5m | 6.5× |
| React Native (RN Tester) | 2.5m | 14.8m | 5.9× |
| Bluesky (social-app) | 5.1m | 36.8m | 7.2× |
| Mattermost Mobile | 4.0m | 36.7m | 9.1× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.9m | 16s | - | 1.7m | ❗ 8s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33492571523) | 2026-09-01 09:33:10 |
| Wikipedia iOS | ✅ | 1.7m | 20s | 7s | 1.2m | ±0s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33492571523) | 2026-09-01 09:35:11 |
| DuckDuckGo iOS | ✅ | 1.8m | 8s | 18s | 1.4m | ⚡ 37s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33492571523) | 2026-09-01 09:37:20 |
| React Native (RN Tester) | ✅ | 2.5m | 26s | 24s | 1.7m | ⚡ 49s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33492571523) | 2026-09-01 09:40:13 |
| Bluesky (social-app) | ✅ | 5.1m | 10s | 1.7m | 3.2m | ⚡ 42s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33492571523) | 2026-09-01 09:45:48 |
| Mattermost Mobile | ✅ | 4.0m | 11s | 41s | 3.2m | ⚡ 86s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33492571523) | 2026-09-01 09:50:24 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 16.9m | 15s | - | 16.6m | ⚡ 27s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33492571523) | 2026-09-01 09:47:57 |
| Wikipedia iOS | ✅ | 8.5m | 20s | 47s | 7.3m | ❗ 7s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33492571523) | 2026-09-01 09:56:53 |
| DuckDuckGo iOS | ✅ | 11.5m | 7s | 2.3m | 9.2m | ❗ 44s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33492571523) | 2026-09-01 10:08:49 |
| React Native (RN Tester) | ✅ | 14.8m | 19s | 1.7m | 12.8m | ⚡ 290s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33492571523) | 2026-09-01 10:24:07 |
| Bluesky (social-app) | ✅ | 36.8m | 8s | 4.2m | 32.5m | ❗ 64s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33492571523) | 2026-09-01 11:01:27 |
| Mattermost Mobile | ✅ | 36.7m | 7s | 7.7m | 28.8m | ❗ 250s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33492571523) | 2026-09-01 11:39:13 |
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
