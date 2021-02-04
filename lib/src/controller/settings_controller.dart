import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/data/settings_dao.dart';
import 'package:gluecks_barometer/src/model/settings.dart';

class SettingsController extends ChangeNotifier {

  final Map<ThemeType, ThemeData> themeData = {
    ThemeType.LIGHT: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.lightBlueAccent),
    ThemeType.DARK: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.orange,
        accentColor: Colors.yellowAccent)
  };

  Settings _settings = Settings("MENSCH", ThemeType.DARK, false);
  Settings get settings => _settings;

  SettingsController() {
    _fillData();
  }

  _fillData() async {
    _settings = await SettingsDao().read("user");
  }

  ThemeData getThemeData(ThemeType type) {
    return themeData[settings.theme];
  }

  set name(String value) {
    _settings.name = value;
    SettingsDao().update(_settings);
    notifyListeners();
  }

  set theme(ThemeType value) {
    _settings.theme = value;
    SettingsDao().update(_settings);
    notifyListeners();
  }

  set tipsEnabled(bool value) {
    _settings.tipsEnabled = value;
    SettingsDao().update(_settings);
    notifyListeners();
  }
}