import 'package:deathsticks/models/person.dart';
import 'package:deathsticks/services/db.dart';
import 'package:deathsticks/shared/constants/colors.dart';
import 'package:deathsticks/services/auth.dart';
import 'package:deathsticks/views/home/chart/chart_container.dart';
import 'package:deathsticks/views/home/increment_button/button_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  

  @override
  Widget build(BuildContext context) {
    final person = Provider.of<Person>(context);
    final DatabaseService db = DatabaseService(uid: person.uid);
    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        toolbarHeight: 60.0,
        leading: Image(
          image: AssetImage('lib/assets/images/no-smoking.png')
        ),
        title: Text(
          'Deathsticks',
          style: (Theme.of(context).textTheme.headline5.apply(color: mainRed)),
        ), 
        centerTitle: false,
        titleSpacing: 0.0,
        backgroundColor: mainBlueDarker,
        elevation: 2.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person, color: mainRed),
            label: Text('logout', style: (Theme.of(context).textTheme.subtitle2.apply(color: mainRedLighter)),),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40.0),
            Text('${DateFormat('MMMM, d').format(DateTime.now())}', style: (Theme.of(context).textTheme.subtitle2.apply(color: lightGray))), 
            SizedBox(height: 10.0),
            Text('Daily Tracker', style: (Theme.of(context).textTheme.subtitle2.apply(color: darkGray))),
            SizedBox(height: 60.0),
            ChartContainer(db: db),
            SizedBox(height: 50.0),
            ButtonContainer(),
          ],
        ),
      ),
    );
  }
}