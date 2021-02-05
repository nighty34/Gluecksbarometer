import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewActivityController extends ChangeNotifier {
  String _icon;
  String _name;
  int _id = -1;

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

  int get id => _id;

  reset() {
    _icon = "run";
    _name = "";
  }

  updateMode(int activityId) {
    _id = activityId;
  }

  bool isUpdating() {
    return _id != -1;
  }
}
