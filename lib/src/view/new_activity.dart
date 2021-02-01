import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:gluecks_barometer/src/controller/data_controller.dart';
import 'package:gluecks_barometer/src/controller/new_activity_controller.dart';
import 'package:gluecks_barometer/src/model/activity.dart';
import 'package:provider/provider.dart';

class NewActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NewActivityController controller =
        Provider.of<NewActivityController>(context);
    DataController dataController =
        Provider.of<DataController>(context, listen: false);

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
                  onTap: () => showMaterialSelectionPicker(
                      // TODO replace with SimpleDialog and GridView, remove flutter_material_pickers dependency
                      context: context,
                      title: "Bild wählen",
                      items: List.of(dataController.activityIcons.keys),
                      selectedItem: "Jogging",
                      icons: List.of(dataController.activityIcons.values
                          .map((e) => Icon(e))),
                      onChanged: (val) =>
                          controller.icon = val), // TODO icon picker
                ),
              ),
              IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.green),
                  onPressed: () {
                    dataController.addActivity(
                        new Activity(controller.name, controller.icon));
                    controller.reset();
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
