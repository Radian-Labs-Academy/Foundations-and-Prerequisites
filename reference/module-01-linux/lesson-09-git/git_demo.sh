#!/usr/bin/env bash
# git_demo.sh — runs the core git workflow end to end in a throwaway repo,
# so you can watch add -> commit -> log happen before doing it for real on
# your own workspace.
#
# Safe to run anywhere: it works inside a fresh temporary directory and
# deletes it when finished. Run with:  bash git_demo.sh
set -euo pipefail

demo="$(mktemp -d)"
cd "$demo" || exit 1

git init -q -b main
git config user.name "Radian Student"
git config user.email "student@radianlabs.dev"

# Commit 1: add a config file.
echo "max_speed: 1.5" > robot.yaml
git add robot.yaml
git commit -q -m "Add robot config"

# Commit 2: change it and commit again.
echo "wheel_radius: 0.1" >> robot.yaml
git add robot.yaml
git commit -q -m "Add wheel radius"

echo "== Commit history (newest first) =="
git log --format='%s'
echo "== Files tracked =="
git ls-files

cd / || exit 1
rm -rf "$demo"
