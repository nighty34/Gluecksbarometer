import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gluecks_barometer/src/model/mood.dart';

/// A bar with five different possibilities for mood, according to the
/// [Mood] enum.
// ignore: must_be_immutable
class MoodRatingBar extends StatelessWidget {

  Function(Mood) _onChange;

  MoodRatingBar(Function(Mood) onChange) {
    _onChange = onChange;
  }

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 5,
      itemCount: 5,
      itemBuilder: (context, index) => getIcon(index),
      onRatingUpdate: (rating) {
        _onChange(Mood.values[rating.floor() - 1]);
      },
    );
  }

  /// Get the icon for a specified [rating]
  static Icon getIcon(int rating) {
    switch (rating) {
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
      default:
        return null;
      }
  }
}
