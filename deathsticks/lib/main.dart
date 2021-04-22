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
      // theme: new ThemeData(scaffoldBackgroundColor: const Color(0xE5F0FE)),
      home: AuthSwitch()
    );
  }
}
