import 'package:deathsticks/models/person.dart';
import 'package:deathsticks/services/db.dart';
import 'package:deathsticks/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Button extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    final person = Provider.of<Person>(context);
    final DatabaseService db = DatabaseService(uid: person.uid);

    return Container(
      margin: new EdgeInsets.only(left: 25.0),
      child: FloatingActionButton(
        onPressed: () {
          dynamic res = db.increment();
          print(res);
        },
        child: Icon(Icons.add),
        backgroundColor: mainBlueDarker,
        elevation: 2.0,
      ),
    );
  }
}
