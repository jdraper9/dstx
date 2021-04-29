import 'package:deathsticks/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Person _person(User user) {
    //modify user attributes from firebase here
    //print(user);
    return user != null ? Person(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Person> get person {
    return _auth.authStateChanges()
      // .map((User user) => _person(user));
      .map(_person);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;
      return _person(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }

  // sign in w/ username + password

  // register w/ username + password

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
