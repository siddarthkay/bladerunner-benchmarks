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
| XcodeBenchmark (anchor) | 2.1m | 14.0m | 6.7× |
| Wikipedia iOS | 1.6m | 5.3m | 3.3× |
| DuckDuckGo iOS | 1.3m | 10.7m | 8.0× |
| React Native (RN Tester) | 2.4m | 25.7m | 10.5× |
| Bluesky (social-app) | 5.1m | 5.6m | - |
| Mattermost Mobile | 5.3m | 30.2m | 5.8× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.1m | 15s | - | 1.8m | ❗ 25s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30742755534) | 2026-08-02 09:59:41 |
| Wikipedia iOS | ✅ | 1.6m | 23s | 14s | 1.0m | ❗ 12s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30742755534) | 2026-08-02 10:01:43 |
| DuckDuckGo iOS | ✅ | 1.3m | 8s | 18s | 55s | ⚡ 50s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30742755534) | 2026-08-02 10:03:24 |
| React Native (RN Tester) | ✅ | 2.4m | 24s | 24s | 1.6m | ⚡ 29s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30742755534) | 2026-08-02 10:06:14 |
| Bluesky (social-app) | ✅ | 5.1m | 13s | 1.7m | 3.1m | ❗ 52s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30742755534) | 2026-08-02 10:11:47 |
| Mattermost Mobile | ✅ | 5.3m | 11s | 2.0m | 3.0m | ❗ 82s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30742755534) | 2026-08-02 10:17:38 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 14.0m | 10s | - | 13.9m | ❗ 225s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30742755534) | 2026-08-02 10:11:19 |
| Wikipedia iOS | ✅ | 5.3m | 13s | 23s | 4.7m | ⚡ 112s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30742755534) | 2026-08-02 10:17:03 |
| DuckDuckGo iOS | ✅ | 10.7m | 6s | 2.1m | 8.5m | ❗ 78s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30742755534) | 2026-08-02 10:28:06 |
| React Native (RN Tester) | ✅ | 25.7m | 24s | 3.2m | 22.1m | ❗ 394s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30742755534) | 2026-08-02 10:54:18 |
| Bluesky (social-app) | ❌ build | 5.6m | 8s | 2.9m | 2.5m | - | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30742755534) | 2026-08-02 11:00:34 |
| Mattermost Mobile | ✅ | 30.2m | 8s | 7.3m | 22.9m | ⚡ 395s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/30742755534) | 2026-08-02 11:31:20 |
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
