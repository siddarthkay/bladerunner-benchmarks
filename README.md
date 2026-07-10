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
| XcodeBenchmark (anchor) | 1.9m | 12.4m | 6.5× |
| Wikipedia iOS | 1.6m | 7.3m | 4.7× |
| DuckDuckGo iOS | 2.2m | 9.1m | 4.2× |
| React Native (RN Tester) | 2.9m | 13.1m | 4.6× |
| Bluesky (social-app) | 3.8m | 35.6m | 9.4× |
| Mattermost Mobile | 5.9m | 25.7m | 4.4× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.9m | 16s | - | 1.6m | ±0s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29086310672) | 2026-07-10 10:28:48 |
| Wikipedia iOS | ✅ | 1.6m | 22s | 13s | 58s | ⚡ 2s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29086310672) | 2026-07-10 10:30:43 |
| DuckDuckGo iOS | ✅ | 2.2m | 8s | 42s | 1.3m | ❗ 10s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29086310672) | 2026-07-10 10:33:16 |
| React Native (RN Tester) | ✅ | 2.9m | 26s | 48s | 1.6m | ❗ 5s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29086310672) | 2026-07-10 10:36:32 |
| Bluesky (social-app) | ✅ | 3.8m | 12s | 39s | 2.9m | ⚡ 8s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29086310672) | 2026-07-10 10:40:52 |
| Mattermost Mobile | ✅ | 5.9m | 13s | 2.0m | 3.6m | ❗ 46s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29086310672) | 2026-07-10 10:47:23 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 12.4m | 11s | - | 12.3m | ❗ 34s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29086310672) | 2026-07-10 10:39:08 |
| Wikipedia iOS | ✅ | 7.3m | 16s | 38s | 6.4m | ⚡ 42s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29086310672) | 2026-07-10 10:46:58 |
| DuckDuckGo iOS | ✅ | 9.1m | 8s | 2.1m | 7.0m | ⚡ 18s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29086310672) | 2026-07-10 10:56:28 |
| React Native (RN Tester) | ✅ | 13.1m | 17s | 1.4m | 11.4m | ⚡ 734s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29086310672) | 2026-07-10 11:10:07 |
| Bluesky (social-app) | ✅ | 35.6m | 8s | 4.3m | 31.2m | ❗ 368s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29086310672) | 2026-07-10 11:46:09 |
| Mattermost Mobile | ✅ | 25.7m | 8s | 6.4m | 19.2m | ⚡ 406s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29086310672) | 2026-07-10 12:12:44 |
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
