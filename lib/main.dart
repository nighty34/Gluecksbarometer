import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                  buildStatus(context),
                 buildEvulation(),
                  buildTipps()
                ],
              ),
            )
        ),
      ),
    );
  }

  Widget buildStatus(BuildContext context){
    return Center(child: ListView(
      children: <Widget>[
        Card(child: ListTile(
          title: Text("Guten Tag, TEMP!"),
          tileColor: Colors.blueGrey,

          //TODO: LIST WITH FAVs

        ),),

        Card(child: ListTile(
          title: Text("Aktion Eintragen "),
          onTap: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => EntryBoard()));
          },
        ),),
      ],
    ),);
  }


  Widget buildEvulation(){
    return  Center(child: ListView(),);
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

class EntryBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("EntryBoard"),
          ),
          body: ListView(
            children: <Widget>[
              Card(
                child: ListTile(
                  title: Text("Bestandsaufnahme"),
                  tileColor: Colors.blueGrey,
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Wie fühlst du dich heute?"),
                  trailing: ratingBar()
                ),


              ),
              Card(
                child: ListTile(title: Text("Warst du heute produktiv?"),
                trailing: ratingBar(),),
              ),
              Card(
                child: ListTile(title: Text("Was hast du heute gemacht?"),),
              ),

              //TODO: GENERATE ACTIVITIES


              Card(child: ListTile(title: Text("Aktivität hinzufügen"),),)
            ],
          ),
        ),
      ),
    );
  }

  //TODO: give purpose via Args or sth
  Widget ratingBar(){
    return RatingBar.builder(
      initialRating: 5,
      itemCount: 5,
      itemBuilder: (context, index){
        switch (index) {
          case 0:
            return Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 2:
            return Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 3:
            return Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 4:
            return Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
        }
      },
      onRatingUpdate: (rating){
        print(rating);
      },
    );
  }
}

