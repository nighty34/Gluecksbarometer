enum ThemeType {
  SYSTEM_DEFAULT, DARK, LIGHT
}

class Settings {

  String stype;
  String name;
  ThemeType theme;
  bool tipsEnabled;

  Settings(this.name, this.theme, this.tipsEnabled) {
    stype = "user";
  }
  Settings.identified(this.stype, this.name, this.theme, this.tipsEnabled);

  Settings.fromMap(Map<String, dynamic> map) {
    this.stype = map["stype"];
    this.name = map["name"];
    this.tipsEnabled = map["tipsEnabled"] == 1;

    switch (map["themeType"]) {
      case 0: this.theme = ThemeType.SYSTEM_DEFAULT; break;
      case 1: this.theme = ThemeType.DARK; break;
      case 2: this.theme = ThemeType.LIGHT; break;
    }
  }

  Map<String, dynamic> toMap() {
    int _theme;
    switch (theme) {
      case ThemeType.SYSTEM_DEFAULT: _theme = 0; break;
      case ThemeType.DARK: _theme = 1; break;
      case ThemeType.LIGHT: _theme = 2; break;
    }

    return {
      "stype": stype,
      "name": name,
      "themeType": _theme,
      "tipsEnabled": tipsEnabled ? 1 : 0
    };
  }
}