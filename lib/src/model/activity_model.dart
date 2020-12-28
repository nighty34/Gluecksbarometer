import './activity_model.dart';

class Activity {
  String name;
  String iconSrc;

  ///Activity Constructor
  Activity(this.name, this.iconSrc);

}

class ActivityList {
  List<Activity> activities;
}