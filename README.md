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
| XcodeBenchmark (anchor) | 2.3m | 12.6m | 5.5× |
| Wikipedia iOS | 1.5m | 4.9m | 3.2× |
| DuckDuckGo iOS | 2.9m | 12.4m | 4.2× |
| React Native (RN Tester) | 3.6m | 23.9m | 6.7× |
| Bluesky (social-app) | 5.1m | 29.9m | 5.8× |
| Mattermost Mobile | 4.1m | 37.4m | 9.1× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.3m | 16s | - | 2.0m | ⚡ 7s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28582530468) | 2026-07-02 10:18:35 |
| Wikipedia iOS | ✅ | 1.5m | 21s | 13s | 58s | ⚡ 14s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28582530468) | 2026-07-02 10:20:28 |
| DuckDuckGo iOS | ✅ | 2.9m | 7s | 48s | 2.0m | ❗ 42s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28582530468) | 2026-07-02 10:23:46 |
| React Native (RN Tester) | ✅ | 3.6m | 23s | 1.4m | 1.8m | ❗ 16s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28582530468) | 2026-07-02 10:28:05 |
| Bluesky (social-app) | ✅ | 5.1m | 10s | 1.8m | 3.2m | ⚡ 22s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28582530468) | 2026-07-02 10:33:45 |
| Mattermost Mobile | ✅ | 4.1m | 10s | 38s | 3.3m | ❗ 2s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28582530468) | 2026-07-02 10:38:28 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 12.6m | 13s | - | 12.4m | ⚡ 200s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28582530468) | 2026-07-02 10:28:35 |
| Wikipedia iOS | ✅ | 4.9m | 14s | 29s | 4.2m | ⚡ 91s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28582530468) | 2026-07-02 10:33:45 |
| DuckDuckGo iOS | ✅ | 12.4m | 6s | 2.0m | 10.3m | ⚡ 27s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28582530468) | 2026-07-02 10:46:25 |
| React Native (RN Tester) | ✅ | 23.9m | 22s | 1.9m | 21.6m | ❗ 383s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28582530468) | 2026-07-02 11:10:58 |
| Bluesky (social-app) | ✅ | 29.9m | 11s | 4.1m | 25.6m | ⚡ 330s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28582530468) | 2026-07-02 11:41:40 |
| Mattermost Mobile | ✅ | 37.4m | 8s | 8.7m | 28.6m | ⚡ 348s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28582530468) | 2026-07-02 12:20:07 |
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
