import 'package:deathsticks/constants/colors.dart';
import 'package:deathsticks/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        backgroundColor: mainBlueDarker,
        elevation: 0.0,
        title: Text(
          'Create an account',
          style: (Theme.of(context).textTheme.headline5.apply(color: mainRed)),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              style: TextStyle(color: secondaryRed),
              onChanged: (val) {
                setState(() => username = val);
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                }),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(mainRedLighter)),
              // color: mainRedLighter,
              child: Text(
                'Register',
                style: (Theme.of(context).textTheme.bodyText1)
                    .apply(color: mainBlueDarker),
              ),
              onPressed: () async {
                print(username);
                print(password);
              },
            ),
          ]),
        ),

        // child: ElevatedButton(
        //   child: Text(
        //     'Sign in anon',
        //     style: Theme.of(context).textTheme.button.apply(color: mainRed),
        //   ),
        //   style: ElevatedButton.styleFrom(
        //     primary: mainBlueDarker,
        //     onPrimary: mainBlueDarkest,
        //   ),
        //   onPressed: () async {
        //     dynamic result = await _auth.signInAnon();
        //     print(result);
        //     if (result == null) {
        //       print('error signing in');
        //     } else {
        //       print('signed in');
        //       print(result.hashCode);
        //     }
        //   },
        // )
      ),
    );
  }
}
