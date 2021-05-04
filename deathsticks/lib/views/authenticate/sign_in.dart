import 'package:deathsticks/shared/components/loading.dart';
import 'package:deathsticks/shared/constants/colors.dart';
import 'package:deathsticks/shared/styles.dart';
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
  bool loading = false;

  String username = '';
  String password = '';
  String error = '';
  

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        toolbarHeight: 60.0,
        backgroundColor: mainBlueDarker,
        elevation: .2,
        leading: Image(
          image: AssetImage('lib/assets/images/no-smoking.png')
        ),
        title: Text(
          'Deathsticks',
          style: (Theme.of(context).textTheme.headline5.apply(color: mainRed)),
        ),
        centerTitle: false,
        titleSpacing: 0.0,
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
                height: 430.0,
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
                style: TextStyle(color: secondaryRed),
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
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithUsernameAndPassword(username, password); 
                    if (result is String) {
                      setState(() {
                        error = result;
                        loading = false;
                      });
                    }
                  }
                },
              ),

            ]),
          ),
        ),
      ),
    );
  }
}
