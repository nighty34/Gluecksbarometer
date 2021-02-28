import 'package:gluecks_barometer/src/model/mood.dart';

/// A data entry
///
/// An entry consists of the mood, the productivity, and activities participated in.
class Entry {

  /// The [id] by which the database identified the entry
  int id;

  /// A list of the ids of activities that the user selected
  List<int> activities;

  /// The time and date on which the entry was made
  DateTime entryDate;

  /// The mood (scale)
  Mood mood;

  /// The productivity (same scale)
  Mood productivity;

  Entry(this.activities, this.entryDate, this.mood, this.productivity);

  /// Create an entry with the id given
  Entry.identified(
      this.id, this.activities, this.entryDate, this.mood, this.productivity);

  /// Create an entry from a map with all fields
  Entry.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.entryDate = DateTime.parse(map["entryDate"]);
    this.mood = Mood.values[map["mood"]];
    this.productivity = Mood.values[map["productivity"]];
  }

  /// Create a map from the entry in the format that [Entry.fromMap] accepts.
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "entryDate": entryDate.toIso8601String(),
      "mood": mood.index,
      "productivity": productivity.index,
    };
  }
}
