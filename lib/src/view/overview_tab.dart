import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gluecks_barometer/src/controller/data_controller.dart';
import 'package:gluecks_barometer/src/controller/settings_controller.dart';
import 'package:gluecks_barometer/src/model/entry.dart';
import 'package:gluecks_barometer/src/view/mood_rating_bar.dart';
import 'package:gluecks_barometer/src/view/new_datapoint.dart';
import 'package:gluecks_barometer/src/view/welcome_screen.dart';
import 'package:provider/provider.dart';

class OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Provider.of<SettingsController>(context);
    DataController dataController = Provider.of<DataController>(context);


    SchedulerBinding.instance.addPostFrameCallback((_) => checkForName(settingsController, context));

    return Center(
      child: ListView(
        children: <Widget>[
          Card(
            child: Container(
              padding: EdgeInsets.all(20),
              child: ListTile(
                title: Text("Guten Tag, ${settingsController.settings.name}!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300), textAlign: TextAlign.center),
              )
            ),
          ),
          Card(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: dataController.user.entries.length + 1,
              itemBuilder: (con, x) {
                if (x == 0) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Neue Aktivität..."),
                        FlatButton(
                          child: Icon(Icons.add, size: 30, color: Colors.green),
                          onPressed: () => Navigator.push(
                            context, MaterialPageRoute(builder: (_) => NewDatapoint())),
                        )
                      ]
                    )
                  );
                } else {
                  Entry entry = dataController.user.entries[x-1];
                  String date = _formatDate(entry.entryDate);
                  return Container(
                   alignment: Alignment.center,
                   padding: EdgeInsets.all(20),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(date),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           MoodRatingBar.getIcon(entry.mood.index),
                           MoodRatingBar.getIcon(entry.productivity.index),
                         ],
                       ),
                       FlatButton(
                         child: Icon(Icons.delete, color: Colors.red),
                         onPressed: () => showDialog(context: context, builder: (_) => AlertDialog(
                           title: Text("Eintrag vom ${date} löschen?"),
                           actions: <Widget>[
                             TextButton(
                               child: Text("Abbrechen"),
                               onPressed: () => Navigator.pop(context),
                             ),
                             TextButton(
                               child: Text("Löschen"),
                               onPressed: () {
                                 dataController.removeEntry(x);
                                 Navigator.pop(context);
                               },
                             )
                           ],
                         )),
                       ),
                     ],
                   )
                 );
                }
              },
            )
            /* child: ListTile(
              title: Text("Aktion Eintragen"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => NewDatapoint()));
              },
            ), */
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    String weekday = "";
    switch (dateTime.weekday) {
      case 1: weekday = "Montag"; break;
      case 2: weekday = "Dienstag"; break;
      case 3: weekday = "Mittwoch"; break;
      case 4: weekday = "Donnerstag"; break;
      case 5: weekday = "Freitag"; break;
      case 6: weekday = "Samstag"; break;
      case 7: weekday = "Sonntag"; break;
    }

    String minute = "${dateTime.minute}";
    if (minute.length == 1) {
      minute = "0" + minute;
    }

    return "${weekday}, ${dateTime.hour}:${minute}";
  }


  void checkForName(SettingsController settingsController, BuildContext context){
    if(settingsController.settings.name.isEmpty){
      print("No Name");
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => WelcomeScreen()));
    }
  }
}
