import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/view/new_datapoint.dart';

class OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text("Guten Tag, TEMP!"),
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
