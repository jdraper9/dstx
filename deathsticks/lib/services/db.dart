import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deathsticks/models/day.dart';
import 'package:deathsticks/models/event.dart';

class DatabaseService {
  final String uid;
  final Day today = Day(
      month: DateTime.now().month,
      day: DateTime.now().day,
      year: DateTime.now().year);

  Day get getToday {
    return today;
  }

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference dstxCollection =
      FirebaseFirestore.instance.collection('data');

  // register
  Future registerPerson() async {
    var nowTimestamp = Timestamp.now().seconds.toString();
    return dstxCollection
        .doc(uid)
        .collection('days')
        .doc(today.toDayRef())
        .set({'$nowTimestamp': false})
        .then((val) => print("Registered"))
        .catchError((err) => print("Fail to register: $err"));
  }

  // increment count
  Future increment() async {
    Day updatedToday = Day(
        month: DateTime.now().month,
        day: DateTime.now().day,
        year: DateTime.now().year);
    var nowTimestamp = Timestamp.now().seconds.toString();
    return await dstxCollection
        .doc(uid)
        .collection('days')
        .doc(updatedToday.toDayRef())
        .set({'$nowTimestamp': true}, SetOptions(merge: true));
  }

  // get Day's list of Events as stream
  List<Event> _listOfEventsFromSnapshot(DocumentSnapshot snapshot) {
    List<Event> list = [];
    if (snapshot.exists) {
      snapshot.data().forEach((key, value) {
        list.add(Event(timeOfEvent: key, isActive: value));
      });
    }
    return list;
  }

  Stream<List<Event>> get eventsForToday {
    print(today.toDayRef());
    print(uid);
    return dstxCollection
        .doc(uid)
        .collection('days')
        .doc(today.toDayRef())
        .snapshots()
        .map(_listOfEventsFromSnapshot);
  }

  // get History (Person's collection('days')) \
  // List of Days, which have Lists of Events. Map Events to
  //   daily count, find Nadir, use daily count and Nadir to map daily Events list to Score

  // just need list of (date, score)
  // get ('days') collection, each id within becomes Day, each Day has Events
  // from each day, get score
  Future<QuerySnapshot> getHistory() async {
    return await dstxCollection.doc(uid).collection('days').get();
  }



}
