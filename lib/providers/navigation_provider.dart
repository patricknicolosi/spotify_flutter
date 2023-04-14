import 'package:flutter/material.dart';
import 'package:spotify_flutter/screens/home_screen.dart';

class NavigationProvider extends ChangeNotifier {
  Widget currentScreen = const HomeScreen();
  bool showToolBar = true;

  void changeCurrentScreen(Widget newScreen, {bool? showToolBarValue}) {
    currentScreen = newScreen;
    if (showToolBarValue != null) {
      showToolBar = showToolBarValue;
    }
    notifyListeners();
  }
}
