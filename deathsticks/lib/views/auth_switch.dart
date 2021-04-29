import 'package:deathsticks/models/person.dart';
import 'package:deathsticks/views/authenticate/authenticate.dart';
import 'package:deathsticks/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final person = Provider.of<Person>(context);
    if (person == null) {
      return Authenticate();
    } else  {
      return Home();
    }
  }
}