import 'package:gluecks_barometer/src/model/activity.dart';
import 'package:gluecks_barometer/src/model/entry.dart';

class User {
  List<Entry> entries = List.empty(growable: true);
  Map<int, Activity> activities = {};
}
