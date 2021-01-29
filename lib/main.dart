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
              bottomNavigationBar: AppBar(
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(text: "Status",),
                    Tab(text: "Auswertung"),
                    Tab(text: "Tipps")
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Center(child: Text("I'll be a list!")),
                  Center(child: ListView(
                    children: <Widget>[
                      Card(
                        child: Text("Wie fühlst du dich heute?"),
                      ),
                      Card(
                        child: Text("Warst du heute produktiv?"),
                      ),
                      Card(
                        child: Text("Was hast du heute gemacht?"),
                      )
                    ],
                  ),),
                  Center(child: Text("Tipps"),)
                ],
              ),
            )
        ),
      ),
    );
  }
}

