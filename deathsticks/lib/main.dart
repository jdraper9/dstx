import 'package:deathsticks/shared/components/broke.dart';
import 'package:deathsticks/shared/components/loading.dart';
import 'package:deathsticks/shared/constants/theme.dart';
import 'package:deathsticks/models/person.dart';
import 'package:deathsticks/services/auth.dart';
import 'package:deathsticks/views/auth_switch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DeathsticksApp());
}

class DeathsticksApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return StreamProvider<Person>.value(
              initialData: null,
              value: AuthService().person,
              child: MaterialApp(
                  title: 'Deathsticks',
                  theme: mainTextScale,
                  home: Broken()),
            );
          }

          // MAIN
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider<Person>.value(
              initialData: null,
              // get person, returns authStateChanges mapped to Person
              value: AuthService().person,
              child: MaterialApp(
                  title: 'Deathsticks',
                  theme: mainTextScale,
                  home: AuthSwitch()),
            );
          }

          // else
          return Loading();
        });
  }
}
