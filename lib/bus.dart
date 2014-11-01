import 'package:event_commander/event_commander.dart';

class MyEvent extends Event {
  String selector;
  String jsonData;

  MyEvent(this.selector, this.jsonData);
}
