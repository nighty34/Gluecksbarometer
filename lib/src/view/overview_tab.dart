import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/controller/settings_controller.dart';
import 'package:gluecks_barometer/src/view/new_datapoint.dart';
import 'package:provider/provider.dart';

class OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Provider.of<SettingsController>(context);
    return Center(
      child: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text("Guten Tag, ${settingsController.settings.name}!"),
              tileColor: Colors.blueGrey,
              //TODO: LIST WITH FAVs
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Aktion Eintragen"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => NewDatapoint()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
