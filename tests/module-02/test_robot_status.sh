#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091  # assert.sh sourced via runtime path
# Verifies Lesson 2.2 program: robot_status compiles and prints the expected report.
HERE="$(cd "$(dirname "$0")/../.." && pwd)"
source "$HERE/tests/lib/assert.sh"

SRC="$HERE/reference/module-02-cpp17/lesson-02-hello/robot_status.cpp"
BIN="$(mktemp -d)/robot_status"

echo "  test: robot_status.cpp (Lesson 2.2)"
compile_cpp "$SRC" "$BIN"
assert_status "$?" 0 "compiles with -std=c++17 -Wall -Wextra"
out="$("$BIN")"

expected="==============================================
  Radian AMR — System Status
==============================================
  Battery voltage  : 24.70 V
  Linear velocity  : 0.85 m/s
  Angular velocity : 0.12 rad/s
  Left encoder     : 48320 ticks
  Right encoder    : 48195 ticks
  Encoder delta    : 125 ticks  [WARNING: large skew]
  Obstacle detected: false
=============================================="

assert_eq "$out" "$expected" "prints the expected status report"
finish
