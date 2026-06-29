#!/usr/bin/env bash
# Verifies Lesson 1.2 reference program executes and prints the expected banner.
HERE="$(cd "$(dirname "$0")/../.." && pwd)"
# shellcheck disable=SC1091
source "$HERE/tests/lib/assert.sh"

PROG="$HERE/reference/module-01-linux/lesson-02-terminal/hello_radian.sh"

echo "  test: hello_radian.sh (Lesson 1.2)"
out="$(bash "$PROG")"; status=$?

assert_status "$status" 0 "exits 0"
assert_contains "$out" "Radian Labs" "prints the title banner"
assert_contains "$out" "Workspace : $HOME/radian_ws" "reports the workspace path"
assert_contains "$out" "1. your terminal" "lists the terminal check"
assert_contains "$out" "2. your radian_ws workspace" "lists the workspace check"
assert_contains "$out" "3. your first script" "lists the script check"
assert_contains "$out" "ready for the rest of Module 01" "prints the closing line"
finish
