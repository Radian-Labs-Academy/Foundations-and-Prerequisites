#!/usr/bin/env bash
# Verifies Lesson 1.4 program: the hand-typed parameter script's expected output.
HERE="$(cd "$(dirname "$0")/../.." && pwd)"
# shellcheck disable=SC1091
source "$HERE/tests/lib/assert.sh"

PROG="$HERE/reference/module-01-linux/lesson-04-editing/show_params.sh"

echo "  test: show_params.sh (Lesson 1.4)"
out="$(bash "$PROG")"; status=$?

expected="Robot:        amr_bot
Max speed:    1.5 m/s
Wheel radius: 0.1 m"

assert_status "$status" 0 "exits 0"
assert_eq "$out" "$expected" "produces the exact expected parameter output"
finish
