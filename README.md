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
| XcodeBenchmark (anchor) | 2.2m | 10.7m | 5.0× |
| Wikipedia iOS | 1.5m | 6.1m | 4.1× |
| DuckDuckGo iOS | 1.3m | 13.6m | 10.5× |
| React Native (RN Tester) | 2.9m | 13.1m | 4.6× |
| Bluesky (social-app) | 5.4m | 33.8m | 6.3× |
| Mattermost Mobile | 5.1m | 28.6m | 5.6× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.2m | 15s | - | 1.9m | ❗ 30s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27901441039) | 2026-06-21 10:30:33 |
| Wikipedia iOS | ✅ | 1.5m | 19s | 13s | 58s | ⚡ 10s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27901441039) | 2026-06-21 10:32:25 |
| DuckDuckGo iOS | ✅ | 1.3m | 7s | 18s | 53s | ⚡ 58s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27901441039) | 2026-06-21 10:34:04 |
| React Native (RN Tester) | ✅ | 2.9m | 24s | 49s | 1.6m | ❗ 15s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27901441039) | 2026-06-21 10:37:23 |
| Bluesky (social-app) | ✅ | 5.4m | 9s | 1.7m | 3.5m | ❗ 91s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27901441039) | 2026-06-21 10:43:13 |
| Mattermost Mobile | ✅ | 5.1m | 10s | 50s | 4.1m | ❗ 82s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27901441039) | 2026-06-21 10:48:55 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 10.7m | 11s | - | 10.5m | ⚡ 140s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27901441039) | 2026-06-21 10:38:56 |
| Wikipedia iOS | ✅ | 6.1m | 14s | 29s | 5.4m | ❗ 70s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27901441039) | 2026-06-21 10:45:22 |
| DuckDuckGo iOS | ✅ | 13.6m | 5s | 2.3m | 11.2m | ❗ 242s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27901441039) | 2026-06-21 10:59:12 |
| React Native (RN Tester) | ✅ | 13.1m | 16s | 1.7m | 11.2m | ⚡ 231s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27901441039) | 2026-06-21 11:12:47 |
| Bluesky (social-app) | ✅ | 33.8m | 6s | 3.9m | 29.8m | ❗ 634s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27901441039) | 2026-06-21 11:47:04 |
| Mattermost Mobile | ✅ | 28.6m | 6s | 6.9m | 21.5m | ❗ 75s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27901441039) | 2026-06-21 12:16:25 |
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
