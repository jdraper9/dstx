import 'package:deathsticks/models/event.dart';
import 'package:deathsticks/models/person.dart';
import 'package:deathsticks/services/db.dart';
import 'package:deathsticks/shared/constants/colors.dart';
import 'package:deathsticks/views/home/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final person = Provider.of<Person>(context);
    final DatabaseService db = DatabaseService(uid: person.uid);

    return MultiProvider(
      providers: [
        StreamProvider<List<Event>>.value(
        initialData: [],
        value: db.eventsForToday,
        
      ),
        // StreamProvider<String>.value(
        //   initialData: 'true',
        //   value: db.reloadStream,
        // )
      ],
      child: Container(
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: mainRedLighter, width: .3),
            ),
            child: Chart(db: db)),
    );
  }
}
