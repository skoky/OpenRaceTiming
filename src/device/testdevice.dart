library device;

import 'package:event_commander/event_commander.dart';
import '../core/openracetiming.dart';

class TestDevice {

  TestDevice(EventBus event_bus) {
    event_bus.signal(new MyEvent('Something happened!')); // doSomething() will be called
  }
}