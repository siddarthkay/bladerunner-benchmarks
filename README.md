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
| XcodeBenchmark (anchor) | 3.0m | 12.4m | 4.1× |
| Wikipedia iOS | 1.6m | 7.9m | 4.9× |
| DuckDuckGo iOS | 2.4m | 11.6m | 4.8× |
| React Native (RN Tester) | 3.4m | 22.0m | 6.5× |
| Bluesky (social-app) | 4.8m | 34.5m | 7.2× |
| Mattermost Mobile | 5.0m | 40.3m | 8.1× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 3.0m | 16s | - | 2.8m | ❗ 44s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29820960889) | 2026-07-21 10:10:42 |
| Wikipedia iOS | ✅ | 1.6m | 20s | 7s | 1.1m | ❗ 10s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29820960889) | 2026-07-21 10:12:42 |
| DuckDuckGo iOS | ✅ | 2.4m | 8s | 45s | 1.5m | ❗ 4s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29820960889) | 2026-07-21 10:15:32 |
| React Native (RN Tester) | ✅ | 3.4m | 25s | 50s | 2.1m | ❗ 2s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29820960889) | 2026-07-21 10:19:18 |
| Bluesky (social-app) | ✅ | 4.8m | 10s | 1.5m | 3.2m | ⚡ 42s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29820960889) | 2026-07-21 10:24:35 |
| Mattermost Mobile | ✅ | 5.0m | 11s | 40s | 4.1m | ⚡ 38s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29820960889) | 2026-07-21 10:30:14 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 12.4m | 12s | - | 12.2m | ⚡ 284s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29820960889) | 2026-07-21 10:19:53 |
| Wikipedia iOS | ✅ | 7.9m | 14s | 38s | 7.1m | ⚡ 5s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29820960889) | 2026-07-21 10:28:09 |
| DuckDuckGo iOS | ✅ | 11.6m | 8s | 1.8m | 9.7m | ❗ 125s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29820960889) | 2026-07-21 10:40:04 |
| React Native (RN Tester) | ✅ | 22.0m | 20s | 2.7m | 18.9m | ❗ 194s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29820960889) | 2026-07-21 11:02:29 |
| Bluesky (social-app) | ✅ | 34.5m | 9s | 4.3m | 30.1m | ⚡ 420s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29820960889) | 2026-07-21 11:37:32 |
| Mattermost Mobile | ✅ | 40.3m | 8s | 9.2m | 31.0m | ❗ 537s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29820960889) | 2026-07-21 12:18:53 |
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
