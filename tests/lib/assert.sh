# shellcheck shell=bash
# Minimal assertion helpers for Radian Labs program tests.
# A test script sources this, runs a lesson's program, and asserts on its
# output and exit code. Internal tooling — not referenced by any lesson.

_assert_pass=0
_assert_fail=0

_ok()  { printf '    ok   - %s\n' "$1"; _assert_pass=$((_assert_pass + 1)); }
_bad() { printf '    FAIL - %s\n' "$1"; _assert_fail=$((_assert_fail + 1)); }

# assert_contains "<haystack>" "<needle>" "<description>"
assert_contains() {
  if printf '%s' "$1" | grep -qF -- "$2"; then _ok "$3"; else _bad "$3 (missing: '$2')"; fi
}

# assert_matches "<haystack>" "<regex>" "<description>"
assert_matches() {
  if printf '%s' "$1" | grep -qE -- "$2"; then _ok "$3"; else _bad "$3 (no match: /$2/)"; fi
}

# assert_eq "<actual>" "<expected>" "<description>"
assert_eq() {
  if [ "$1" = "$2" ]; then _ok "$3"; else _bad "$3 (expected '$2', got '$1')"; fi
}

# assert_status <actual_code> <expected_code> "<description>"
assert_status() {
  if [ "$1" -eq "$2" ]; then _ok "$3"; else _bad "$3 (expected exit $2, got $1)"; fi
}

# compile_cpp <src.cpp> <out_binary> — compile a standalone C++17 program with
# the course's standard flags. Returns g++'s exit code so a test can assert it.
compile_cpp() { g++ -std=c++17 -Wall -Wextra -O2 -o "$2" "$1"; }

# Call at the end of every test file; sets the file's exit status.
finish() {
  if [ "$_assert_fail" -eq 0 ]; then
    printf '  PASSED (%d assertions)\n' "$_assert_pass"; exit 0
  else
    printf '  FAILED (%d of %d assertions failed)\n' "$_assert_fail" "$((_assert_pass + _assert_fail))"; exit 1
  fi
}
