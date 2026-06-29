# radian_intro

The first ROS2 package in the Radian Labs program (Lesson 1.10 — colcon).
A minimal `ament_cmake` C++ package with one node.

Copy the whole package into your workspace and build it:

```bash
cp -r ~/radian-labs-foundations/src/radian_intro ~/radian_ws/src/
cd ~/radian_ws
colcon build --symlink-install --packages-select radian_intro
source install/setup.bash
ros2 run radian_intro hello_node
```

Expected output:

```
[INFO] [radian_intro]: Hello from radian_intro - your first ROS2 node.
```

This package is built by the repo's CI (`colcon build` in a `ros:jazzy` container) on every push.
