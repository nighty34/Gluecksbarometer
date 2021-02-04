import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/controller/data_controller.dart';
import 'package:gluecks_barometer/src/controller/new_activity_controller.dart';
import 'package:gluecks_barometer/src/controller/new_datapoint_controller.dart';
import 'package:gluecks_barometer/src/controller/theme_controller.dart';
import 'package:gluecks_barometer/src/model/theme.dart';
import 'package:gluecks_barometer/src/view/evaluation_tab.dart';
import 'package:gluecks_barometer/src/view/overview_tab.dart';
import 'package:gluecks_barometer/src/view/tips_tab.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Gluecksbarometer());
}

class Gluecksbarometer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DataController()),
          ChangeNotifierProvider(create: (_) => NewDatapointController()),
          ChangeNotifierProvider(create: (_) => NewActivityController()),
          //ChangeNotifierProvider(create: (_) => ThemeController())
        ],
        child: ChangeNotifierProvider(
            create: (context) => ThemeController(), //change builder to create
            child: Consumer<ThemeController>(
                builder: (context, provider, child) => MaterialApp(
                    home: Home(),
                    theme: Provider.of<ThemeController>(context, listen: true)
                        .currentThemeData))));

    /* MaterialApp(
          home: Home(),
          theme: Provider.of<ThemeController>(context).currentThemeData));*/
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.white,
        body: SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    text: "Übersicht",
                  ),
                  Tab(text: "Auswertung"),
                  Tab(text: "Tipps")
                ],
              ),
              title: Text("Glücksbarometer"),
            ),
            body: TabBarView(
              children: [OverviewTab(), EvaluationTab(), TipsTab()],
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => Provider.of<ThemeController>(context, listen: false).switchTheme(),
                tooltip: 'Change teheme',
                child: const Icon(Icons.redo))),
      ),
    ));
  }
}
