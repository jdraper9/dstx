import 'package:deathsticks/constants/colors.dart';
import 'package:deathsticks/constants/shared.dart';
import 'package:deathsticks/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  // declare input function
  final Function toggleView;
  // accept param, set it to toggleView
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String username = '';
  String password = '';
  String confirmPassword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        backgroundColor: mainBlueDarker,
        elevation: .5,
        title: Text(
          'Get Started',
          style: (Theme.of(context).textTheme.headline5.apply(color: mainRed)),
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person, color: mainRed),
            label: Text('login',
                style: (Theme.of(context)
                    .textTheme
                    .subtitle2
                    .apply(color: mainRedLighter))),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
              child: Container(
                height: 420.0,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              // SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Username'),
                validator: (val) => val.isEmpty ? 'Enter a username' : null,
                style: TextStyle(color: secondaryRed),
                onChanged: (val) {
                  setState(() => username = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.isEmpty ? 'Enter a password' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                }),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Confirm password'),
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Confirm your password';
                  } else if (val != password) {
                    return 'Confirm password doesn\'t match';
                  }
                  return null;
                },
                obscureText: true,
                onChanged: (val) {
                  setState(() => confirmPassword = val);
                }),
              SizedBox(height: 20.0),
              Text(error),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainRedLighter)),
                child: Text(
                  'Register',
                  style: (Theme.of(context).textTheme.bodyText1)
                      .apply(color: mainBlueDarker),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _auth.registerWithUsernameAndPassword(
                        username, password);
                    if (result is String) {
                      setState(() => error = result);
                    }
                  }
                },
              ),
              SizedBox(height: 12.0,),
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
      ),
    );
  }
}
