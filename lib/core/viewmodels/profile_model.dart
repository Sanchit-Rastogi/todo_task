import 'package:flutter/material.dart';
import 'package:todo/core/services/provider/theme_provider.dart';
import 'package:todo/locator.dart';

class ProfileModel extends ChangeNotifier {
  final ThemeProvider themeProvider = locator<ThemeProvider>();
  List<bool> themeValues = [true, false, false];

  ThemeMode currentTheme = ThemeMode.system;

  void updateTheme(ThemeMode mode) {
    currentTheme = mode;
    notifyListeners();
  }

  void updateThemeValue(int id) {
    for (int i = 0; i < 3; i++) {
      if (i == id) {
        themeValues[i] = true;
      } else {
        themeValues[i] = false;
      }
    }
    print(themeValues);
    notifyListeners();
  }

  void onInit() {
    print(themeProvider.themeMode);
    if (themeProvider.themeMode == ThemeMode.dark)
      updateThemeValue(2);
    else if (themeProvider.themeMode == ThemeMode.light) updateThemeValue(1);
    print(themeValues);
  }
}
