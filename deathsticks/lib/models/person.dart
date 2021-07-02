import 'dart:async';

class Person {

  final String uid;
  final Stream<bool> reloadTrigger;
  final StreamController<bool> reloadTriggerController;

  Person({ this.uid, this.reloadTrigger, this.reloadTriggerController });

}