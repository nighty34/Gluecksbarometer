import 'package:gluecks_barometer/src/model/activity.dart';
import 'package:gluecks_barometer/src/model/entry.dart';

class User {
  List<Entry> entries = List.empty(growable: true);
  Map<String, Activity> activities = {};

  User() {
    activities["Jogging"] = new Activity(
        "Jogging", "run"); // TODO add defaults and read from database
  }
}
