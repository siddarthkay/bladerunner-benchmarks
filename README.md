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
| XcodeBenchmark (anchor) | 2.5m | 11.0m | 4.4× |
| Wikipedia iOS | 1.6m | 8.0m | 5.0× |
| DuckDuckGo iOS | 1.5m | 8.0m | 5.2× |
| React Native (RN Tester) | 3.2m | 13.9m | 4.4× |
| Bluesky (social-app) | 4.1m | 40.5m | 10.0× |
| Mattermost Mobile | 4.0m | 50.6m | 12.8× |

### bladerunner - Mac Studio · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 2.5m | 21s | - | 2.1m | ❗ 41s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26815079596) | 2026-06-02 10:56:37 |
| Wikipedia iOS | ✅ | 1.6m | 27s | 7s | 1.0m | ❗ 5s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26815079596) | 2026-06-02 10:58:35 |
| DuckDuckGo iOS | ✅ | 1.5m | 11s | 19s | 1.0m | ❗ 9s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26815079596) | 2026-06-02 11:00:29 |
| React Native (RN Tester) | ✅ | 3.2m | 28s | 1.0m | 1.7m | ±0s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26815079596) | 2026-06-02 11:04:09 |
| Bluesky (social-app) | ✅ | 4.1m | 16s | 41s | 3.1m | ❗ 8s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26815079596) | 2026-06-02 11:08:44 |
| Mattermost Mobile | ✅ | 4.0m | 11s | 38s | 3.1m | ⚡ 34s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26815079596) | 2026-06-02 11:13:15 |

### github - Apple M1 (Virtual) · Xcode 26.4.1

| App | Status | Total | clone | deps | build | Δ vs prev | Built | Updated (UTC) |
|-----|:------:|------:|------:|-----:|------:|-----------|-------|---------------|
| XcodeBenchmark (anchor) | ✅ | 11.0m | 11s | - | 10.8m | ⚡ 128s | [`60d82d23e34fd63c4cae5d26d10cbdd88f0b0ee2` @ `60d82d2`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26815079596) | 2026-06-02 11:04:52 |
| Wikipedia iOS | ✅ | 8.0m | 14s | 41s | 7.1m | ❗ 70s | [`22f4e986c51db3629b175b299d0affbdb7648536` @ `22f4e98`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26815079596) | 2026-06-02 11:13:15 |
| DuckDuckGo iOS | ✅ | 8.0m | 5s | 1.5m | 6.5m | ⚡ 340s | [`40740302abbd758c80decc166ea37c324e5208c2` @ `4074030`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26815079596) | 2026-06-02 11:21:40 |
| React Native (RN Tester) | ✅ | 13.9m | 12s | 1.3m | 12.4m | ⚡ 245s | [`22ea81b5e37b0cf23be1d8fb32bb7f55e1fcf3d8` @ `22ea81b`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26815079596) | 2026-06-02 11:35:57 |
| Bluesky (social-app) | ✅ | 40.5m | 6s | 4.0m | 36.5m | ❗ 492s | [`8e8dc7561f82dbd92c86d2f8c7a1366a8bb85eba` @ `8e8dc75`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26815079596) | 2026-06-02 12:16:59 |
| Mattermost Mobile | ✅ | 50.6m | 7s | 10.2m | 40.3m | ❗ 1024s | [`ebf796a4da5f772bee157ab8223ab089f045ff58` @ `ebf796a`](https://github.com/siddarthkay/bladerunner-benchmarks/actions/runs/26815079596) | 2026-06-02 13:08:39 |
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
