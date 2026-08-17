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
| XcodeBenchmark (anchor) | 1.9m | 13.0m | 6.8× |
| Wikipedia iOS | 1.5m | 7.4m | 5.0× |
| DuckDuckGo iOS | 1.3m | 11.3m | 8.6× |
| React Native (RN Tester) | 3.3m | 18.1m | 5.5× |
| Bluesky (social-app) | 5.4m | 29.6m | 5.4× |
| Mattermost Mobile | 4.6m | 31.5m | 6.8× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.9m | 16s | - | 1.6m | ⚡ 4s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32015432479) | 2026-08-17 09:31:36 |
| Wikipedia iOS | ✅ | 1.5m | 23s | 7s | 58s | ⚡ 10s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32015432479) | 2026-08-17 09:33:26 |
| DuckDuckGo iOS | ✅ | 1.3m | 9s | 18s | 52s | ⚡ 10s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32015432479) | 2026-08-17 09:35:05 |
| React Native (RN Tester) | ✅ | 3.3m | 27s | 46s | 2.1m | ⚡ 13s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32015432479) | 2026-08-17 09:38:47 |
| Bluesky (social-app) | ✅ | 5.4m | 11s | 1.8m | 3.4m | ⚡ 18s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32015432479) | 2026-08-17 09:44:44 |
| Mattermost Mobile | ✅ | 4.6m | 13s | 41s | 3.7m | ❗ 33s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32015432479) | 2026-08-17 09:49:58 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 13.0m | 13s | - | 12.8m | ⚡ 308s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32015432479) | 2026-08-17 09:42:30 |
| Wikipedia iOS | ✅ | 7.4m | 16s | 27s | 6.7m | ❗ 146s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32015432479) | 2026-08-17 09:50:18 |
| DuckDuckGo iOS | ✅ | 11.3m | 6s | 1.8m | 9.3m | ❗ 219s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32015432479) | 2026-08-17 10:01:58 |
| React Native (RN Tester) | ✅ | 18.1m | 20s | 2.0m | 15.7m | ⚡ 201s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32015432479) | 2026-08-17 10:20:30 |
| Bluesky (social-app) | ✅ | 29.6m | 8s | 3.2m | 26.3m | ❗ 251s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32015432479) | 2026-08-17 10:50:44 |
| Mattermost Mobile | ✅ | 31.5m | 9s | 7.6m | 23.8m | ❗ 97s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/32015432479) | 2026-08-17 11:23:16 |
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
