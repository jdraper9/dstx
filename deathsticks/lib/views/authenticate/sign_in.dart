import 'package:deathsticks/constants/colors.dart';
import 'package:deathsticks/constants/shared.dart';
import 'package:deathsticks/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String username = '';
  String password = '';
  String error = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        backgroundColor: mainBlueDarker,
        elevation: .7,
        title: Text(
          'Deathsticks',
          style: (Theme.of(context).textTheme.headline5.apply(color: mainRed)),
        ),
        actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person, color: mainRed),
              label: Text('register', style: (Theme.of(context).textTheme.subtitle2.apply(color: mainRedLighter))),
              onPressed: () {
                widget.toggleView();
              },
            ),
          ],
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
              child: Container(
                height: 400.0,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              SizedBox(height: 60.0),
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
                },
              ),
              SizedBox(height: 20.0),
              Text(error),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(mainRedLighter) ),
                child: Text(
                  'Log In',
                  style: (Theme.of(context).textTheme.bodyText1)
                      .apply(color: mainBlueDarker),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _auth.signInWithUsernameAndPassword(username, password); 
                    if (result is String) {
                      setState(() => error = result);
                    }
                  }
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
      ),
    );
  }
}
