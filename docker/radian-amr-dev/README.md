# radian-amr-dev — Radian Labs development image

A carry-forward artifact: prepared in **Foundations (Lesson 1.8)** and reused as the
base environment in every later course.

It's `ros:jazzy` plus the tools every Radian Labs course assumes — `colcon`, `clangd`,
`tmux`, `git`, `vim`/`nano`, networking tools — with ROS2 and `radian_helpers.sh`
auto-sourced for every shell.

## Build it (from the repo root)

```bash
docker build -f docker/radian-amr-dev/Dockerfile -t radian-amr-dev .
```

## Use it

```bash
# Drop into a ready-to-go ROS2 shell (radian_help, colcon, clangd all present):
docker run -it --rm --network=host -v ~/radian_ws:/radian_ws radian-amr-dev
```

## Reuse downstream

Later courses start from this image instead of stock `ros:jazzy`:

```dockerfile
FROM radian-amr-dev
# ... course-specific packages on top ...
```

The repo's CI rebuilds this image on every push, so the definition can't silently rot.
