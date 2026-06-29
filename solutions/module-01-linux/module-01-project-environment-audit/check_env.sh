#!/usr/bin/env bash
#
# check_env.sh — Module 01 Project solution: Environment Audit Script.
#
# Verifies that a Radian Labs robotics workstation is set up correctly and
# prints a colored PASS/FAIL for each check plus a final summary.
#
# Run with:   bash check_env.sh
#
# Try the project yourself before reading this solution.

set -u

# --- Colors (disabled automatically when output is not a terminal, e.g. in CI) ---
if [ -t 1 ]; then
  GREEN=$'\e[32m'; RED=$'\e[31m'; BOLD=$'\e[1m'; RESET=$'\e[0m'
else
  GREEN=''; RED=''; BOLD=''; RESET=''
fi

PASS_COUNT=0
FAIL_COUNT=0

# pass <message> / fail <message> — record and print one result line.
pass() { printf '  [%sPASS%s] %s\n' "$GREEN" "$RESET" "$1"; PASS_COUNT=$((PASS_COUNT + 1)); }
fail() { printf '  [%sFAIL%s] %s\n' "$RED"   "$RESET" "$1"; FAIL_COUNT=$((FAIL_COUNT + 1)); }

printf '%s== Radian Labs — Environment Audit ==%s\n' "$BOLD" "$RESET"

# 1. Ubuntu version is 24.04
if grep -q '24.04' /etc/os-release 2>/dev/null; then
  pass "Ubuntu 24.04 detected"
else
  fail "Ubuntu 24.04 not detected (this program targets Ubuntu 24.04 LTS)"
fi

# 2. ROS2 Jazzy is sourced
if [ "${ROS_DISTRO:-}" = "jazzy" ]; then
  pass "ROS2 Jazzy is sourced (ROS_DISTRO=jazzy)"
else
  fail "ROS2 not sourced — run: source /opt/ros/jazzy/setup.bash"
fi

# 3. Docker is installed and the daemon is running
if command -v docker >/dev/null 2>&1; then
  if docker info >/dev/null 2>&1; then
    pass "Docker is installed and the daemon is running"
  else
    fail "Docker is installed but the daemon is not running (or you lack permission)"
  fi
else
  fail "Docker is not installed"
fi

# 4. The Radian Labs workspace exists at ~/radian_ws
if [ -d "$HOME/radian_ws" ]; then
  pass "Workspace exists at ~/radian_ws"
else
  fail "Workspace ~/radian_ws not found — create it with: mkdir -p ~/radian_ws/src"
fi

# 5. VS Code is installed
if command -v code >/dev/null 2>&1; then
  pass "VS Code is installed"
else
  fail "VS Code ('code') not found on PATH"
fi

# 6. clangd is installed
if command -v clangd >/dev/null 2>&1; then
  pass "clangd is installed"
else
  fail "clangd not found — install with: sudo apt install clangd"
fi

# 7. Git global identity (name and email) is set
GIT_NAME="$(git config --global user.name  || true)"
GIT_EMAIL="$(git config --global user.email || true)"
if [ -n "$GIT_NAME" ] && [ -n "$GIT_EMAIL" ]; then
  pass "Git identity set ($GIT_NAME <$GIT_EMAIL>)"
else
  fail "Git global user.name/user.email not set — run: git config --global user.name '...'"
fi

# --- Summary ---
TOTAL=$((PASS_COUNT + FAIL_COUNT))
printf '%s--------------------------------------%s\n' "$BOLD" "$RESET"
printf 'Result: %s%d passed%s, %s%d failed%s (of %d checks)\n' \
  "$GREEN" "$PASS_COUNT" "$RESET" "$RED" "$FAIL_COUNT" "$RESET" "$TOTAL"

# Exit non-zero if anything failed, so this is usable in scripts and CI.
[ "$FAIL_COUNT" -eq 0 ]
