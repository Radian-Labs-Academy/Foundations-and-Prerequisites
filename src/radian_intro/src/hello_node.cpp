// Copyright 2026 Radian Labs
//
// radian_intro — your first ROS2 node. It starts up, logs one line, and shuts
// down cleanly. Built with colcon and run with: ros2 run radian_intro hello_node

#include <rclcpp/rclcpp.hpp>

int main(int argc, char * argv[])
{
  rclcpp::init(argc, argv);
  auto node = rclcpp::Node::make_shared("radian_intro");
  RCLCPP_INFO(node->get_logger(), "Hello from radian_intro - your first ROS2 node.");
  rclcpp::shutdown();
  return 0;
}
