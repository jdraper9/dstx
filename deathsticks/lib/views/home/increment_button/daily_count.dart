import 'package:flutter/material.dart';

class DailyCount extends StatefulWidget {
  @override
  _DailyCountState createState() => _DailyCountState();
}

class _DailyCountState extends State<DailyCount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(left: 35.0),
      child: Text('Count for the day: 24'),
    );
  }
}