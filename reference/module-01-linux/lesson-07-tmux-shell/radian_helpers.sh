# shellcheck shell=bash
# radian_helpers.sh — Radian Labs shell shortcuts.
#
# Copy this into your workspace and source it from ~/.bashrc:
#   source ~/radian_ws/radian_helpers.sh
#
# It defines the aliases you'll use every day plus a radian_help function
# that prints them (so you never have to remember them).

# ── Build ────────────────────────────────────────────────
alias cb='colcon build --symlink-install'
alias cbs='colcon build --symlink-install --packages-select'
alias si='source install/setup.bash'

# ── ROS2 shortcuts ───────────────────────────────────────
alias rt='ros2 topic list'
alias re='ros2 topic echo'
alias rn='ros2 node list'

# ── Navigation ───────────────────────────────────────────
alias ws='cd ~/radian_ws'
alias src='cd ~/radian_ws/src'
alias ll='ls -lah'

# radian_help — print the shortcuts this file provides. Pure bash, no ROS2
# needed, so it works (and is tested) anywhere.
radian_help() {
  echo "Radian Labs shell shortcuts:"
  echo "  cb   colcon build --symlink-install"
  echo "  cbs  build one package"
  echo "  si   source install/setup.bash"
  echo "  ws   cd ~/radian_ws"
  echo "  src  cd ~/radian_ws/src"
  echo "  rt   ros2 topic list"
  echo "  re   ros2 topic echo"
  echo "  rn   ros2 node list"
}
