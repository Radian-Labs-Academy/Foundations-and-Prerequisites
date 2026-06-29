#!/usr/bin/env bash
# Run every test_*.sh under tests/ and report a summary.
# CI uses this to confirm each lesson's program executes and produces the
# expected output. Internal tooling — learners never see this.
set -uo pipefail

cd "$(dirname "$0")/.." || exit 1   # repo root

mapfile -t tests < <(find tests -type f -name 'test_*.sh' | sort)
if [ "${#tests[@]}" -eq 0 ]; then echo "No tests found."; exit 0; fi

total=0
failed=0
for t in "${tests[@]}"; do
  total=$((total + 1))
  echo ">> $t"
  if ! bash "$t"; then failed=$((failed + 1)); fi
done

echo "--------------------------------------"
echo "Ran $total test file(s), $failed failed."
[ "$failed" -eq 0 ]
