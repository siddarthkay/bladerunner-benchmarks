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
| XcodeBenchmark (anchor) | 2.2m | 14.7m | 6.8× |
| Wikipedia iOS | 1.5m | 6.5m | 4.4× |
| DuckDuckGo iOS | 2.3m | 10.9m | 4.7× |
| React Native (RN Tester) | 2.9m | 16.6m | 5.7× |
| Bluesky (social-app) | 5.0m | 22.6m | 4.5× |
| Mattermost Mobile | 5.2m | 37.0m | 7.1× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.2m | 16s | - | 1.9m | ⚡ 37s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34024572055) | 2026-09-06 09:27:46 |
| Wikipedia iOS | ✅ | 1.5m | 23s | 7s | 59s | ❗ 1s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34024572055) | 2026-09-06 09:29:37 |
| DuckDuckGo iOS | ✅ | 2.3m | 9s | 46s | 1.4m | ❗ 62s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34024572055) | 2026-09-06 09:32:16 |
| React Native (RN Tester) | ✅ | 2.9m | 25s | 47s | 1.7m | ⚡ 15s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34024572055) | 2026-09-06 09:35:41 |
| Bluesky (social-app) | ✅ | 5.0m | 10s | 1.7m | 3.1m | ⚡ 28s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34024572055) | 2026-09-06 09:41:11 |
| Mattermost Mobile | ✅ | 5.2m | 11s | 2.0m | 3.0m | ❗ 52s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34024572055) | 2026-09-06 09:47:01 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 14.7m | 13s | - | 14.5m | ❗ 41s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34024572055) | 2026-09-06 09:40:09 |
| Wikipedia iOS | ✅ | 6.5m | 16s | 37s | 5.7m | ⚡ 7s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34024572055) | 2026-09-06 09:47:11 |
| DuckDuckGo iOS | ✅ | 10.9m | 5s | 1.9m | 8.9m | ⚡ 150s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34024572055) | 2026-09-06 09:58:21 |
| React Native (RN Tester) | ✅ | 16.6m | 16s | 1.8m | 14.5m | ⚡ 53s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34024572055) | 2026-09-06 10:15:38 |
| Bluesky (social-app) | ✅ | 22.6m | 6s | 2.8m | 19.7m | ⚡ 263s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34024572055) | 2026-09-06 10:38:48 |
| Mattermost Mobile | ✅ | 37.0m | 9s | 9.2m | 27.7m | ❗ 238s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34024572055) | 2026-09-06 11:16:33 |
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
