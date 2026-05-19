#!/usr/bin/env bash
# Wikipedia iOS -> native Swift/Obj-C, SwiftPM.

_wiki_deps() {
  ./scripts/setup_bundle_id ci
  xcb_resolve -project "$PROJECT"
}

_wiki_build() { xcb_build -project "$PROJECT"; }

phase deps  --cwd "$APP_DIR" -- _wiki_deps
phase build --cwd "$APP_DIR" -- _wiki_build
