import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference dstxCollection = FirebaseFirestore.instance.collection('data');

  // register
  Future registerPerson() async {
    return dstxCollection.doc(uid).collection('days').doc('5-5-2021').set({
      'welcome': true
    })
    .then((val) => print ("Registered"))
    .catchError((err) => print("Fail to register: $err"));
  }

  // increment count 
  Future increment() async {
    var now = Timestamp.now().seconds.toString();
    print(now);
    return await dstxCollection.doc(uid).collection('days').doc('5-5-2021').set({'$now': true}, SetOptions(merge: true));
  }

}