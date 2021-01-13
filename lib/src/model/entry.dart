import 'package:gluecks_barometer/src/model/activity.dart';
import './entry.dart';


class Entry {
  Activity activity;
  DateTime entryDate;
  var productivityValue;
  var feelingValue;

  ///Entry Constructor
  Entry(this.activity, this.entryDate, this.productivityValue, this.feelingValue);
}



