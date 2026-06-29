#!/usr/bin/env bash
# Verifies the Module 01 Project solution runs and produces the expected report.
# The CI runner is not a configured robot workstation, so some checks will FAIL
# and the script exits non-zero by design — we assert the report *structure*,
# not that every check passes.
HERE="$(cd "$(dirname "$0")/../.." && pwd)"
# shellcheck disable=SC1091
source "$HERE/tests/lib/assert.sh"

PROG="$HERE/solutions/module-01-linux/module-01-project-environment-audit/check_env.sh"

echo "  test: check_env.sh (Module 01 Project)"
out="$(bash "$PROG" || true)"

assert_contains "$out" "Radian Labs — Environment Audit" "prints the audit header"
assert_matches  "$out" "\[(PASS|FAIL)\]" "emits PASS/FAIL result lines"
assert_contains "$out" "Result:" "prints the summary line"
assert_contains "$out" "of 7 checks" "runs all seven checks"
finish
