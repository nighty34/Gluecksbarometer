import 'package:flutter/material.dart';

/// A list of theme types
enum ThemeType {
  SYSTEM_DEFAULT, DARK, LIGHT
}

/// A settings instance. It saves the users settings.
class Settings {

  /// The settings type. This could, for example be 'default' or 'user'
  String stype;
  String name;
  ThemeType theme;
  bool tipsEnabled;
  bool reminderEnabled;
  TimeOfDay reminderTime;

  Settings(this.name, this.theme, this.tipsEnabled, this.reminderEnabled, this.reminderTime) {
    stype = "user";
  }

  /// Create a settings instance with the id given
  Settings.identified(this.stype, this.name, this.theme, this.tipsEnabled, this.reminderEnabled, this.reminderTime);

  /// Create a settings instance from a [map]
  Settings.fromMap(Map<String, dynamic> map) {
    this.stype = map["stype"];
    this.name = map["name"];
    this.tipsEnabled = map["tipsEnabled"] == 1;

    switch (map["themeType"]) {
      case 0: this.theme = ThemeType.SYSTEM_DEFAULT; break;
      case 1: this.theme = ThemeType.DARK; break;
      case 2: this.theme = ThemeType.LIGHT; break;
    }

    this.reminderEnabled = map["reminderEnabled"] == 1;

    this.reminderTime = TimeOfDay.fromDateTime(DateTime.parse(map["reminderTime"]));
  }

  /// Create a map in the format accepted by [Settings.fromMap]
  Map<String, dynamic> toMap() {
    int _theme;
    switch (theme) {
      case ThemeType.SYSTEM_DEFAULT: _theme = 0; break;
      case ThemeType.DARK: _theme = 1; break;
      case ThemeType.LIGHT: _theme = 2; break;
    }

    String reminderHour = reminderTime.hour < 10 ? "0" : "" + reminderTime.hour.toString();
    String reminderMinute = reminderTime.minute < 10 ? "0" : "" + reminderTime.minute.toString();

    return {
      "stype": stype,
      "name": name,
      "themeType": _theme,
      "tipsEnabled": tipsEnabled ? 1 : 0,
      "reminderEnabled": reminderEnabled ? 0 : 1,
      "reminderTime": "1970-01-01 $reminderHour:$reminderMinute:00" // There is no such thing as timeofday in sqlite so we have to save it as a date
    };
  }
}