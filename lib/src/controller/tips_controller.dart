
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:gluecks_barometer/src/data/tips_dao.dart';
import 'package:gluecks_barometer/src/model/quote.dart';

class TipsController extends ChangeNotifier {

  List<Quote> _savedQuotes;
  List<Quote> get savedQuotes => _savedQuotes;

  Quote _todaysQuote;
  Quote get todaysQuote => _todaysQuote;

  TipsController() {
    _savedQuotes = List.empty(growable: true);
    _todaysQuote = Quote("Dieses Zitat muss noch geladen werden.", "Unbekannt", DateTime(1970), false);
    _fillData();
  }

  _fillData() async {
    _savedQuotes = await TipsDao().readAll(filter: "saved=1");
    _fetchTodaysQuote();
    notifyListeners();
  }

  /*
  addQuote(Quote quote) async {
    if (quote.saved) {
      _savedQuotes.add(quote);
    }
    quote.id = await TipsDao().insert(quote);
    notifyListeners();
  }

   */

  updateQuote(Quote quote) async {

    bool containedInSaved = _savedQuotes.map((q) => q.id).contains(quote.id);

    if (quote.saved) {
      if (!containedInSaved) {
        _savedQuotes.add(quote);
      }
    } else {
      if (containedInSaved) {
        _savedQuotes.remove(quote);
      }
    }

    TipsDao().update(quote);
    notifyListeners();
  }

  /*
  removeQuote(Quote quote) {
    if (quote.saved) {
      _savedQuotes.remove(quote);
    }
    TipsDao().delete(quote.id);
    notifyListeners();
  }
  */

  Future<Quote> randomQuote() async {
    /*
    HttpClientRequest request = await HttpClient().getUrl(Uri.parse("https://api.paperquotes.com/quotes?tags=motivation&language=de&limit=1"));
    request.headers.add('Authorization', 'Token $_api_key');
    request.headers.add('Content-Type', 'application/json');
    HttpClientResponse response = await request.close();
    print(response.statusCode);
    if (response.statusCode == 200) {
      String json = await response.transform(Utf8Decoder()).join();
      print(json);
      Quote result = Quote.fromJson(json);
      addQuote(result);
      return result;
    } else {
      // if the api request didn't work, return a random not saved quote
    }
    */
    List<Quote> notSaved = await TipsDao().readAll(filter: "saved=0");
    return notSaved[Random().nextInt(notSaved.length)];
  }

  _fetchTodaysQuote() async {
    List<Quote> todays = await TipsDao().readAll(filter: "shown >= date('now', 'start of day')");
    if (todays.length > 0) {
      _todaysQuote = todays.first;
    } else {
      Quote random = await randomQuote();
      random.shown = DateTime.now();
      await TipsDao().update(random);
      _todaysQuote = random;
    }
    notifyListeners();
  }
}