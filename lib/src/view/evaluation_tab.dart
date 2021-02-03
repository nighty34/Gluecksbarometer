import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/controller/data_controller.dart';
import 'package:gluecks_barometer/src/model/entry.dart';
import 'package:gluecks_barometer/src/model/mood.dart';
import 'package:provider/provider.dart';

class EvaluationTab extends StatelessWidget {
  final List<_PiePair> _initialPie = [
    _PiePair(Mood.very_dissatisfied, 0),
    _PiePair(Mood.dissatisfied, 0),
    _PiePair(Mood.neutral, 0),
    _PiePair(Mood.satisfied, 0),
    _PiePair(Mood.very_satisfied, 0),
  ];

  final Map<Mood, charts.Color> _moodColors = {
    Mood.very_dissatisfied: charts.MaterialPalette.red.shadeDefault,
    Mood.dissatisfied: charts.MaterialPalette.deepOrange.shadeDefault,
    Mood.neutral: charts.MaterialPalette.yellow.shadeDefault,
    Mood.satisfied: charts.MaterialPalette.green.makeShades(2)[1],
    Mood.very_satisfied: charts.MaterialPalette.green.makeShades(2)[0]
  };

  @override
  Widget build(BuildContext context) {
    DataController dataController = Provider.of<DataController>(context);

    return Center(
      child: dataController.user.entries.length > 0
          ? buildCharts(context)
          : buildExcuse(context),
    );
  }

  Widget buildExcuse(BuildContext context) {
    return Card(
      child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(30),
          child: Text(
              "Nachdem du Daten erfasst hast, wird hier eine Auswertung zu sehen sein.")),
    );
  }

  Widget buildCharts(BuildContext context) {
    DataController dataController = Provider.of<DataController>(context);

    List<charts.Series<_PiePair, int>> moodSeries = [
      charts.Series<_PiePair, int>(
        data: dataController.user.entries
            .fold(List.of(_initialPie.map((e) => _PiePair(e.mood, e.count))),
                (pie, entry) {
          if (entry.entryDate
              .isAfter(DateTime.now().subtract(Duration(days: 30)))) {
            pie[entry.mood.index].count += 1;
          }
          return pie;
        }),
        colorFn: (_PiePair p, _) => _moodColors[p.mood],
        domainFn: (_PiePair p, _) => p.mood.index,
        measureFn: (_PiePair p, _) => p.count,
      )
    ];

    List<charts.Series<_PiePair, int>> productivitySeries = [
      charts.Series<_PiePair, int>(
        data: dataController.user.entries
            .fold(List.of(_initialPie.map((e) => _PiePair(e.mood, e.count))),
                (pie, entry) {
          if (entry.entryDate
              .isAfter(DateTime.now().subtract(Duration(days: 30)))) {
            pie[entry.productivity.index].count += 1;
          }
          return pie;
        }),
        colorFn: (_PiePair p, _) => _moodColors[p.mood],
        domainFn: (_PiePair p, _) => p.mood.index,
        measureFn: (_PiePair p, _) => p.count,
      )
    ];

    List<_ActivityPair> topMood = _topActivitiesBy(
        context, (entry) => entry.mood.index.floorToDouble() * .25, 5);
    List<_ActivityPair> topProd = _topActivitiesBy(
        context, (entry) => entry.productivity.index.floorToDouble() * .25, 5);

    return ListView(
      children: [
        Card(
            child: Column(children: [
          _Title("Gefühlslage des letzten Monats"),
          ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
              child: charts.PieChart(moodSeries)),
        ])),
        Card(
            child: Column(
          children: [
            _Title("Produktivität des letzten Monats"),
            ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
                child: charts.PieChart(productivitySeries))
          ],
        )),
        Card(
            child: Column(
          children: [
            _Title("Aktivitäten für gute Laune"),
            _topActivityList(context, topMood)
          ],
        )),
        Card(
            child: Column(
          children: [
            _Title("Aktivitäten für produktivität"),
            _topActivityList(context, topProd)
          ],
        )),
      ],
    );
  }

  ListView _topActivityList(BuildContext context, List<_ActivityPair> topList) {
    DataController dataController = Provider.of<DataController>(context);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (con, x) {
          if (topList.length > x) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.of([
                Text((x + 1).toString() + "."),
                Column(
                  children: [
                    Icon(dataController.activityIcons[
                        dataController.user.activities[topList[x].id].iconSrc]),
                    Text(dataController.user.activities[topList[x].id].name)
                  ],
                ),
                Text((topList[x].score * 100).toString().substring(0, 2) + "%")
              ].map((e) => Container(
                  padding: EdgeInsets.fromLTRB(40, 8, 40, 8), child: e))),
            );
          } else {
            return Column();
          }
        });
  }

  List<_ActivityPair> _topActivitiesBy(
      BuildContext context, double Function(Entry) value, int count) {
    DataController dataController = Provider.of<DataController>(context);
    Map<int, _ActivityPair> activities = {};
    dataController.user.activities
        .forEach((id, activity) => activities[id] = _ActivityPair(activity.id));
    dataController.user.entries.forEach((entry) {
      // calculate score and count of activities
      entry.activities.forEach((activity) {
        activities[activity].count += 1;
        activities[activity].score = value(entry);
      });
    });
    activities.forEach((name, activity) {
      activity.score /= activity.count; // score relative to activity count
    });
    List<_ActivityPair> top = List.of(activities.values);
    top.sort((a, b) => b.score.compareTo(a.score)); // Sort by score
    top = List.of(top.take(count)); // Get top
    return top;
  }
}

class _PiePair {
  Mood mood;
  int count;

  _PiePair(this.mood, this.count);
}

class _ActivityPair {
  double score = 0;
  int count = 0;
  int id;

  _ActivityPair(this.id);
}

class _Title extends StatelessWidget {
  final String _text;

  _Title(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(_text, style: TextStyle(fontSize: 16)),
    );
  }
}
