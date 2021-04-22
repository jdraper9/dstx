import 'package:deathsticks/views/colors/colors.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xE5F0FE),
      appBar: AppBar(
        backgroundColor: mainBlue,
      ),
    );
  }
}