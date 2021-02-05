import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/data/activity_dao.dart';
import 'package:gluecks_barometer/src/data/entry_dao.dart';
import 'package:gluecks_barometer/src/model/activity.dart';
import 'package:gluecks_barometer/src/model/entry.dart';
import 'package:gluecks_barometer/src/model/user.dart';

class DataController extends ChangeNotifier {
  final Map<String, IconData> activityIcons = {
    // TODO add more
    "run": Icons.directions_run,
    "build": Icons.build,
    "sleep": Icons.airline_seat_individual_suite,
    "travel": Icons.airplanemode_active_rounded,
    "money": Icons.attach_money,
    "music": Icons.audiotrack,
  };

  User _user;

  User get user => _user;

  DataController() {
    _user = new User();
    _fillData();
  }

  _fillData() async {
    _user.activities = Map.fromIterable(await ActivityDao().readAll(),
        key: (activity) => activity.id, value: (activity) => activity);
    notifyListeners();
    _user.entries = await EntryDao().readAll();
    notifyListeners();
  }

  addActivity(Activity activity) async {
    int id = await ActivityDao().insert(activity);
    activity.id = id;
    _user.activities[id] = activity;
    notifyListeners();
  }

  removeActivity(int id) async {
    ActivityDao().delete(id);
    _user.activities.removeWhere((key, _) => key == id);
    _user.entries.forEach((entry) => entry.activities.removeWhere((key) => key == id));
    notifyListeners();
  }

  updateActivity(Activity activity) async {
    ActivityDao().update(activity);
    _user.activities[activity.id] = activity;
    notifyListeners();
  }

  addEntry(Entry entry) async {
    int id = await EntryDao().insert(entry);
    entry.id = id;
    _user.entries.add(entry);
    notifyListeners();
  }
}
