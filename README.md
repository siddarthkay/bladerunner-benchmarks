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
| XcodeBenchmark (anchor) | 2.7m | 11.2m | 4.1× |
| Wikipedia iOS | 1.7m | 5.4m | 3.2× |
| DuckDuckGo iOS | 1.3m | 8.4m | 6.5× |
| React Native (RN Tester) | 3.2m | 17.0m | 5.2× |
| Bluesky (social-app) | 4.0m | 30.8m | 7.6× |
| Mattermost Mobile | 5.1m | 27.4m | 5.4× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.7m | 14s | - | 2.5m | ⚡ 9s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28318903391) | 2026-06-28 10:15:04 |
| Wikipedia iOS | ✅ | 1.7m | 18s | 6s | 1.3m | ❗ 22s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28318903391) | 2026-06-28 10:17:08 |
| DuckDuckGo iOS | ✅ | 1.3m | 8s | 18s | 52s | ❗ 3s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28318903391) | 2026-06-28 10:18:46 |
| React Native (RN Tester) | ✅ | 3.2m | 21s | 48s | 2.1m | ❗ 19s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28318903391) | 2026-06-28 10:22:25 |
| Bluesky (social-app) | ✅ | 4.0m | 9s | 38s | 3.2m | ⚡ 86s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28318903391) | 2026-06-28 10:26:58 |
| Mattermost Mobile | ✅ | 5.1m | 9s | 46s | 4.2m | ❗ 51s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28318903391) | 2026-06-28 10:32:39 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 11.2m | 11s | - | 11.0m | ❗ 74s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28318903391) | 2026-06-28 10:23:14 |
| Wikipedia iOS | ✅ | 5.4m | 13s | 31s | 4.7m | ⚡ 14s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28318903391) | 2026-06-28 10:29:07 |
| DuckDuckGo iOS | ✅ | 8.4m | 6s | 1.7m | 6.6m | ❗ 37s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28318903391) | 2026-06-28 10:37:49 |
| React Native (RN Tester) | ✅ | 17.0m | 13s | 1.6m | 15.2m | ❗ 111s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28318903391) | 2026-06-28 10:55:08 |
| Bluesky (social-app) | ✅ | 30.8m | 6s | 4.1m | 26.7m | ❗ 423s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28318903391) | 2026-06-28 11:26:25 |
| Mattermost Mobile | ✅ | 27.4m | 9s | 7.9m | 19.3m | ⚡ 38s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/28318903391) | 2026-06-28 11:54:25 |
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
