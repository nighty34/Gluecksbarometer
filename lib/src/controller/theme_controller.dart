import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/model/theme.dart';

enum ThemeType { Light, Dark }

class ThemeController extends ChangeNotifier {
  ThemeType currentThemeType = ThemeType.Light;
  ThemeData _currentTheme = themeData[0];

  void switchTheme() => currentThemeType == ThemeType.Light
      ? currentTheme = ThemeType.Dark
      : currentTheme = ThemeType.Light;

  set currentTheme(ThemeType theme) {
    if (theme != null) {
      currentThemeType = theme;
      _currentTheme =
      currentThemeType == ThemeType.Light ? themeData[0] : themeData[1];

      notifyListeners();
    }
  }

  get currentTheme => currentThemeType;
  get currentThemeData => _currentTheme;
}