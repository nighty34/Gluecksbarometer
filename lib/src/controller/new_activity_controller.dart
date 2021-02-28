import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/view/new_activity.dart';

/// Controller for the temporary state of a [NewActivity] screen
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

  /// Set data back to default
  reset() {
    _icon = "run";
    _name = "";
  }

  /// Enter update mode, where an activity gets updated instead of created
  updateMode(int activityId) {
    _id = activityId;
  }

  /// Check if we're in update mode
  bool isUpdating() {
    return _id != -1;
  }
}
