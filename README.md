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
| XcodeBenchmark (anchor) | 1.9m | 11.9m | 6.1× |
| Wikipedia iOS | 1.6m | 8.2m | 5.0× |
| DuckDuckGo iOS | 2.1m | 12.9m | 6.0× |
| React Native (RN Tester) | 2.5m | 22.5m | 8.8× |
| Bluesky (social-app) | 3.9m | 33.2m | 8.5× |
| Mattermost Mobile | 3.8m | 37.5m | 9.8× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 1.9m | 21s | - | 1.6m | ❗ 1s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33614410067) | 2026-09-02 09:32:33 |
| Wikipedia iOS | ✅ | 1.6m | 29s | 13s | 56s | ±0s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33614410067) | 2026-09-02 09:34:36 |
| DuckDuckGo iOS | ✅ | 2.1m | 13s | 43s | 1.2m | ❗ 21s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33614410067) | 2026-09-02 09:37:06 |
| React Native (RN Tester) | ✅ | 2.5m | 24s | 25s | 1.7m | ❗ 2s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33614410067) | 2026-09-02 09:40:06 |
| Bluesky (social-app) | ✅ | 3.9m | 13s | 39s | 3.1m | ⚡ 70s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33614410067) | 2026-09-02 09:44:33 |
| Mattermost Mobile | ✅ | 3.8m | 11s | 50s | 2.8m | ⚡ 13s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33614410067) | 2026-09-02 09:48:59 |

### github - Apple M1 (Virtual) · Xcode 26.6

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 11.9m | 11s | - | 11.7m | ⚡ 300s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33614410067) | 2026-09-02 09:42:11 |
| Wikipedia iOS | ✅ | 8.2m | 16s | 44s | 7.2m | ⚡ 14s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33614410067) | 2026-09-02 09:50:46 |
| DuckDuckGo iOS | ✅ | 12.9m | 7s | 2.2m | 10.6m | ❗ 81s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33614410067) | 2026-09-02 10:04:07 |
| React Native (RN Tester) | ✅ | 22.5m | 28s | 2.9m | 19.1m | ❗ 461s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33614410067) | 2026-09-02 10:27:20 |
| Bluesky (social-app) | ✅ | 33.2m | 7s | 3.8m | 29.3m | ⚡ 214s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33614410067) | 2026-09-02 11:01:22 |
| Mattermost Mobile | ✅ | 37.5m | 8s | 8.5m | 28.9m | ❗ 50s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/33614410067) | 2026-09-02 11:39:43 |
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
