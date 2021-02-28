import 'package:flutter/cupertino.dart';
import 'package:gluecks_barometer/src/model/activity.dart';
import 'package:gluecks_barometer/src/model/mood.dart';
import 'package:gluecks_barometer/src/view/new_activity.dart';

/// Controller responsible for temporary state in the [NewActivity] screen
class NewDatapointController extends ChangeNotifier {

  Mood _mood;
  Mood _productivity;
  List<Activity> _chosenActivities;

  NewDatapointController() {
    reset();
  }

  Mood get mood => _mood;

  set mood(Mood mood) {
    _mood = mood;
    notifyListeners();
  }

  Mood get productivity => _productivity;

  set productivity(Mood mood) {
    _productivity = mood;
    notifyListeners();
  }

  List<Activity> get chosenActivities => _chosenActivities;

  set chosenActivities(List<Activity> activities) {
    _chosenActivities = activities;
    notifyListeners();
  }

  /// Add [activity] to the list of chosen activities
  addChosenActivity(Activity activity) {
    _chosenActivities.add(activity);
    notifyListeners();
  }

  /// Remove [activity] from the list of chosen activities
  removeChosenActivity(Activity activity) {
    _chosenActivities.remove(activity);
    notifyListeners();
  }

  /// Reset the controller to initial state
  reset() {
    _mood = Mood.very_satisfied;
    _chosenActivities = List.empty(growable: true);
    _productivity = Mood.very_satisfied;
  }
}
