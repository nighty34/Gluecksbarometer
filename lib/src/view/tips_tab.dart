import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gluecks_barometer/src/controller/tips_controller.dart';
import 'package:gluecks_barometer/src/model/quote.dart';
import 'package:provider/provider.dart';

class TipsTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TipsController controller = Provider.of<TipsController>(context);
    return Center(
      child: Column(
        children: <Widget>[
          _buildSectionTitle("Heutiges Zitat"),
          _buildQuote(controller, controller.todaysQuote),
          _buildSectionTitle("Gespeicherte Zitate"),
          ListView(
            shrinkWrap: true,
            children: List.of(controller.savedQuotes.map((q) => _buildQuote(controller, q))),
          )
        ],
      ),
    );
  }

  Widget _buildQuote(TipsController controller, Quote quote) {
    return Card(
      child: Column(
        children: [
          Container(padding: EdgeInsets.all(10), child: Text(quote.text, style: TextStyle(fontSize: 16))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(padding: EdgeInsets.all(10), child: Text(quote.author, style: TextStyle(color: Colors.grey))),
              IconButton(icon: Icon(quote.saved ? Icons.favorite : Icons.favorite_border), onPressed: () {
                quote.saved = !quote.saved;
                controller.updateQuote(quote);
              })
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
