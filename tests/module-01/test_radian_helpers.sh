#!/usr/bin/env bash
# Verifies Lesson 1.7 helpers: radian_help prints the expected shortcuts.
HERE="$(cd "$(dirname "$0")/../.." && pwd)"
# shellcheck disable=SC1091
source "$HERE/tests/lib/assert.sh"

PROG="$HERE/reference/module-01-linux/lesson-07-tmux-shell/radian_helpers.sh"

echo "  test: radian_helpers.sh (Lesson 1.7)"
# Source the helpers in a subshell, then call the function.
out="$(source "$PROG"; radian_help)"; status=$?

assert_status "$status" 0 "radian_help runs"
assert_contains "$out" "Radian Labs shell shortcuts:" "prints the header"
assert_contains "$out" "cb   colcon build --symlink-install" "lists the build alias"
assert_contains "$out" "ws   cd ~/radian_ws" "points navigation at radian_ws"
assert_contains "$out" "rn   ros2 node list" "lists the node-list alias"
finish
