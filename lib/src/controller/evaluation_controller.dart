import 'package:flutter/cupertino.dart';
import 'package:gluecks_barometer/src/controller/data_controller.dart';
import 'package:gluecks_barometer/src/model/entry.dart';

enum EvalTimespan { WEEK, MONTH, YEAR, ALL }

extension ToString on EvalTimespan {
  String description() {
    switch (this) {
      case EvalTimespan.WEEK:
        return "Letzte Woche";
      case EvalTimespan.MONTH:
        return "Letzten Monat";
      case EvalTimespan.YEAR:
        return "Letztes Jahr";
      case EvalTimespan.ALL:
        return "Seit Messbeginn";
      default:
        return "Unbekannte Zeitspanne";
    }
  }
}

class EvaluationController extends ChangeNotifier {
  EvalTimespan _timespan = EvalTimespan.WEEK;

  EvalTimespan get timespan => _timespan;

  set timespan(EvalTimespan value) {
    _timespan = value;
    notifyListeners();
  }

  List<Entry> getData(DataController dataSource) {
    DateTime now = DateTime.now();
    return List.of(dataSource.user.entries.where((entry) {
      switch (_timespan) {
        case EvalTimespan.WEEK:
          return entry.entryDate.isAfter(now.subtract(Duration(days: 7)));
        case EvalTimespan.MONTH:
          return entry.entryDate.isAfter(now.subtract(Duration(days: 30)));
        case EvalTimespan.YEAR:
          return entry.entryDate.isAfter(now.subtract(Duration(days: 365)));
        case EvalTimespan.ALL:
          return true;
        default:
          return false;
      }
    }));
  }
}
