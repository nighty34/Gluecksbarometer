import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/controller/settings_controller.dart';
import 'package:gluecks_barometer/src/model/settings.dart';
import 'package:provider/provider.dart';

/// Tab for letting the user change their settings
class SettingsTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Provider.of<SettingsController>(context);
    return ListView(
      children: [
        Card(child: ListTile(
          title: _Title("Name"),
          trailing: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 20, maxWidth: 150),
              child: TextFormField(
                initialValue: controller.settings.name,
                onChanged: (v) => controller.name = v,
              )),
        )),
        Card(child: ListTile(
          title: _Title("Thema"),
          trailing: DropdownButton(
            items: [
              DropdownMenuItem(child: Text("Systemangepasst"), value: ThemeType.SYSTEM_DEFAULT),
              DropdownMenuItem(child: Text("Dunkel"), value: ThemeType.DARK),
              DropdownMenuItem(child: Text("Hell"), value: ThemeType.LIGHT),
            ],
            onChanged: (v) => controller.theme = v,
            value: controller.settings.theme,
          ),
        )),
        Card(child: ListTile(
          title: _Title("Tips"),
          trailing: Switch(
            activeColor: Theme.of(context).primaryColor,
            onChanged: (v) => controller.tipsEnabled = v,
            value: controller.settings.tipsEnabled,
          ),
        )),
        Card(child: ListTile(
          title: _Title("Erinnerungen"),
          trailing: Switch(
            activeColor: Theme.of(context).primaryColor,
            onChanged: (v) => controller.reminderEnabled = v,
            value: controller.settings.reminderEnabled,
          ),
        )),
        Card(child: ListTile(
          title: _Title("Erinnerungszeitpunkt"),
          trailing: InkWell(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Text(controller.settings.reminderTime.hour.toString() + ":" +
                (controller.settings.reminderTime.minute < 10 ? "0" : "") +
                controller.settings.reminderTime.minute.toString())
            ),
            onTap: () async {
              TimeOfDay picked = await showTimePicker(context: context, initialTime: controller.settings.reminderTime);
              if (picked != null) { // if the user cancels, the returned value is null.
                controller.reminderTime = picked;
              }
            },
          ),
        ))
      ],
    );
  }
}

/// Title for a setting
class _Title extends StatelessWidget {
  final String _text;

  _Title(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(_text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}
