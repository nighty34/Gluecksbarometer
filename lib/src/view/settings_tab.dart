import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/controller/settings_controller.dart';
import 'package:gluecks_barometer/src/model/settings.dart';
import 'package:provider/provider.dart';

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
        ))
      ],
    );
  }
}

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
