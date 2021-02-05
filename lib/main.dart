import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gluecks_barometer/src/controller/data_controller.dart';
import 'package:gluecks_barometer/src/controller/evaluation_controller.dart';
import 'package:gluecks_barometer/src/controller/new_activity_controller.dart';
import 'package:gluecks_barometer/src/controller/new_datapoint_controller.dart';
import 'package:gluecks_barometer/src/controller/settings_controller.dart';
import 'package:gluecks_barometer/src/model/settings.dart';
import 'package:gluecks_barometer/src/view/evaluation_tab.dart';
import 'package:gluecks_barometer/src/view/overview_tab.dart';
import 'package:gluecks_barometer/src/view/settings_tab.dart';
import 'package:gluecks_barometer/src/view/tips_tab.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Gluecksbarometer());
}

class Gluecksbarometer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ // TODO put providers as low as possible on widget tree
          ChangeNotifierProvider(create: (_) => DataController()),
          ChangeNotifierProvider(create: (_) => NewDatapointController()),
          ChangeNotifierProvider(create: (_) => NewActivityController()),
          ChangeNotifierProvider(create: (_) => EvaluationController()),
        ],
        child: ChangeNotifierProvider(
            create: (context) => SettingsController(),
            child: Consumer<SettingsController>(
                builder: (context, controller, child) => MaterialApp(
                  home: Home(),
                  theme: controller.getThemeData(ThemeType.LIGHT),
                  darkTheme: controller.getThemeData(ThemeType.DARK),
                  themeMode: controller.settings.theme == ThemeType.SYSTEM_DEFAULT
                      ? ThemeMode.system
                      : (controller.settings.theme == ThemeType.DARK)
                      ? ThemeMode.dark
                      : ThemeMode.light,
                )
            )
        )
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Provider.of<SettingsController>(context);
    SystemChrome.setSystemUIOverlayStyle(
        settingsController.settings.theme == ThemeType.DARK ?
            SystemUiOverlayStyle.dark.copyWith(statusBarColor: Theme.of(context).primaryColor)
            : SystemUiOverlayStyle.light.copyWith(statusBarColor: Theme.of(context).primaryColor)
    );
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: settingsController.settings.tipsEnabled ? 4 : 3,
          child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(icon: Icon(Icons.home)),
                    Tab(icon: Icon(Icons.timeline))]
                    + (settingsController.settings.tipsEnabled ? [Tab(icon: Icon(Icons.lightbulb))] : []) +
                    [Tab(icon: Icon(Icons.settings))
                  ],
                ),
                title: Text("Glücksbarometer"),
              ),
              body: TabBarView(
                children: [OverviewTab(), EvaluationTab()] + (settingsController.settings.tipsEnabled ? [TipsTab()] : []) +  [SettingsTab()],
              ),
          ),
        ),
      )
    );
  }
}
