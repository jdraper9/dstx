import 'package:cloud_firestore/cloud_firestore.dart';

class Event {

  final String timeOfEvent;
  final bool isActive;

  Event({ this.timeOfEvent, this.isActive });

}