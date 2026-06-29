#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091  # assert.sh sourced via runtime path
# Verifies Lesson 2.3 program: robot_state compiles and prints typed state + rollover.
HERE="$(cd "$(dirname "$0")/../.." && pwd)"
source "$HERE/tests/lib/assert.sh"

SRC="$HERE/reference/module-02-cpp17/lesson-03-types/robot_state.cpp"
BIN="$(mktemp -d)/robot_state"

echo "  test: robot_state.cpp (Lesson 2.3)"
compile_cpp "$SRC" "$BIN"
assert_status "$?" 0 "compiles with -std=c++17 -Wall -Wextra"
out="$("$BIN")"

expected="--- radian_base_controller ---
  Position  : (12.450, 3.820) m
  Heading   : 1.5708 rad
  Velocity  : 0.850 m/s, 0.000 rad/s
  Left enc  : 98304 ticks = 11.491 m
  Right enc : 98176 ticks = 11.476 m
  Battery   : 25.3 V
  E-stop    : false
  Obstacle  : false

--- Encoder Rollover Simulation ---
  tick: 65531
  tick: 65532
  tick: 65533
  tick: 65534
  tick: 65535
  tick: 0
  tick: 1
  tick: 2
  tick: 3
  tick: 4"

assert_eq "$out" "$expected" "prints typed state and a correct uint16_t rollover"
finish
