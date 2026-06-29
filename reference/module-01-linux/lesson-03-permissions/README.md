# Lesson 1.3 — Files & Permissions

Reference file for **Module 01 · Lesson 1.3 — Files, Permissions, and the Linux Filesystem**.

| File | What you do with it |
|------|---------------------|
| `start_robot.sh` | Copy into `~/radian_ws/practice/module-01/lesson-03/`. It arrives **not** executable — `chmod +x start_robot.sh`, then run it with `./start_robot.sh`. |

Its output is deterministic (no date/host), so it's identical on every machine:

```
[radian] Robot starting...
[radian] Loading parameters from radian_ws...
[radian] Sourcing ROS2 environment (simulated)...
[radian] Bringup complete. Robot is ready.
```
