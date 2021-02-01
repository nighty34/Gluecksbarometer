import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/model/activity.dart';
import 'package:gluecks_barometer/src/model/entry.dart';
import 'package:gluecks_barometer/src/model/user.dart';

class DataController extends ChangeNotifier {
  User _user = new User();

  User get user => _user;

  final Map<String, IconData> activityIcons = {
    // TODO add more
    "run": Icons.directions_run,
    "build": Icons.build,
    "sleep": Icons.airline_seat_individual_suite,
    "travel": Icons.airplanemode_active_rounded,
    "money": Icons.attach_money,
    "music": Icons.audiotrack,
  };

  addActivity(Activity activity) {
    _user.activities[activity.name] = activity;
    notifyListeners();
  }

  addEntry(Entry entry) {
    _user.entries.add(entry);
    notifyListeners();
  }
}
