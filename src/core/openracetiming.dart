library core;

import 'package:event_commander/event_commander.dart';
import '../device/testdevice.dart';
import '../calculator/testcalculator.dart';

EventBus event_bus;

class MyEvent extends Event {
  String description;
  MyEvent(this.description);
}

void main() {
  new OpenRaceTiming();
}

class OpenRaceTiming {

OpenRaceTiming() {
  print("start");
  event_bus = new EventBus();
  
  TestCalculator test_calculator = new TestCalculator(event_bus);
  TestDevice test_device = new TestDevice(event_bus);
  
  print("stop");
}

EventBus getBus() {
  return event_bus;
}

}