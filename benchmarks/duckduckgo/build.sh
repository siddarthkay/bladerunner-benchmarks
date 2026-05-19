#!/usr/bin/env bash
# DuckDuckGo iOS - native Swift, SwiftPM. See ./README.md for the patches.

_ddg_deps() {
  git apply "$REPO_ROOT/benchmarks/duckduckgo/patches/"*.patch
  # Codebase-wide pattern: SwiftUICore is a private SwiftUI implementation
  # detail on Xcode 26; rewrite imports across all .swift files.
  while IFS= read -r f; do
    /usr/bin/sed -i '' 's/^\([[:space:]]*\)import SwiftUICore$/\1import SwiftUI/' "$f"
  done < <(grep -rl 'import SwiftUICore' --include='*.swift' . 2>/dev/null)
  # GRDB's "Copy framework" build phase calls codesign with the expanded
  # identity var, which is empty under CODE_SIGNING_ALLOWED=NO. Rewrite to "-"
  # so the framework is ad-hoc signed (harmless for a simulator build).
  /usr/bin/sed -i '' 's|${EXPANDED_CODE_SIGN_IDENTITY}|-|g' \
    DuckDuckGo-iOS.xcodeproj/project.pbxproj
  xcb_resolve -project "$PROJECT"
}

_ddg_build() { xcb_build -project "$PROJECT"; }

phase deps  --cwd "$APP_DIR" -- _ddg_deps
phase build --cwd "$APP_DIR" -- _ddg_build
