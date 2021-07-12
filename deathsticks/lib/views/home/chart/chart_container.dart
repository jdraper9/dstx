import 'package:deathsticks/models/event.dart';
import 'package:deathsticks/models/person.dart';
import 'package:deathsticks/services/db.dart';
import 'package:deathsticks/shared/constants/colors.dart';
import 'package:deathsticks/views/home/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartContainer extends StatefulWidget {
  final DatabaseService db;
  ChartContainer({this.db});

  @override
  _ChartContainerState createState() => _ChartContainerState();
}

class _ChartContainerState extends State<ChartContainer> {
  Stream<List<Event>> dailyEventStream;

  @override
  void initState() {
    super.initState();
    dailyEventStream = widget.db.eventsForToday;
  }

  Widget build(BuildContext context) {
    final person = Provider.of<Person>(context);

    person.reloadTrigger.listen((event) {
      setState(() {
        dailyEventStream = widget.db.eventsForToday;
      });
    });

    return MultiProvider(
      providers: [
        StreamProvider<List<Event>>.value(
        initialData: [],
        value: dailyEventStream
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
            child: Chart(db: widget.db)),
    );
  }
}
