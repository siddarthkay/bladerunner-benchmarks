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
| XcodeBenchmark (anchor) | 3.1m | 13.1m | 4.2× |
| Wikipedia iOS | 1.5m | 7.9m | 5.4× |
| DuckDuckGo iOS | 1.3m | 10.9m | 8.1× |
| React Native (RN Tester) | 2.9m | 22.5m | 7.7× |
| Bluesky (social-app) | 4.1m | 30.2m | 7.3× |
| Mattermost Mobile | 5.0m | 38.5m | 7.6× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 3.1m | 17s | - | 2.8m | ❗ 10s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27200069252) | 2026-06-09 10:33:08 |
| Wikipedia iOS | ✅ | 1.5m | 22s | 7s | 58s | ⚡ 13s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27200069252) | 2026-06-09 10:34:57 |
| DuckDuckGo iOS | ✅ | 1.3m | 8s | 18s | 54s | ⚡ 61s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27200069252) | 2026-06-09 10:36:40 |
| React Native (RN Tester) | ✅ | 2.9m | 23s | 52s | 1.7m | ❗ 30s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27200069252) | 2026-06-09 10:40:00 |
| Bluesky (social-app) | ✅ | 4.1m | 10s | 38s | 3.3m | ⚡ 22s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27200069252) | 2026-06-09 10:44:37 |
| Mattermost Mobile | ✅ | 5.0m | 10s | 1.8m | 3.1m | ⚡ 16s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27200069252) | 2026-06-09 10:50:19 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 13.1m | 14s | - | 12.9m | ❗ 47s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27200069252) | 2026-06-09 10:42:53 |
| Wikipedia iOS | ✅ | 7.9m | 14s | 33s | 7.1m | ❗ 145s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27200069252) | 2026-06-09 10:51:09 |
| DuckDuckGo iOS | ✅ | 10.9m | 5s | 1.9m | 9.0m | ❗ 54s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27200069252) | 2026-06-09 11:02:27 |
| React Native (RN Tester) | ✅ | 22.5m | 15s | 2.3m | 20.0m | ❗ 542s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27200069252) | 2026-06-09 11:25:28 |
| Bluesky (social-app) | ✅ | 30.2m | 6s | 4.3m | 25.8m | ❗ 130s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27200069252) | 2026-06-09 11:56:09 |
| Mattermost Mobile | ✅ | 38.5m | 7s | 7.5m | 31.0m | ❗ 687s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27200069252) | 2026-06-09 12:35:25 |
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
