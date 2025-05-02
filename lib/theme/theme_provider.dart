import 'package:chat_app/theme/dark_mode.dart';
import 'package:chat_app/theme/light_mode.dart';

import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = AppPreference.isDarkmode ? darkMode : lightMode;
  ThemeData get themeData => _themeData;

  //bool get isDarkMode => _themeData == darkMode;

  // set themeData(ThemeData themeData) {
  //   _themeData = themeData;
  //   notifyListeners();
  // }

  void toggletheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
      AppPreference.isDarkMode = true;
    } else {
      _themeData = lightMode;
      AppPreference.isDarkMode = false;
    }
    notifyListeners();
  }
  
}

class AppPreference {
  static late Box boxOfData;
  static Future<void> initHive() async {
    await Hive.initFlutter();
    boxOfData = await Hive.openBox("data");
  }

  // saving user choised about theme selected
  static bool get isDarkmode =>
      boxOfData.get("isModeDark", defaultValue: false);
  static set isDarkMode(bool value) => boxOfData.put("isModeDark ", value);
}
