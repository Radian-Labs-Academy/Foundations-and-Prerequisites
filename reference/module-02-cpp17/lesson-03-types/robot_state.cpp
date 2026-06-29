// robot_state.cpp — Lesson 2.3: a type-safe robot state representation.
// Build: g++ -std=c++17 -Wall -Wextra -Wconversion -O2 -o robot_state robot_state.cpp
#include <cmath>
#include <cstdint>
#include <iomanip>   // std::setprecision
#include <iostream>
#include <string>

// Hardware constants — known at compile time
constexpr double  WHEEL_RADIUS_M    = 0.0762;   // meters
constexpr double  WHEEL_BASE_M      = 0.335;    // meters
constexpr int32_t ENCODER_TICKS_REV = 4096;     // ticks per revolution

// Robot state — all types chosen deliberately
struct RobotState {
  double x_m           = 0.0;
  double y_m           = 0.0;
  double heading_rad   = 0.0;
  double linear_vel_ms = 0.0;
  double angular_vel_rads = 0.0;
  int32_t left_encoder_ticks  = 0;
  int32_t right_encoder_ticks = 0;
  float battery_voltage_v = 0.0f;
  bool estop_active      = false;
  bool obstacle_detected = false;
  bool charging          = false;
  std::string node_name = "base_controller";
};

// Convert encoder ticks to distance in meters — explicit cast documents intent.
double ticks_to_meters(int32_t ticks) {
  return static_cast<double>(ticks) / ENCODER_TICKS_REV
         * (2.0 * M_PI * WHEEL_RADIUS_M);
}

void print_state(const RobotState & s) {
  std::cout << std::fixed;
  std::cout << "--- " << s.node_name << " ---\n";
  std::cout << "  Position  : (" << std::setprecision(3) << s.x_m
            << ", " << s.y_m << ") m\n";
  std::cout << "  Heading   : " << std::setprecision(4) << s.heading_rad << " rad\n";
  std::cout << "  Velocity  : " << std::setprecision(3) << s.linear_vel_ms
            << " m/s, " << s.angular_vel_rads << " rad/s\n";
  std::cout << "  Left enc  : " << s.left_encoder_ticks
            << " ticks = " << ticks_to_meters(s.left_encoder_ticks) << " m\n";
  std::cout << "  Right enc : " << s.right_encoder_ticks
            << " ticks = " << ticks_to_meters(s.right_encoder_ticks) << " m\n";
  std::cout << "  Battery   : " << std::setprecision(1)
            << static_cast<double>(s.battery_voltage_v) << " V\n";
  std::cout << std::boolalpha;
  std::cout << "  E-stop    : " << s.estop_active << "\n";
  std::cout << "  Obstacle  : " << s.obstacle_detected << "\n";
}

int main() {
  RobotState robot;
  robot.node_name = "radian_base_controller";
  robot.x_m = 12.450;
  robot.y_m = 3.820;
  robot.heading_rad = 1.5708;   // 90 degrees
  robot.linear_vel_ms = 0.850;
  robot.angular_vel_rads = 0.0;
  robot.left_encoder_ticks  = 98304;   // 24 full revolutions
  robot.right_encoder_ticks = 98176;
  robot.battery_voltage_v = 25.3f;

  print_state(robot);

  // Demonstrate uint16_t encoder rollover (defined wrap-around).
  uint16_t hw_encoder = 65530;
  std::cout << "\n--- Encoder Rollover Simulation ---\n";
  for (int i = 0; i < 10; ++i) {
    hw_encoder = static_cast<uint16_t>(hw_encoder + 1);  // wraps 65535 -> 0
    std::cout << "  tick: " << hw_encoder << "\n";
  }

  return 0;
}
