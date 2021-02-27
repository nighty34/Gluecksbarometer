import 'dart:convert';

class Quote {

  int id;
  String text;
  String author;
  DateTime shown;
  bool saved;

  Quote(this.text, this.author, this.shown, this.saved);
  Quote.identified(this.id, this.text, this.author, this.shown, this.saved);

  Quote.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.text = map["text"];
    this.author = map["author"];
    this.shown = DateTime.parse(map["shown"]);
    this.saved = map["saved"] == 1 ? true : false;
  }

  Quote.fromJson(String json) {
    var decoded = jsonDecode(json);
    assert(decoded is Map);
    var results = decoded["results"];
    assert(results is List);
    var result = results.first();
    assert(result is Map);

    this.text = result["quote"];
    this.author = result["author"];
    this.shown = DateTime.now();
    this.saved = false;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "text": text,
      "author": author,
      "shown": shown.toIso8601String(),
      "saved": saved ? 1 : 0
    };

    if (id != null && id != 0) {
      data["id"] = id;
    }

    return data;
  }
}
