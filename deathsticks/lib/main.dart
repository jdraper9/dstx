import 'package:deathsticks/constants/theme.dart';
import 'package:deathsticks/views/auth_switch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DeathsticksApp());
}

// notes
// 
// 
// on vid 6
// 
// 

class DeathsticksApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            title: 'Deathsticks error',
            theme: mainTextScale,
            home: AuthSwitch()
          );
        }

        // complete
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Deathsticks',
            theme: mainTextScale,
            home: AuthSwitch()
          );
        }

        // else
        return MaterialApp(
          title: 'Deathsticks loading',
          theme: mainTextScale,
          home: AuthSwitch()
        );
      }
    );

    ///
    ///
    // return MaterialApp(
    //   title: 'Deathsticks',
    //   theme: mainTextScale,
    //   home: AuthSwitch()
    // );
    ////
    ///
  }
}
