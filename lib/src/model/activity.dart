class Activity {
  int id;
  String name;
  String iconSrc;

  Activity(this.name, this.iconSrc);

  Activity.identified(this.id, this.name, this.iconSrc);

  Activity.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.name = map["name"];
    this.iconSrc = map["iconSrc"];
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "iconSrc": iconSrc};
  }
}
