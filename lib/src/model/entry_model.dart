import 'package:gluecks_barometer/src/model/activity_model.dart';
import './entry_model.dart';


class Entry {
  Activity activity;
  DateTime entryDate;
  var productivityValue;
  var feelingValue;

  ///Entry Constructor
  Entry(this.activity, this.entryDate, this.productivityValue, this.feelingValue);
}



