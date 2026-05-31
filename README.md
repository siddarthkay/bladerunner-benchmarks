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
| XcodeBenchmark (anchor) | 2.2m | 14.0m | 6.3× |
| Wikipedia iOS | 1.5m | 9.0m | 5.9× |
| DuckDuckGo iOS | 2.3m | 12.3m | 5.3× |
| React Native (RN Tester) | 2.5m | 19.1m | 7.6× |
| Bluesky (social-app) | 3.9m | 27.5m | 7.1× |
| Mattermost Mobile | 5.5m | 41.4m | 7.5× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.2m | 15s | - | 2.0m | ❗ 18s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26709620899) | 2026-05-31 10:06:25 |
| Wikipedia iOS | ✅ | 1.5m | 22s | 12s | 56s | ❗ 6s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26709620899) | 2026-05-31 10:08:18 |
| DuckDuckGo iOS | ✅ | 2.3m | 8s | 41s | 1.5m | ⚡ 9s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26709620899) | 2026-05-31 10:10:58 |
| React Native (RN Tester) | ✅ | 2.5m | 20s | 27s | 1.7m | ⚡ 18s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26709620899) | 2026-05-31 10:13:55 |
| Bluesky (social-app) | ✅ | 3.9m | 9s | 38s | 3.1m | ⚡ 117s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26709620899) | 2026-05-31 10:18:17 |
| Mattermost Mobile | ✅ | 5.5m | 9s | 1.9m | 3.4m | ❗ 15s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26709620899) | 2026-05-31 10:24:21 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 14.0m | 14s | - | 13.8m | ⚡ 9s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26709620899) | 2026-05-31 10:18:02 |
| Wikipedia iOS | ✅ | 9.0m | 15s | 38s | 8.1m | ❗ 179s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26709620899) | 2026-05-31 10:27:34 |
| DuckDuckGo iOS | ✅ | 12.3m | 5s | 1.9m | 10.3m | ❗ 245s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26709620899) | 2026-05-31 10:40:16 |
| React Native (RN Tester) | ✅ | 19.1m | 14s | 1.7m | 17.2m | ⚡ 6s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26709620899) | 2026-05-31 10:59:52 |
| Bluesky (social-app) | ✅ | 27.5m | 7s | 2.8m | 24.5m | ⚡ 28s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26709620899) | 2026-05-31 11:27:49 |
| Mattermost Mobile | ✅ | 41.4m | 6s | 8.0m | 33.3m | ❗ 780s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26709620899) | 2026-05-31 12:09:48 |
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
