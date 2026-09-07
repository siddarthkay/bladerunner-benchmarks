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
| XcodeBenchmark (anchor) | 1.7m | 14.1m | 8.4× |
| Wikipedia iOS | 1.7m | 7.6m | 4.5× |
| DuckDuckGo iOS | 2.0m | 11.2m | 5.5× |
| React Native (RN Tester) | 3.2m | 21.3m | 6.6× |
| Bluesky (social-app) | 4.0m | 26.9m | 6.7× |
| Mattermost Mobile | 5.6m | 33.6m | 6.0× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.7m | 16s | - | 1.4m | ⚡ 30s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34106862356) | 2026-09-07 09:37:54 |
| Wikipedia iOS | ✅ | 1.7m | 33s | 7s | 1.0m | ❗ 12s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34106862356) | 2026-09-07 09:39:58 |
| DuckDuckGo iOS | ✅ | 2.0m | 8s | 17s | 1.6m | ⚡ 18s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34106862356) | 2026-09-07 09:42:20 |
| React Native (RN Tester) | ✅ | 3.2m | 24s | 51s | 1.9m | ❗ 16s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34106862356) | 2026-09-07 09:45:57 |
| Bluesky (social-app) | ✅ | 4.0m | 10s | 38s | 3.2m | ⚡ 59s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34106862356) | 2026-09-07 09:50:26 |
| Mattermost Mobile | ✅ | 5.6m | 11s | 1.9m | 3.4m | ❗ 22s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34106862356) | 2026-09-07 09:56:37 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 14.1m | 12s | - | 13.9m | ⚡ 38s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34106862356) | 2026-09-07 09:50:06 |
| Wikipedia iOS | ✅ | 7.6m | 19s | 44s | 6.6m | ❗ 65s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34106862356) | 2026-09-07 09:58:12 |
| DuckDuckGo iOS | ✅ | 11.2m | 5s | 1.8m | 9.3m | ❗ 20s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34106862356) | 2026-09-07 10:09:52 |
| React Native (RN Tester) | ✅ | 21.3m | 21s | 2.0m | 18.9m | ❗ 282s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34106862356) | 2026-09-07 10:31:47 |
| Bluesky (social-app) | ✅ | 26.9m | 8s | 3.1m | 23.7m | ❗ 256s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34106862356) | 2026-09-07 10:59:28 |
| Mattermost Mobile | ✅ | 33.6m | 7s | 8.3m | 25.1m | ⚡ 205s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/34106862356) | 2026-09-07 11:33:46 |
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
