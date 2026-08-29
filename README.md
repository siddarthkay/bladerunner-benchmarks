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
| XcodeBenchmark (anchor) | 1.7m | 10.8m | 6.3× |
| Wikipedia iOS | 1.4m | 4.7m | 3.4× |
| DuckDuckGo iOS | 2.1m | 9.1m | 4.3× |
| React Native (RN Tester) | 2.6m | 18.7m | 7.2× |
| Bluesky (social-app) | 3.9m | 29.4m | 7.6× |
| Mattermost Mobile | 3.7m | 35.7m | 9.8× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.7m | 15s | - | 1.5m | ⚡ 23s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33245380938) | 2026-08-29 09:25:59 |
| Wikipedia iOS | ✅ | 1.4m | 23s | 6s | 54s | ⚡ 10s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33245380938) | 2026-08-29 09:27:41 |
| DuckDuckGo iOS | ✅ | 2.1m | 7s | 43s | 1.3m | ❗ 52s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33245380938) | 2026-08-29 09:30:06 |
| React Native (RN Tester) | ✅ | 2.6m | 26s | 24s | 1.8m | ⚡ 35s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33245380938) | 2026-08-29 09:33:06 |
| Bluesky (social-app) | ✅ | 3.9m | 9s | 39s | 3.1m | ⚡ 81s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33245380938) | 2026-08-29 09:37:29 |
| Mattermost Mobile | ✅ | 3.7m | 10s | 45s | 2.7m | ⚡ 114s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33245380938) | 2026-08-29 09:41:45 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 10.8m | 11s | - | 10.6m | ⚡ 212s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33245380938) | 2026-08-29 09:34:48 |
| Wikipedia iOS | ✅ | 4.7m | 15s | 25s | 4.0m | ⚡ 193s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33245380938) | 2026-08-29 09:39:44 |
| DuckDuckGo iOS | ✅ | 9.1m | 5s | 1.5m | 7.6m | ⚡ 176s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33245380938) | 2026-08-29 09:49:08 |
| React Native (RN Tester) | ✅ | 18.7m | 18s | 1.8m | 16.6m | ⚡ 353s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33245380938) | 2026-08-29 10:08:17 |
| Bluesky (social-app) | ✅ | 29.4m | 7s | 3.0m | 26.3m | ⚡ 630s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33245380938) | 2026-08-29 10:38:13 |
| Mattermost Mobile | ✅ | 35.7m | 9s | 9.2m | 26.4m | ⚡ 132s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33245380938) | 2026-08-29 11:14:31 |
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
