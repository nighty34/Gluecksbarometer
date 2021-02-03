import 'package:gluecks_barometer/src/model/mood.dart';

class Entry {
  int id;
  List<int> activities;
  DateTime entryDate;
  Mood mood;
  Mood productivity;

  Entry(this.activities, this.entryDate, this.mood, this.productivity);

  Entry.identified(
      this.id, this.activities, this.entryDate, this.mood, this.productivity);

  Entry.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.entryDate = DateTime.parse(map["entryDate"]);
    this.mood = Mood.values[map["mood"]];
    this.productivity = Mood.values[map["productivity"]];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "entryDate": entryDate.toIso8601String(),
      "mood": mood.index,
      "productivity": productivity.index,
    };
  }
}
