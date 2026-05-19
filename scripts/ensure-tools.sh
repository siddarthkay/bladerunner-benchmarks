#!/usr/bin/env bash
set -uo pipefail

KIND="${1:?usage: ensure-tools.sh <kind>}"

say() { printf 'ensure-tools: %s\n' "$*" >&2; }
have() { command -v "$1" >/dev/null 2>&1; }

for brew_bin in "$HOME/.brew/bin/brew" /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [ -x "$brew_bin" ]; then
    eval "$("$brew_bin" shellenv)" 2>/dev/null || true
    break
  fi
done
export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_ANALYTICS=1

brew_install() {
  if have brew; then
    say "brew install $*"
    brew install "$@" || say "WARN: brew install $* failed (continuing)"
  else
    say "WARN: no Homebrew available, cannot install $*"
  fi
}

ensure_node() {
  have node && { say "node $(node --version) present"; return; }
  brew_install node
}

ensure_corepack() {
  have corepack || brew_install corepack
  have corepack && corepack enable >/dev/null 2>&1 || true
}

ensure_pnpm() {
  ensure_corepack
  have pnpm && { say "pnpm $(pnpm --version) present"; return; }
  corepack prepare pnpm@latest --activate >/dev/null 2>&1 \
    || npm install -g pnpm \
    || brew_install pnpm
}

ensure_yarn() {
  ensure_corepack
  have yarn && { say "yarn $(yarn --version) present"; return; }
  corepack prepare yarn@stable --activate >/dev/null 2>&1 \
    || npm install -g yarn \
    || brew_install yarn
}

ensure_bundler() {
  have bundle && { say "bundler present"; return; }
  say "gem install bundler"
  gem install bundler --no-document || say "WARN: gem install bundler failed"
}

ensure_xcbeautify() {
  have xcbeautify && { say "xcbeautify $(xcbeautify --version)  present"; return; }
  say "installing xcbeautify"
  brew install xcbeautify
}

ensure_cocoapods() {
  if have pod && pod --version >/dev/null 2>&1; then
    say "cocoapods $(pod --version) present"
    return
  fi
  say "gem install cocoapods"
  gem install cocoapods --no-document || brew_install cocoapods
}

case "$KIND" in
  xcodebenchmark)    ensure_xcbeautify; say "xcodebenchmark: Pods vendored, nothing to install" ;;
  ios-native)        ensure_bundler; ensure_xcbeautify ;;
  react-native)      ensure_node; ensure_yarn; ensure_bundler; ensure_cocoapods; ensure_xcbeautify ;;
  react-native-expo) ensure_node; ensure_pnpm; ensure_cocoapods; ensure_xcbeautify ;;
  *)                 say "unknown kind '$KIND' - installing nothing" ;;
esac

say "done"
