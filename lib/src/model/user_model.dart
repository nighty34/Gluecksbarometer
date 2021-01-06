import 'package:flutter/cupertino.dart';

import 'activity_model.dart';
import 'user_model.dart';

class User {
  Color prefColor;
  List<Activity> mostUsedActivities;
  String name;


  User(){
    this.prefColor = Color.fromARGB(10, 10, 10, 10); //TODO: REDO!
    this.mostUsedActivities = new List<Activity>();
  }
}