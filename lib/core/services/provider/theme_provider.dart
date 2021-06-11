import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/viewmodels/profile_model.dart';
import 'package:todo/locator.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  String key = "theme";

  // Future<ThemeMode> getTheme() async {
  //   _loadFromPrefer();
  //   return themeMode;
  // }

  ThemeProvider() {
    _loadFromPrefer();
  }

  _loadFromPrefer() async {
    SharedPreferences _prefs = await _sharedPreferences;
    String mode = _prefs.getString(key) ?? "system";
    if (mode.contains('dark'))
      setTheme(ThemeMode.dark);
    else if (mode.contains('light'))
      setTheme(ThemeMode.light);
    else
      setTheme(ThemeMode.system);
  }

  _savePrefs(ThemeMode mode) async {
    SharedPreferences _prefs = await _sharedPreferences;
    _prefs.setString(key, mode.toString());
  }

  setTheme(ThemeMode mode) {
    themeMode = mode;
    locator<ProfileModel>().updateTheme(mode);
    print(locator<ProfileModel>().currentTheme);
    _savePrefs(mode);
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    accentColor: Colors.white,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    accentIconTheme: IconThemeData(
      color: Colors.white70,
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    accentColor: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    accentIconTheme: IconThemeData(
      color: Colors.black38,
    ),
  );
}
