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
| XcodeBenchmark (anchor) | 1.9m | 12.9m | 6.8× |
| Wikipedia iOS | 1.4m | 6.3m | 4.5× |
| DuckDuckGo iOS | 1.9m | 10.4m | 5.6× |
| React Native (RN Tester) | 3.2m | 20.8m | 6.4× |
| Bluesky (social-app) | 4.0m | 31.0m | 7.8× |
| Mattermost Mobile | 3.8m | 33.1m | 8.7× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.9m | 15s | - | 1.6m | ⚡ 49s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27009994479) | 2026-06-05 10:38:44 |
| Wikipedia iOS | ✅ | 1.4m | 20s | 7s | 58s | ⚡ 3s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27009994479) | 2026-06-05 10:40:32 |
| DuckDuckGo iOS | ✅ | 1.9m | 8s | 18s | 1.4m | ❗ 36s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27009994479) | 2026-06-05 10:42:46 |
| React Native (RN Tester) | ✅ | 3.2m | 22s | 54s | 2.0m | ❗ 49s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27009994479) | 2026-06-05 10:46:23 |
| Bluesky (social-app) | ✅ | 4.0m | 10s | 38s | 3.2m | ⚡ 60s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27009994479) | 2026-06-05 10:50:51 |
| Mattermost Mobile | ✅ | 3.8m | 11s | 36s | 3.0m | ⚡ 100s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27009994479) | 2026-06-05 10:55:14 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 12.9m | 15s | - | 12.6m | ❗ 164s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27009994479) | 2026-06-05 10:49:26 |
| Wikipedia iOS | ✅ | 6.3m | 14s | 31s | 5.6m | ❗ 39s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27009994479) | 2026-06-05 10:56:06 |
| DuckDuckGo iOS | ✅ | 10.4m | 7s | 1.9m | 8.4m | ⚡ 54s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27009994479) | 2026-06-05 11:06:53 |
| React Native (RN Tester) | ✅ | 20.8m | 17s | 2.7m | 17.9m | ❗ 328s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27009994479) | 2026-06-05 11:28:14 |
| Bluesky (social-app) | ✅ | 31.0m | 6s | 3.4m | 27.5m | ❗ 310s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27009994479) | 2026-06-05 11:59:44 |
| Mattermost Mobile | ✅ | 33.1m | 9s | 8.3m | 24.6m | ❗ 449s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/27009994479) | 2026-06-05 12:33:35 |
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
