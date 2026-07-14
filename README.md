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
| XcodeBenchmark (anchor) | 2.3m | 16.2m | 7.1× |
| Wikipedia iOS | 1.5m | 8.0m | 5.5× |
| DuckDuckGo iOS | 3.3m | 8.3m | 2.5× |
| React Native (RN Tester) | 2.8m | 23.1m | 8.2× |
| Bluesky (social-app) | 4.1m | 32.1m | 7.9× |
| Mattermost Mobile | 5.5m | 43.9m | 8.0× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.3m | 15s | - | 2.0m | ❗ 29s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29323581850) | 2026-07-14 10:00:15 |
| Wikipedia iOS | ✅ | 1.5m | 23s | 7s | 58s | ❗ 2s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29323581850) | 2026-07-14 10:02:06 |
| DuckDuckGo iOS | ✅ | 3.3m | 8s | 52s | 2.3m | ❗ 89s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29323581850) | 2026-07-14 10:05:45 |
| React Native (RN Tester) | ✅ | 2.8m | 24s | 28s | 1.9m | ⚡ 30s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29323581850) | 2026-07-14 10:09:00 |
| Bluesky (social-app) | ✅ | 4.1m | 12s | 38s | 3.2m | ⚡ 97s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29323581850) | 2026-07-14 10:13:32 |
| Mattermost Mobile | ✅ | 5.5m | 12s | 2.0m | 3.3m | ❗ 4s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29323581850) | 2026-07-14 10:19:40 |

### github - Apple M1 (Virtual) · Xcode 26.5

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 16.2m | 14s | - | 16.0m | ❗ 190s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29323581850) | 2026-07-14 10:14:03 |
| Wikipedia iOS | ✅ | 8.0m | 17s | 42s | 7.1m | ⚡ 33s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29323581850) | 2026-07-14 10:22:42 |
| DuckDuckGo iOS | ✅ | 8.3m | 6s | 1.7m | 6.5m | ⚡ 323s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29323581850) | 2026-07-14 10:31:24 |
| React Native (RN Tester) | ✅ | 23.1m | 16s | 2.6m | 20.3m | ❗ 260s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29323581850) | 2026-07-14 10:54:56 |
| Bluesky (social-app) | ✅ | 32.1m | 10s | 3.8m | 28.2m | ❗ 280s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29323581850) | 2026-07-14 11:27:45 |
| Mattermost Mobile | ✅ | 43.9m | 7s | 10.0m | 33.8m | ❗ 501s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/29323581850) | 2026-07-14 12:12:42 |
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
