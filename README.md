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
| XcodeBenchmark (anchor) | 2.8m | 14.1m | 5.0× |
| Wikipedia iOS | 1.5m | 6.6m | 4.5× |
| DuckDuckGo iOS | 1.3m | 13.4m | 10.3× |
| React Native (RN Tester) | 3.2m | 17.5m | 5.5× |
| Bluesky (social-app) | 5.5m | 27.0m | 4.9× |
| Mattermost Mobile | 4.3m | 33.0m | 7.6× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.8m | 16s | - | 2.5m | ❗ 55s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33957898514) | 2026-09-05 09:28:07 |
| Wikipedia iOS | ✅ | 1.5m | 22s | 14s | 54s | ❗ 4s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33957898514) | 2026-09-05 09:29:57 |
| DuckDuckGo iOS | ✅ | 1.3m | 8s | 18s | 51s | ⚡ 6s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33957898514) | 2026-09-05 09:31:36 |
| React Native (RN Tester) | ✅ | 3.2m | 26s | 48s | 2.0m | ⚡ 6s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33957898514) | 2026-09-05 09:35:09 |
| Bluesky (social-app) | ✅ | 5.5m | 11s | 1.8m | 3.5m | ❗ 70s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33957898514) | 2026-09-05 09:41:06 |
| Mattermost Mobile | ✅ | 4.3m | 10s | 49s | 3.3m | ⚡ 196s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33957898514) | 2026-09-05 09:46:04 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 14.1m | 13s | - | 13.8m | ⚡ 100s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33957898514) | 2026-09-05 09:39:17 |
| Wikipedia iOS | ✅ | 6.6m | 16s | 35s | 5.8m | ❗ 93s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33957898514) | 2026-09-05 09:46:15 |
| DuckDuckGo iOS | ✅ | 13.4m | 5s | 1.8m | 11.5m | ⚡ 11s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33957898514) | 2026-09-05 10:00:10 |
| React Native (RN Tester) | ✅ | 17.5m | 18s | 2.3m | 14.9m | ⚡ 321s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33957898514) | 2026-09-05 10:18:15 |
| Bluesky (social-app) | ✅ | 27.0m | 7s | 3.0m | 23.9m | ⚡ 201s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33957898514) | 2026-09-05 10:45:48 |
| Mattermost Mobile | ✅ | 33.0m | 8s | 8.0m | 24.8m | ⚡ 653s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33957898514) | 2026-09-05 11:19:48 |
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
