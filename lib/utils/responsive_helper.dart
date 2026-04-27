import 'package:flutter/material.dart';

extension ResponsiveContext on BuildContext {
  // Get common screen dimensions
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  // Define your Tier logic once
  bool get isSmall => screenWidth <= 400;
  bool get isLarge => screenWidth > 400;
  bool get isTablet => screenWidth > 600;

  // Create a helper for fluid scaling
  double relativeWidth(double percentage) => screenWidth * percentage;
  double relativeHeight(double percentage) => screenHeight * percentage;
}
