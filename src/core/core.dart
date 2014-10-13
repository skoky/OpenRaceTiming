library core;

import 'package:event_commander/event_commander.dart';
import '../device/testdevice.dart';
import '../calculator/testcalculator.dart';

EventBus event_bus;

class MyEvent extends Event {
  String selector;
  String jsonData;
  MyEvent(this.selector,this.jsonData);
}

class Core {

Core() {
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