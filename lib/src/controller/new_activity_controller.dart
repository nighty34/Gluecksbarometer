import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewActivityController extends ChangeNotifier {
  String _icon;
  String _name;

  NewActivityController() {
    reset();
  }

  String get icon => _icon;

  set icon(String value) {
    _icon = value;
    notifyListeners();
  }

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  reset() {
    _icon = "run";
    _name = "";
  }
}
