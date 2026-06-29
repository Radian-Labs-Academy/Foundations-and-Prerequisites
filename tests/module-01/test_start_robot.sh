#!/usr/bin/env bash
# Verifies Lesson 1.3 program: executable bringup script with fixed output.
HERE="$(cd "$(dirname "$0")/../.." && pwd)"
# shellcheck disable=SC1091
source "$HERE/tests/lib/assert.sh"

PROG="$HERE/reference/module-01-linux/lesson-03-permissions/start_robot.sh"

echo "  test: start_robot.sh (Lesson 1.3)"

# It must be runnable directly once execute permission is set (the lesson's point).
chmod +x "$PROG"
out="$("$PROG")"; status=$?

# Output is deterministic, so we assert the full expected sequence.
expected="[radian] Robot starting...
[radian] Loading parameters from radian_ws...
[radian] Sourcing ROS2 environment (simulated)...
[radian] Bringup complete. Robot is ready."

assert_status "$status" 0 "runs directly after chmod +x"
assert_eq "$out" "$expected" "produces the exact expected bringup output"
finish
