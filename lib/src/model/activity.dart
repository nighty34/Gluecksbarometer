/// An activity.
///
/// Activities are user-defined and consist of an icon and a name.
class Activity {

  /// The id the database identified the activity by.
  int id;

  /// The name of the activity (human-readable)
  String name;

  /// The icon, identified by its icons name
  String iconSrc;

  Activity(this.name, this.iconSrc);

  /// Create an activity with the id given
  Activity.identified(this.id, this.name, this.iconSrc);

  /// Create an activity from a [map]
  ///
  /// The map is expected to contain all the activity fields.
  Activity.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.name = map["name"];
    this.iconSrc = map["iconSrc"];
  }

  /// Convert this activity to a map, in the format readable by [Activity.fromMap]
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "iconSrc": iconSrc};
  }
}
