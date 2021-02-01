import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/controller/data_controller.dart';
import 'package:gluecks_barometer/src/controller/new_datapoint_controller.dart';
import 'package:gluecks_barometer/src/model/activity.dart';
import 'package:gluecks_barometer/src/model/entry.dart';
import 'package:gluecks_barometer/src/view/mood_rating_bar.dart';
import 'package:gluecks_barometer/src/view/new_activity.dart';
import 'package:provider/provider.dart';

class NewDatapoint extends StatelessWidget {
  final Map<String, IconData> myIconCollection = {
    'favorite': Icons.favorite,
    'home': Icons.home,
    'android': Icons.android,
    'album': Icons.album,
    'ac_unit': Icons.ac_unit
  };

  @override
  Widget build(BuildContext context) {
    DataController dataController = Provider.of<DataController>(context);
    NewDatapointController controller =
        Provider.of<NewDatapointController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Bestandesaufnahme"),
          ),
          body: ListView(
            children: <Widget>[
              Card(
                child: ListTile(
                    title: Text("Wie fühlst du dich heute?"),
                    trailing: MoodRatingBar((mood) => controller.mood = mood)),
              ),
              Card(
                child: ListTile(
                  title: Text("Warst du heute produktiv?"),
                  trailing: MoodRatingBar(
                      (productivity) => controller.productivity = productivity),
                ),
              ),
              Card(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("Was hast du heute gemacht?",
                            style: TextStyle(fontSize: 16)),
                        Container(
                            padding: EdgeInsets.all(20),
                            height: 500,
                            width: 500,
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 5),
                                itemCount:
                                    dataController.user.activities.length + 1,
                                itemBuilder: (con, x) {
                                  if (x <
                                      dataController.user.activities.length) {
                                    Activity activity = dataController
                                        .user.activities.values
                                        .elementAt(x);
                                    return TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  controller.chosenActivities
                                                          .contains(activity)
                                                      ? Colors.tealAccent
                                                      : Colors.transparent)),
                                      child: Column(
                                        children: [
                                          Icon(
                                              dataController.activityIcons[
                                                  activity.iconSrc],
                                              color: Colors.black),
                                          Text(activity.name,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.black))
                                        ],
                                      ),
                                      onPressed: () => controller
                                              .chosenActivities
                                              .contains(activity)
                                          ? controller
                                              .removeChosenActivity(activity)
                                          : controller
                                              .addChosenActivity(activity),
                                    );
                                  } else {
                                    return TextButton(
                                        child: Column(children: [
                                          Icon(Icons.add, color: Colors.green),
                                          Text("")
                                          // this is a hack in order to align the button with the others
                                        ]),
                                        onPressed: () => Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (_) =>
                                                    NewActivity())));
                                  }
                                })),
                      ],
                    )),
              ),
              IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.green),
                  onPressed: () {
                    dataController.addEntry(new Entry(
                        List.of(controller.chosenActivities.map((e) => e.name)),
                        DateTime.now(),
                        controller.mood,
                        controller.productivity));
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
