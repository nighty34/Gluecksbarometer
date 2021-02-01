import 'package:gluecks_barometer/src/model/mood.dart';

class Entry {
  List<String> activity;
  DateTime entryDate;
  Mood mood;
  Mood productivity;

  Entry(this.activity, this.entryDate, this.mood, this.productivity);
}



