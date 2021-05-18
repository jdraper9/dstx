import 'package:deathsticks/models/event.dart';
import 'package:deathsticks/models/person.dart';
import 'package:deathsticks/services/db.dart';
import 'package:deathsticks/shared/constants/colors.dart';
import 'package:deathsticks/views/home/increment_button/button.dart';
import 'package:deathsticks/views/home/increment_button/daily_count.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final person = Provider.of<Person>(context);
    final DatabaseService db = DatabaseService(uid: person.uid);

    return StreamProvider<List<Event>>.value(
      initialData: null,
      value: db.eventsForDay,
      child: Container(
        height: 93.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(60),
          border: Border.all(color: mainRedLighter, width: .3),
        ),
        child: Row(
          children: [
            Button(),
            DailyCount(),
          ],
        ),
      ),
    );
  }
}
