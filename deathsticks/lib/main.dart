import 'package:deathsticks/constants/theme.dart';
import 'package:deathsticks/views/auth_switch.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DeathsticksApp());
}

class DeathsticksApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deathsticks',
      theme: mainTextScale,
      home: AuthSwitch()
    );
  }
}
