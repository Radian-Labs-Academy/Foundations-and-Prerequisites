// robot_status.cpp — Lesson 2.2: a robot status printer.
// Build: g++ -std=c++17 -Wall -Wextra -O2 -o robot_status robot_status.cpp
// Run:   ./robot_status
#include <cstdlib>   // std::abs(int)
#include <iomanip>   // std::setprecision, std::fixed, std::boolalpha
#include <iostream>

// Simulated sensor values
const double BATTERY_VOLTAGE = 24.7;
const double LINEAR_VELOCITY = 0.85;
const double ANGULAR_VELOCITY = 0.12;
const int LEFT_ENCODER_TICKS = 48320;
const int RIGHT_ENCODER_TICKS = 48195;
const bool OBSTACLE_DETECTED = false;

int main() {
  std::cout << "==============================================\n";
  std::cout << "  Radian AMR — System Status\n";
  std::cout << "==============================================\n";

  std::cout << std::fixed << std::setprecision(2);
  std::cout << "  Battery voltage  : " << BATTERY_VOLTAGE << " V\n";
  std::cout << "  Linear velocity  : " << LINEAR_VELOCITY << " m/s\n";
  std::cout << "  Angular velocity : " << ANGULAR_VELOCITY << " rad/s\n";

  std::cout << "  Left encoder     : " << LEFT_ENCODER_TICKS << " ticks\n";
  std::cout << "  Right encoder    : " << RIGHT_ENCODER_TICKS << " ticks\n";

  int delta = LEFT_ENCODER_TICKS - RIGHT_ENCODER_TICKS;
  std::cout << "  Encoder delta    : " << delta << " ticks";
  if (std::abs(delta) > 100) {
    std::cout << "  [WARNING: large skew]";
  }
  std::cout << '\n';

  std::cout << std::boolalpha;
  std::cout << "  Obstacle detected: " << OBSTACLE_DETECTED << "\n";

  std::cout << "==============================================\n";
  return 0;
}
