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
| XcodeBenchmark (anchor) | 2.3m | 10.8m | 4.8× |
| Wikipedia iOS | 1.9m | 8.3m | 4.4× |
| DuckDuckGo iOS | 2.2m | 13.9m | 6.2× |
| React Native (RN Tester) | 3.4m | 22.3m | 6.6× |
| Bluesky (social-app) | 5.1m | 28.3m | 5.6× |
| Mattermost Mobile | 6.1m | 36.2m | 5.9× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.3m | 17s | - | 2.0m | ❗ 31s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27754305628) | 2026-06-18 10:52:01 |
| Wikipedia iOS | ✅ | 1.9m | 23s | 7s | 1.4m | ❗ 21s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27754305628) | 2026-06-18 10:54:15 |
| DuckDuckGo iOS | ✅ | 2.2m | 7s | 45s | 1.4m | ⚡ 7s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27754305628) | 2026-06-18 10:56:51 |
| React Native (RN Tester) | ✅ | 3.4m | 26s | 50s | 2.1m | ❗ 7s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27754305628) | 2026-06-18 11:00:37 |
| Bluesky (social-app) | ✅ | 5.1m | 10s | 1.6m | 3.3m | ❗ 71s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27754305628) | 2026-06-18 11:06:13 |
| Mattermost Mobile | ✅ | 6.1m | 10s | 2.6m | 3.4m | ❗ 116s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27754305628) | 2026-06-18 11:13:00 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 10.8m | 11s | - | 10.6m | ⚡ 52s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27754305628) | 2026-06-18 11:00:22 |
| Wikipedia iOS | ✅ | 8.3m | 16s | 36s | 7.4m | ❗ 194s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27754305628) | 2026-06-18 11:09:01 |
| DuckDuckGo iOS | ✅ | 13.9m | 5s | 2.0m | 11.8m | ❗ 128s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27754305628) | 2026-06-18 11:23:19 |
| React Native (RN Tester) | ✅ | 22.3m | 18s | 2.3m | 19.7m | ❗ 228s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27754305628) | 2026-06-18 11:46:12 |
| Bluesky (social-app) | ✅ | 28.3m | 5s | 3.2m | 25.1m | ❗ 52s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27754305628) | 2026-06-18 12:15:11 |
| Mattermost Mobile | ✅ | 36.2m | 9s | 8.0m | 28.0m | ❗ 469s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27754305628) | 2026-06-18 12:51:54 |
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
