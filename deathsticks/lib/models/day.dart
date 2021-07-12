import 'package:deathsticks/models/event.dart';

class Day {

  final int month;
  final int day;
  final int year;
  final int dailyNadir;
  List<Event> events;

  Day({ this.month, this.day, this.year, this.events, this.dailyNadir });

  String toDayRef() {
    return '${this.month}-${this.day}-${this.year}';
  }

}