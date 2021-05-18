import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deathsticks/models/day.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference dstxCollection = FirebaseFirestore.instance.collection('data');

  Day _today(DateTime nowDateTime) {
    return nowDateTime != null ? Day(month: nowDateTime.month, day: nowDateTime.day, year: nowDateTime.year) : null;
  }

  // register
  Future registerPerson() async {
    var today = _today(DateTime.now());
    return dstxCollection.doc(uid).collection('days').doc('${today.month}-${today.day}-${today.year}').set({
      'welcome': true
    })
    .then((val) => print ("Registered"))
    .catchError((err) => print("Fail to register: $err"));
  }

  // increment count
  Future increment() async {
    var today = _today(DateTime.now());
    var nowTimestamp = Timestamp.now().seconds.toString();
    print(nowTimestamp);
    return await dstxCollection.doc(uid).collection('days').doc('${today.month}-${today.day}-${today.year}').set({'$nowTimestamp': true}, SetOptions(merge: true));
  }

}