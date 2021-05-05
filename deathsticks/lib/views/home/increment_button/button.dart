import 'package:deathsticks/shared/constants/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(left: 25.0),
      child: FloatingActionButton(
        onPressed: () {
          print("smoked");
        },
        child: Icon(Icons.add),
        backgroundColor: mainBlueDarker,
        elevation: 2.0,
      ),
    );
  }
}