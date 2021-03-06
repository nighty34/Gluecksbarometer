import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/controller/data_controller.dart';
import 'package:gluecks_barometer/src/controller/new_activity_controller.dart';
import 'package:gluecks_barometer/src/model/activity.dart';
import 'package:provider/provider.dart';

/// Screen that lets the user create a new activity
class NewActivity extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    NewActivityController controller =
        Provider.of<NewActivityController>(context);
    DataController dataController =
        Provider.of<DataController>(context, listen: false);

    SimpleDialog pickerDialog = SimpleDialog(
      title: Container(padding: EdgeInsets.all(10), alignment: Alignment.center, child: Text("Bild wählen", style: TextStyle(fontSize: 16))),
      children: [
        Container(
          width: 500,
          height: 500,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemCount: dataController.activityIcons.length,
            itemBuilder: (_, x) => FlatButton(
              child: Icon(List.of(dataController.activityIcons.values)[x]),
              onPressed: () {
                controller.icon = List.of(dataController.activityIcons.keys)[x];
                Navigator.pop(context);
              },
            )
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Neue Aktivität"),
          ),
          body: ListView(
            children: <Widget>[
              Card(
                child: ListTile(
                  title: Text("Name"),
                  trailing: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 20, maxWidth: 150),
                      child: TextFormField(
                        initialValue: controller.name,
                        onChanged: (v) => controller.name = v,
                      )),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Bild"),
                  trailing: Icon(dataController.activityIcons[controller.icon]),
                  onTap: () => showDialog(context: context, builder: (_) => pickerDialog)
                ),
              ),
              IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.green),
                  onPressed: () {
                    // check if the name has not been defined for the activity
                    if (controller.name.isEmpty) {
                      _showWarning(context, "Bitte gib einen Namen an.");
                      return;
                    }

                    // check if there is already an activity with this name
                    if (dataController.user.activities.values.any((a) => a.name == controller.name)) {
                      _showWarning(context, "Eine Aktion mit diesem Namen existiert schon. Bitte wähle einen anderen Namen.");
                      return;
                    }

                    if (controller.isUpdating()) {
                      dataController.updateActivity(new Activity.identified(controller.id, controller.name, controller.icon));
                    } else {
                      dataController.addActivity(new Activity(controller.name, controller.icon));
                    }
                    controller.reset();
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }

  _showWarning(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (con) => AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
            child: Text("Ok"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      )
    );
  }
}
