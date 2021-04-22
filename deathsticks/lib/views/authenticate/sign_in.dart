import 'package:deathsticks/constants/colors.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        backgroundColor: mainBlueDarker,
        elevation: 0.0,
        title: Text(
          'Sign in to Deathsticks',
          style: (Theme.of(context).textTheme.headline5.apply(color: mainRed)),
          ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          child: Text(
            'Sign in anon', 
            style: Theme.of(context).textTheme.button.apply(color: mainRed),
          ),
          style: ElevatedButton.styleFrom(
            primary: mainBlueDarker,
            onPrimary: mainBlueDarkest,
          ),
          onPressed: () async {
            
          },
        )
      ),
    );
  }
}