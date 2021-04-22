import 'package:deathsticks/views/authenticate/authenticate.dart';
import 'package:deathsticks/views/home/home.dart';
import 'package:flutter/material.dart';

class AuthSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // return either or Home or Authenticate
    return Authenticate();
  }
}