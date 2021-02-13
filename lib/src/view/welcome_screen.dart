
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/main.dart';
import 'package:gluecks_barometer/src/controller/data_controller.dart';
import 'package:gluecks_barometer/src/controller/new_datapoint_controller.dart';
import 'package:gluecks_barometer/src/controller/settings_controller.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DataController dataController = Provider.of<DataController>(context);
    SettingsController controller = Provider.of<SettingsController>(
        context);
    String newName = "";

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              Card(
                child: ListTile(
                  title: Text("Bitte gebe deinen Namen ein"),
                  trailing: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 20, maxWidth: 150),
                      child: TextFormField(
                        onChanged: (v) => newName = v,
                      )),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.green),
                  onPressed: () {
                    controller.name = newName;
                    Navigator.pop(context);
                  })
            ],
          )
        ),
      ),
    );
  }
}