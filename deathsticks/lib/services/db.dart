import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference dstxCollection = FirebaseFirestore.instance.collection('data');

  Future updatePerson(int count) async {
    return await dstxCollection.doc(uid).set({
      'count': count,
    });
  }

}