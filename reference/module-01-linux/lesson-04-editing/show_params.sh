#!/usr/bin/env bash
# show_params.sh — prints a robot's parameters.
#
# In Lesson 1.4 you TYPE this file by hand in nano (and edit it in vim) to
# practice terminal editors. This copy is the reference: after you type yours,
# compare them with `diff` to confirm you got it right.
#
# Run with:  bash show_params.sh

robot_name="amr_bot"
max_speed=1.5
wheel_radius=0.1

echo "Robot:        $robot_name"
echo "Max speed:    $max_speed m/s"
echo "Wheel radius: $wheel_radius m"
