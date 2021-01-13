import './activity.dart';

class Activity {
  String name;
  String iconSrc;
  String desc;

  ///Activity Constructor
  Activity(this.name, this.iconSrc);

}

class ActivityList {
  List<Activity> activities;
}