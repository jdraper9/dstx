import 'package:deathsticks/models/event.dart';
import 'package:deathsticks/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyCount extends StatefulWidget {
  @override
  _DailyCountState createState() => _DailyCountState();
}

class _DailyCountState extends State<DailyCount> {
  @override
  Widget build(BuildContext context) {

    int dailyCount = 0;
    final dailyEvents = Provider.of<List<Event>>(context) ?? [];
    dailyEvents.forEach((Event e) {
      if (e.isActive) {
        dailyCount += 1;
      }
    });

    return Container(
      margin: new EdgeInsets.only(left: 35.0),
      // child: Text('Count for the day: 24'),
      child: RichText(
        text: TextSpan(
          style: (Theme.of(context).textTheme.bodyText2),
          children: <TextSpan>[
            TextSpan(
              text: "Count for the day: ",
            ),
            TextSpan(
              // want this to be length of daily
              text: " $dailyCount",
              style: (Theme.of(context).textTheme.subtitle1.apply(color: mainRed)),
            ),
          ],
        ),
      ),
    );
  }
}

// style: (Theme.of(context).textTheme.headline5.apply(color: mainRed))