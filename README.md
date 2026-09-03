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
| XcodeBenchmark (anchor) | 2.0m | 10.2m | 5.0× |
| Wikipedia iOS | 1.6m | 7.6m | 4.8× |
| DuckDuckGo iOS | 2.1m | 11.4m | 5.4× |
| React Native (RN Tester) | 3.2m | 19.5m | 6.1× |
| Bluesky (social-app) | 5.2m | 35.1m | 6.8× |
| Mattermost Mobile | 3.6m | 41.8m | 11.6× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.0m | 15s | - | 1.8m | ❗ 5s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33739132182) | 2026-09-03 09:32:24 |
| Wikipedia iOS | ✅ | 1.6m | 26s | 7s | 1.0m | ⚡ 5s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33739132182) | 2026-09-03 09:34:20 |
| DuckDuckGo iOS | ✅ | 2.1m | 8s | 42s | 1.3m | ⚡ 2s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33739132182) | 2026-09-03 09:36:48 |
| React Native (RN Tester) | ✅ | 3.2m | 24s | 56s | 1.8m | ❗ 39s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33739132182) | 2026-09-03 09:40:27 |
| Bluesky (social-app) | ✅ | 5.2m | 11s | 1.9m | 3.1m | ❗ 74s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33739132182) | 2026-09-03 09:46:05 |
| Mattermost Mobile | ✅ | 3.6m | 13s | 42s | 2.7m | ⚡ 13s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33739132182) | 2026-09-03 09:50:18 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 10.2m | 10s | - | 10.0m | ⚡ 101s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33739132182) | 2026-09-03 09:40:23 |
| Wikipedia iOS | ✅ | 7.6m | 17s | 28s | 6.8m | ⚡ 39s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33739132182) | 2026-09-03 09:48:19 |
| DuckDuckGo iOS | ✅ | 11.4m | 6s | 2.1m | 9.2m | ⚡ 87s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33739132182) | 2026-09-03 10:00:12 |
| React Native (RN Tester) | ✅ | 19.5m | 21s | 2.2m | 16.9m | ⚡ 178s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33739132182) | 2026-09-03 10:20:13 |
| Bluesky (social-app) | ✅ | 35.1m | 8s | 3.9m | 31.1m | ❗ 111s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33739132182) | 2026-09-03 10:55:55 |
| Mattermost Mobile | ✅ | 41.8m | 7s | 9.5m | 32.2m | ❗ 257s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33739132182) | 2026-09-03 11:38:46 |
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
