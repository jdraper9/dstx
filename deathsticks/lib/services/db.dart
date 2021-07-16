import 'dart:async';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deathsticks/models/day.dart';
import 'package:deathsticks/models/event.dart';
import 'package:deathsticks/models/person.dart';

class DatabaseService {
  final String uid;
  Day today = Day(
      month: DateTime.now().month,
      day: DateTime.now().day,
      year: DateTime.now().year);
  final Day tmrw = Day(
      month: DateTime.now().add(Duration(days: 1)).month,
      day: DateTime.now().add(Duration(days: 1)).day,
      year: DateTime.now().add(Duration(days: 1)).year);

  Day get getToday {
    return today;
  }

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference dstxCollection =
      FirebaseFirestore.instance.collection('data');

  // register
  Future registerPerson(String username) async {
    var nowTimestamp = Timestamp.now().seconds.toString();
    await dstxCollection.doc(uid).set({'username': username});
    return dstxCollection
        .doc(uid)
        .collection('days')
        .doc(today.toDayRef())
        .set({'list': {'$nowTimestamp': false}, 'dailyNadir': 1})
        .catchError((err) => print("Fail to register: $err"));
  }

  int _nadirFromSnapshot(DocumentSnapshot snapshot) {
    return snapshot.data()['nadir'];
  }

  // get Nadir Stream
  Stream<int> get nadir {
    return dstxCollection.doc(uid).snapshots().map(_nadirFromSnapshot);
  }

  // get dailyNadir for today
  Future<int> getTodayNadir() async {
    Day updatedToday = Day(
        month: DateTime.now().month,
        day: DateTime.now().day,
        year: DateTime.now().year);
    return await dstxCollection.doc(uid).collection('days')
    .doc(updatedToday.toDayRef()).get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.data()['dailyNadir'];
      } else {
        return 1;
      }
    });
  }

  // get dailyNadir for day
  Future<int> getNadir(Day day) async {
    return await dstxCollection.doc(uid).collection('days')
    .doc(day.toDayRef()).get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.data()['dailyNadir'];
      } else {
        return 1;
      }
    });
  }

  // get today's count async
  Future<int> getDailyCount(Day day) async {
    return await dstxCollection.doc(uid).collection('days')
      .doc(day.toDayRef())
      .get()
      .then((DocumentSnapshot documentSnapshot) {
        int x = 0;
        if (documentSnapshot.data() != null && documentSnapshot.data().isNotEmpty) {
          documentSnapshot.data()['list'].forEach((key, value) {
          if (value) {
            x += 1;
          }
        });
        } else {
          print('hm');
        }
        return x;
      });
  }

  // increment count
  Future increment(Person person) async {
    Day updatedToday = Day(
        month: DateTime.now().month,
        day: DateTime.now().day,
        year: DateTime.now().year
      );

    if (today.month < updatedToday.month || today.day < updatedToday.day || today.year < updatedToday.year) {
        // send trigger to graph component to reload start and end dates, and datapoints
      person.reloadTriggerController.add(true);
    }
    var nowTimestamp = Timestamp.now().seconds.toString();

    int n = await getTodayNadir();
    int x = await getDailyCount(updatedToday) + 1;
    if (n == 0 || n == null) {
      QuerySnapshot daysSnapshot =
          await dstxCollection.doc(uid).collection('days').get();
      List<Day> days = _historyFromCollection(daysSnapshot);
      int latestPastTimestamp = 0;
      Day latestPastDay;
      days.forEach((day) {
        DateTime dayDate = DateTime.utc(day.year, day.month, day.day);
        if (dayDate.millisecondsSinceEpoch > latestPastTimestamp && day.toDayRef() != updatedToday.toDayRef()) {
          latestPastTimestamp = dayDate.millisecondsSinceEpoch;
          latestPastDay = day; 
        }
      });
      if (latestPastDay != null) {
        int latestPastDayN = await getNadir(latestPastDay);
        if (latestPastDayN != null && latestPastDayN != 0) {
          await dstxCollection.doc(uid).collection('days').doc(updatedToday.toDayRef())
          .set({'dailyNadir': latestPastDayN}, SetOptions(merge: true));
        }
      }
    } else if (x > n) {
      
      await dstxCollection.doc(uid).collection('days').doc(updatedToday.toDayRef())
      .set({'dailyNadir': x}, SetOptions(merge: true));
    }
    return await dstxCollection
        .doc(uid)
        .collection('days')
        .doc(updatedToday.toDayRef())
        .set({'list': {'$nowTimestamp': true}}, SetOptions(merge: true));
  }

  // get Day's list of Events as stream
  List<Event> _listOfEventsFromSnapshot(DocumentSnapshot snapshot) {
    List<Event> list = [];
    if (snapshot.exists) {
      snapshot.data()['list'].forEach((key, value) {
        list.add(Event(timeOfEvent: key, isActive: value));
      });
    }
    return list;
  }

  Stream<List<Event>> get eventsForToday {
    // var 
    today = Day(
      month: DateTime.now().month,
      day: DateTime.now().day,
      year: DateTime.now().year);
    
    return dstxCollection
        .doc(uid)
        .collection('days')
        .doc(today.toDayRef())
        .snapshots()
        .map(_listOfEventsFromSnapshot);
  }
  
  int _dailyNadirFromSnapshot(DocumentSnapshot snapshot) {
    int dailyN = 1;
    if (snapshot.exists) {
      dailyN = snapshot.data()['dailyNadir'];
    }
    return dailyN;
  }

  Stream<int> get dailyNadir {
    today = Day(
      month: DateTime.now().month,
      day: DateTime.now().day,
      year: DateTime.now().year);

    return dstxCollection.doc(uid).collection('days').doc(today.toDayRef()).snapshots().map(_dailyNadirFromSnapshot);
  }

  // get History (Person's collection('days')) 
  // List of Days, which have Lists of Events. Map Events to
  //   daily count, find Nadir, use daily count and Nadir to map daily Events list to Score
  // just need list of (date, score)
  // get ('days') collection, each id within becomes Day, each Day has Events
  // from each day, get score
  Future<QuerySnapshot> getHistory() async {
    return await dstxCollection.doc(uid).collection('days').get();
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

  List<Day> _historyFromCollection(QuerySnapshot snapshot) {
    List<Day> history = [];
    // for each doc, create Day
    snapshot.docs.forEach((QueryDocumentSnapshot doc) {
      //create day, and empty list
      var dateArray = doc.id.split("-");
      var dailyNadir = doc.data()['dailyNadir'];
      Day pastDay = Day(
          month: int.parse(dateArray[0]),
          day: int.parse(dateArray[1]),
          year: int.parse(dateArray[2]),
          dailyNadir: dailyNadir,
      );

      
      List<Event> pastDayEvents = [];
      // for each field, create Event
      doc.data()['list'].forEach((key, value) {
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
        int dailyNadir = day.dailyNadir;
        double y_d = (( -dayCount / dailyNadir ) + 1) * 100;
        if (DateTime.now().difference(dayDate).inDays != 0) {
          DataPoint<DateTime> point = DataPoint(value: y_d.roundToDouble(), xAxis: dayDate);
          if (point.value == 0.0) {
            point = DataPoint(value: 0.01, xAxis: dayDate);
          }
          points.add(point);
        }
      });
      return points;
    }

}
