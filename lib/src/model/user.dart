import 'package:gluecks_barometer/src/model/activity.dart';
import 'package:gluecks_barometer/src/model/entry.dart';

/// A user. The user has all their data, i.e. entries and activities.
class User {

  /// A list of entries.
  List<Entry> entries = List.empty(growable: true);

  /// A list of activities created by the user
  Map<int, Activity> activities = {};
}
