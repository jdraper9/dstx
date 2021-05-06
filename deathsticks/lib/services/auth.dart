import 'package:deathsticks/models/person.dart';
import 'package:deathsticks/services/db.dart';
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
    return _auth
        .authStateChanges()
        // .map((User user) => _person(user));
        .map(_person);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return _person(userCredential.user);
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
  Future signInWithUsernameAndPassword(
      String username, String password) async {
    try {
      String email = username + '@james.draper.316.com';
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
          return _person(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'User not found';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect password';
      }
    } catch (e) {
      print(e);
    }
  }

  // register w/ username + password
  Future registerWithUsernameAndPassword(
      String username, String password) async {
    try {
      String email = username + '@james.draper.316.com';
      UserCredential userCredential = await
        _auth.createUserWithEmailAndPassword(email: email, password: password);
      // determine what happens when person is created
      await DatabaseService(uid: userCredential.user.uid).registerPerson();
      return _person(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Weak password (<6 characters)';
      } else if (e.code == 'email-already-in-use') {
        return 'Account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
  }

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
