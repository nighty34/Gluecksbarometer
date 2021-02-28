import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/controller/data_controller.dart';
import 'package:gluecks_barometer/src/controller/new_activity_controller.dart';
import 'package:gluecks_barometer/src/controller/new_datapoint_controller.dart';
import 'package:gluecks_barometer/src/model/activity.dart';
import 'package:gluecks_barometer/src/model/entry.dart';
import 'package:gluecks_barometer/src/view/mood_rating_bar.dart';
import 'package:gluecks_barometer/src/view/new_activity.dart';
import 'package:provider/provider.dart';

/// Screen to create a new entry
class NewDatapoint extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DataController dataController = Provider.of<DataController>(context);
    NewDatapointController controller = Provider.of<NewDatapointController>(context);

    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

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
                          constraints: BoxConstraints.tightForFinite(height: 300),
                          padding: EdgeInsets.all(20),
                          width: 500,
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5
                            ),
                            itemCount: dataController.user.activities.length + 1,
                            itemBuilder: (con, x) => _buildActivityItem(con, overlay, x),
                          )
                        ),
                      ],
                    )),
              ),
              IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.green),
                  onPressed: () {
                    dataController.addEntry(new Entry(
                        List.of(controller.chosenActivities.map((a) => a.id)),
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

  Widget _buildActivityItem(BuildContext context, RenderBox overlay, int x) {
    DataController dataController = Provider.of<DataController>(context);
    NewDatapointController controller = Provider.of<NewDatapointController>(context);
    var tapPosition;

    if (x < dataController.user.activities.length) {
      Activity activity = dataController
          .user.activities.values
          .elementAt(x);
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: controller.chosenActivities.contains(activity) ? Colors.grey: Colors.transparent,
          ),
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                  dataController.activityIcons[activity.iconSrc]
              ),
              Text(
                activity.name,
                maxLines: 1,
              )
            ],
          )
        ),
        onTapDown: (details) => tapPosition = details.globalPosition,
        onTap: () => controller
            .chosenActivities
            .contains(activity)
            ? controller
            .removeChosenActivity(activity)
            : controller
            .addChosenActivity(activity),
        onLongPress: () => showMenu(
          position: RelativeRect.fromRect(
              tapPosition & const Size(50, 50),
              Offset.zero & overlay.size
          ),
          context: context,
          items: <PopupMenuItem>[
            PopupMenuItem(
                child: TextButton(
                  child: Row(children: [
                    Icon(Icons.create),
                    Text("Editieren..."),
                  ]),
                  onPressed: () {
                    Navigator.pop(context);
                    NewActivityController activityController = Provider.of<NewActivityController>(context, listen: false);
                    activityController.updateMode(activity.id);
                    activityController.name = activity.name;
                    activityController.icon = activity.iconSrc;
                    Navigator.push(context, new MaterialPageRoute(builder: (_) => NewActivity()));
                  },
                )
            ),
            PopupMenuItem(
                child: TextButton(
                  child: Row(children: [
                    Icon(Icons.delete),
                    Text("Löschen..."),
                  ]),
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(context: context, builder: (_) => AlertDialog(
                      title: Text("'${activity.name}' löschen?"),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Abbrechen"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text("Löschen"),
                          onPressed: () {
                            dataController.removeActivity(activity.id);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ));
                  },
                )
            ),
          ],
        ),
      );
    } else {
      return TextButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.green),
            ]
          ),
          onPressed: () => Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (_) =>
                      NewActivity())));
    }
  }
}
