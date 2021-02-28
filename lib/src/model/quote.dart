

/// A quote to be shown to the user
///
/// The quote has a text and an author. It can be saved to a
/// list by the user.
class Quote {

  /// The id by which the database identifies the quote
  int id;

  /// The quotes body
  String text;

  /// The author of the quote
  String author;

  /// The time and date at which the quote has last been featured as
  /// todays quote
  DateTime shown;

  /// Whether the quote has been saved to the users list of favorites.
  bool saved;

  Quote(this.text, this.author, this.shown, this.saved);

  /// Create a quote with the id given
  Quote.identified(this.id, this.text, this.author, this.shown, this.saved);

  /// Create a quote from a [map]
  Quote.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.text = map["text"];
    this.author = map["author"];
    this.shown = DateTime.parse(map["shown"]);
    this.saved = map["saved"] == 1 ? true : false;
  }

  /*
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
   */

  /// Create a map from this quote, in the format accepted by [Quote.fromMap]
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
