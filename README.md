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
| XcodeBenchmark (anchor) | 2.2m | 18.1m | 8.2× |
| Wikipedia iOS | 49s | 7.7m | - |
| DuckDuckGo iOS | 2.1m | 12.0m | 5.7× |
| React Native (RN Tester) | 2.6m | 23.7m | 9.0× |
| Bluesky (social-app) | 5.2m | 34.2m | 6.6× |
| Mattermost Mobile | 5.3m | 26.3m | 5.0× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.2m | 16s | - | 1.9m | ❗ 4s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34460874809) | 2026-09-10 09:32:02 |
| Wikipedia iOS | ❌ build | 49s | 22s | 13s | 14s | - | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34460874809) | 2026-09-10 09:33:33 |
| DuckDuckGo iOS | ✅ | 2.1m | 8s | 40s | 1.3m | ⚡ 37s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34460874809) | 2026-09-10 09:36:00 |
| React Native (RN Tester) | ✅ | 2.6m | 26s | 24s | 1.8m | ⚡ 15s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34460874809) | 2026-09-10 09:39:03 |
| Bluesky (social-app) | ✅ | 5.2m | 11s | 1.9m | 3.2m | ❗ 80s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34460874809) | 2026-09-10 09:44:45 |
| Mattermost Mobile | ✅ | 5.3m | 11s | 2.1m | 3.0m | ❗ 72s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34460874809) | 2026-09-10 09:50:38 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 18.1m | 13s | - | 17.9m | ❗ 114s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34460874809) | 2026-09-10 09:47:48 |
| Wikipedia iOS | ✅ | 7.7m | 15s | 35s | 6.9m | ⚡ 78s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34460874809) | 2026-09-10 09:56:08 |
| DuckDuckGo iOS | ✅ | 12.0m | 6s | 2.0m | 9.9m | ±0s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34460874809) | 2026-09-10 10:08:39 |
| React Native (RN Tester) | ✅ | 23.7m | 24s | 2.8m | 20.5m | ❗ 238s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34460874809) | 2026-09-10 10:33:04 |
| Bluesky (social-app) | ✅ | 34.2m | 7s | 3.9m | 30.2m | ❗ 141s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34460874809) | 2026-09-10 11:07:56 |
| Mattermost Mobile | ✅ | 26.3m | 7s | 6.7m | 19.5m | ⚡ 711s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34460874809) | 2026-09-10 11:35:07 |
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
