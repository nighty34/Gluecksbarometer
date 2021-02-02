import 'package:gluecks_barometer/src/model/mood.dart';

class Entry {
  List<String> activities;
  DateTime entryDate;
  Mood mood;
  Mood productivity;

  Entry(this.activities, this.entryDate, this.mood, this.productivity);
}



