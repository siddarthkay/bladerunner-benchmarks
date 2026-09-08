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
| XcodeBenchmark (anchor) | 1.8m | 14.4m | 7.8× |
| Wikipedia iOS | 1.4m | 7.2m | 5.1× |
| DuckDuckGo iOS | 1.8m | 14.2m | 7.7× |
| React Native (RN Tester) | 3.4m | 22.5m | 6.6× |
| Bluesky (social-app) | 5.5m | 29.2m | 5.3× |
| Mattermost Mobile | 7.0m | 42.8m | 6.1× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.8m | 16s | - | 1.6m | ❗ 10s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34210255662) | 2026-09-08 09:31:56 |
| Wikipedia iOS | ✅ | 1.4m | 24s | 7s | 54s | ⚡ 16s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34210255662) | 2026-09-08 09:33:45 |
| DuckDuckGo iOS | ✅ | 1.8m | 12s | 18s | 1.3m | ⚡ 11s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34210255662) | 2026-09-08 09:35:58 |
| React Native (RN Tester) | ✅ | 3.4m | 27s | 53s | 2.1m | ❗ 13s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34210255662) | 2026-09-08 09:39:50 |
| Bluesky (social-app) | ✅ | 5.5m | 10s | 1.8m | 3.5m | ❗ 88s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34210255662) | 2026-09-08 09:45:49 |
| Mattermost Mobile | ✅ | 7.0m | 11s | 3.3m | 3.4m | ❗ 84s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34210255662) | 2026-09-08 09:53:25 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 14.4m | 14s | - | 14.1m | ❗ 15s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34210255662) | 2026-09-08 09:44:21 |
| Wikipedia iOS | ✅ | 7.2m | 17s | 31s | 6.4m | ⚡ 23s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34210255662) | 2026-09-08 09:52:06 |
| DuckDuckGo iOS | ✅ | 14.2m | 6s | 2.5m | 11.6m | ❗ 180s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34210255662) | 2026-09-08 10:06:49 |
| React Native (RN Tester) | ✅ | 22.5m | 20s | 2.3m | 19.9m | ❗ 73s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34210255662) | 2026-09-08 10:30:06 |
| Bluesky (social-app) | ✅ | 29.2m | 6s | 3.9m | 25.2m | ❗ 138s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34210255662) | 2026-09-08 10:59:55 |
| Mattermost Mobile | ✅ | 42.8m | 10s | 10.2m | 32.5m | ❗ 555s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34210255662) | 2026-09-08 11:43:41 |
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
