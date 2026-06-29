#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091  # assert.sh sourced via runtime path
# Verifies Lesson 2.4 program: diff-drive kinematics math (deterministic output).
HERE="$(cd "$(dirname "$0")/../.." && pwd)"
source "$HERE/tests/lib/assert.sh"

SRC="$HERE/reference/module-02-cpp17/lesson-04-operators/diff_drive_kinematics.cpp"
BIN="$(mktemp -d)/kinematics"

echo "  test: diff_drive_kinematics.cpp (Lesson 2.4)"
compile_cpp "$SRC" "$BIN"
assert_status "$?" 0 "compiles with -std=c++17 -Wall -Wextra"
out="$("$BIN")"

# Spot-check the load-bearing numbers rather than the whole block.
assert_contains "$out" "Fwd 1.0 m/s: left=2.5000 right=2.5000 m/s" "forward motion clamps to wheel limit"
assert_contains "$out" "Rotate 1.0 rad/s: left=-2.1982 right=2.1982 m/s" "rotation is symmetric"
assert_contains "$out" "Round-trip: linear=0.1500 angular=0.2000 (expected 0.1500, 0.2000)" "round-trip recovers the twist"
assert_contains "$out" "v=2.0000 m/s -> stop in 1.3333 m" "stopping distance d=v^2/2a"
assert_contains "$out" "6.2832 rad -> -0.0000 rad" "2pi normalizes to ~0"
finish
