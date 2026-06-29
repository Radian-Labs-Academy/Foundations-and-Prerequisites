// diff_drive_kinematics.cpp — Lesson 2.4: differential-drive kinematics math.
// Build: g++ -std=c++17 -Wall -Wextra -O2 -o kinematics diff_drive_kinematics.cpp
#include <algorithm>
#include <cmath>
#include <iomanip>
#include <iostream>
#include <utility>

constexpr double WHEEL_RADIUS_M = 0.0762;   // 3-inch wheel
constexpr double WHEEL_BASE_M   = 0.335;    // 335mm track width
constexpr double MAX_WHEEL_VEL  = 2.5;      // m/s

struct WheelVelocities {
  double left_ms;
  double right_ms;
};

// Forward kinematics: Twist -> wheel velocities
WheelVelocities twist_to_wheels(double linear_ms, double angular_rads) {
  double v_left  = (linear_ms - angular_rads * WHEEL_BASE_M / 2.0) / WHEEL_RADIUS_M;
  double v_right = (linear_ms + angular_rads * WHEEL_BASE_M / 2.0) / WHEEL_RADIUS_M;
  v_left  = std::clamp(v_left,  -MAX_WHEEL_VEL, MAX_WHEEL_VEL);
  v_right = std::clamp(v_right, -MAX_WHEEL_VEL, MAX_WHEEL_VEL);
  return {v_left, v_right};
}

// Inverse kinematics: wheel velocities -> Twist
struct Twist { double linear; double angular; };

Twist wheels_to_twist(double v_left, double v_right) {
  double linear  = (v_left + v_right) / 2.0 * WHEEL_RADIUS_M;
  double angular = (v_right - v_left) / WHEEL_BASE_M * WHEEL_RADIUS_M;
  return {linear, angular};
}

// Stopping distance at current velocity (d = v^2 / 2a)
double stopping_distance(double velocity_ms, double decel_ms2 = 1.5) {
  return std::pow(velocity_ms, 2.0) / (2.0 * decel_ms2);
}

// Angle normalization to [-pi, pi]
double normalize_angle(double angle_rad) {
  return std::atan2(std::sin(angle_rad), std::cos(angle_rad));
}

int main() {
  std::cout << std::fixed << std::setprecision(4);

  auto [lv, rv] = [](WheelVelocities w) -> std::pair<double, double> {
    return {w.left_ms, w.right_ms};
  }(twist_to_wheels(1.0, 0.0));
  std::cout << "Fwd 1.0 m/s: left=" << lv << " right=" << rv << " m/s\n";

  auto w2 = twist_to_wheels(0.0, 1.0);
  std::cout << "Rotate 1.0 rad/s: left=" << w2.left_ms << " right=" << w2.right_ms << " m/s\n";

  // Small enough not to hit the wheel-velocity clamp, so the round-trip recovers.
  auto w3 = twist_to_wheels(0.15, 0.2);
  std::cout << "Combo v=0.15 w=0.2: left=" << w3.left_ms << " right=" << w3.right_ms << " m/s\n";

  auto recovered = wheels_to_twist(w3.left_ms, w3.right_ms);
  std::cout << "Round-trip: linear=" << recovered.linear
            << " angular=" << recovered.angular << " (expected 0.1500, 0.2000)\n";

  std::cout << "\n--- Stopping Distances (decel=1.5 m/s^2) ---\n";
  for (double v : {0.5, 1.0, 1.5, 2.0, 2.5}) {
    std::cout << "  v=" << v << " m/s -> stop in " << stopping_distance(v) << " m\n";
  }

  std::cout << "\n--- Angle Normalization ---\n";
  for (double a : {0.0, M_PI, 2 * M_PI, 3 * M_PI, -M_PI - 0.1}) {
    std::cout << "  " << a << " rad -> " << normalize_angle(a) << " rad\n";
  }

  return 0;
}
