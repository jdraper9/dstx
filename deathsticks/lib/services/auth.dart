import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  
  // sign in w/ username + password
  
  // register w/ username + password

  // sign out
}