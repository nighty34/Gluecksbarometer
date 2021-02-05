import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/data/activity_dao.dart';
import 'package:gluecks_barometer/src/data/entry_dao.dart';
import 'package:gluecks_barometer/src/model/activity.dart';
import 'package:gluecks_barometer/src/model/entry.dart';
import 'package:gluecks_barometer/src/model/user.dart';
import 'package:gluecks_barometer/src/view/custom_icons.dart';

class DataController extends ChangeNotifier {
  final Map<String, IconData> activityIcons = {
    // TODO add more
    "run": Icons.directions_run,
    "build": Icons.build,
    "sleep": Icons.airline_seat_individual_suite,
    "travel": Icons.airplanemode_active_rounded,
    "money": Icons.attach_money,
    "music": Icons.audiotrack,
    "drive": Icons.directions_car_rounded,
    "eat": Icons.restaurant,
    "train": Icons.train,
    "write": Icons.mode_edit,
    "bank": CustomIcons.bank,
    "briefcase": CustomIcons.briefcase,
    "brush": CustomIcons.brush,
    "building": CustomIcons.building,
    "bullhorn": CustomIcons.bullhorn,
    "code": CustomIcons.code,
    "coffee": CustomIcons.coffee,
    "comment": CustomIcons.comment_empty,
    "planning": CustomIcons.drafting_compass,
    "facebook": CustomIcons.facebook_squared,
    "flask": CustomIcons.flask,
    "headphones": CustomIcons.headphones,
    "insta": CustomIcons.instagram,
    "linkedin": CustomIcons.linkedin,
    "pinterest": CustomIcons.pinterest,
    "doctor": CustomIcons.stethoscope,
    "swimming": CustomIcons.swimmer,
    "table_tennis": CustomIcons.table_tennis,
    "tree": CustomIcons.tree,
    "trophy": CustomIcons.trophy,
    "beach": CustomIcons.umbrella_beach,
    "wikipedia": CustomIcons.wikipedia_w,
    "youtube": CustomIcons.youtube_play,
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
