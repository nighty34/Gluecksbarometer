import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/data/settings_dao.dart';
import 'package:gluecks_barometer/src/model/settings.dart';
import 'package:gluecks_barometer/src/view/reminder_notification.dart';

/// Controller for the [SettingsTap] screen
class SettingsController extends ChangeNotifier {

  /// Dark and light theme data
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

  Settings _settings = Settings("Mensch", ThemeType.DARK, false, true, TimeOfDay(hour: 19, minute: 0));
  Settings get settings => _settings;

  SettingsController() {
    _fillData();
  }

  _fillData() async {
    _settings = await SettingsDao().read("user");
    _updateNotification();
    notifyListeners();
  }

  /// Return theme data from a theme type
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

  set reminderEnabled(bool value) {
    _settings.reminderEnabled = value;
    SettingsDao().update(_settings);
    notifyListeners();
    _updateNotification();
  }

  set reminderTime(TimeOfDay value) {
    _settings.reminderTime = value;
    SettingsDao().update(_settings);
    notifyListeners();
    _updateNotification();
  }

  _updateNotification() async {
    ReminderNotification().unscheduleNotification();
    if (_settings.reminderEnabled) {
      ReminderNotification().scheduleNotification(
          _settings.reminderTime,
          "Erinnerung",
          "Hallo " + _settings.name + ", willst du einen Eintrag verfassen?"
      );
    }
  }
}