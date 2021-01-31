import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(text: "Status",),
                    Tab(text: "Auswertung"),
                    Tab(text: "Tipps")
                  ],
                ),
                title: Text("TEST"),
              ),
              body: TabBarView(
                children: [
                  buildStatus(),
                 buildEvulation(),
                  buildTipps()
                ],
              ),
            )
        ),
      ),
    );
  }

  Widget buildStatus(){
    return Center(child: ListView(
      children: <Widget>[
        Card(child: ListTile(
          title: Text("Guten Tag, TEMP!"),
          tileColor: Colors.blueGrey,

          //TODO: LIST WITH FAVs

        ),)
      ],
    ),);
  }


  Widget buildEvulation(){
    return  Center(child: ListView(
      children: <Widget>[
        Card(
          child: ListTile(
            title: Text("Bestandsaufnahme"),
            tileColor: Colors.blueGrey,
          ),
        ),
        Card(
          child: ListTile(title: Text("Wie fühlst du dich heute?"),),
        ),
        Card(
          child: ListTile(title: Text("Warst du heute produktiv?"),),
        ),
        Card(
          child: Text("Was hast du heute gemacht?"),
        )
      ],
    ),);
  }

  Widget buildTipps(){
    return  Center(child: ListView(
      children: <Widget>[
        Card(
          child: ListTile(
            title: Text("Tipps"),
            tileColor: Colors.blueGrey,
          ),
        )
      ],
    ),);
  }


}

