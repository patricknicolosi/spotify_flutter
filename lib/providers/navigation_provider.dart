import 'package:flutter/material.dart';
import 'package:spotify_flutter/screens/home_screen.dart';

class NavigationProvider extends ChangeNotifier {
  Widget currentScreen = const HomeScreen();
  bool showToolsBar = true;

  void changeCurrentScreen(Widget newScreen, {bool? showToolsBarValue = true}) {
    currentScreen = newScreen;
    if (showToolsBarValue != null) {
      showToolsBar = showToolsBarValue;
    }
    notifyListeners();
  }
}
