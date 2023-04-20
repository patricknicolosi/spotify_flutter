import 'package:flutter/material.dart';

class ScreenUtils {
  static const double desktopBreakpoint = 1000.0;

  static bool isDesktop(BuildContext context) {
    if (screenWidth(context) >= desktopBreakpoint) return true;
    return false;
  }

  static bool isMobile(BuildContext context) {
    if (screenWidth(context) <= desktopBreakpoint) return true;
    return false;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
