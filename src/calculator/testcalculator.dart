library calculator;

import 'package:event_commander/event_commander.dart';
import '../core/core.dart';

class TestCalculator {

  TestCalculator(EventBus event_bus) {
    event_bus.on(MyEvent, (MyEvent event) => print("Event received:"+event.selector));
  }
}