import 'package:bezier_chart/bezier_chart.dart';
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

  List<Day> _historyFromCollection(QuerySnapshot snapshot) {
    print('fetching');
    List<Day> history = [];
    // for each doc, create Day
    snapshot.docs.forEach((QueryDocumentSnapshot doc) {
      //create day, and empty list
      var dateArray = doc.id.split("-");
      Day pastDay = Day(
          month: int.parse(dateArray[0]),
          day: int.parse(dateArray[1]),
          year: int.parse(dateArray[2]));
      List<Event> pastDayEvents = [];
      // for each field, create Event
      doc.data().forEach((key, value) {
        // create Event (if active), push to list
        if (value == true) {
          Event e = Event(timeOfEvent: key, isActive: value);
          pastDayEvents.add(e);
        }
      });
      pastDay.events = pastDayEvents;
      history.add(pastDay);
    });
    return history;
  }

  List<DataPoint<dynamic>> _dataPointsFromHistory(List<Day> history) {
      List<DataPoint<dynamic>> points = [];
      history.forEach((day) {
        DateTime dayDate = DateTime(day.year, day.month, day.day);
        int dayCount = day.events.length;
        if (DateTime.now().difference(dayDate).inDays != 0) {
          DataPoint<DateTime> point =
              DataPoint(value: dayCount.toDouble(), xAxis: dayDate);
          points.add(point);
        }
      });
      return points;
    }

  Future<List<DataPoint<dynamic>>> getDataPoints() async {
    try {
      QuerySnapshot daysSnapshot =
          await dstxCollection.doc(uid).collection('days').get();
      return _dataPointsFromHistory(_historyFromCollection(daysSnapshot));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // more elegant?

  



}
