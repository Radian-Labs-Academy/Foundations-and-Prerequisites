#!/usr/bin/env bash
# Verifies Lesson 1.9 program: the git workflow demo's deterministic output.
HERE="$(cd "$(dirname "$0")/../.." && pwd)"
# shellcheck disable=SC1091
source "$HERE/tests/lib/assert.sh"

PROG="$HERE/reference/module-01-linux/lesson-09-git/git_demo.sh"

echo "  test: git_demo.sh (Lesson 1.9)"
out="$(bash "$PROG")"; status=$?

expected="== Commit history (newest first) ==
Add wheel radius
Add robot config
== Files tracked ==
robot.yaml"

assert_status "$status" 0 "exits 0"
assert_eq "$out" "$expected" "produces the exact expected workflow output"
finish
