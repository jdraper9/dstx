import 'package:deathsticks/constants/colors.dart';
import 'package:deathsticks/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        title: Text(
          'Deathsticks',
          style: (Theme.of(context).textTheme.headline5.apply(color: mainRed)),
        ), 
        backgroundColor: mainBlueDarker,
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person, color: mainRed),
            label: Text('logout', style: (Theme.of(context).textTheme.subtitle2.apply(color: mainRedLighter)),),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      )
    );
  }
}