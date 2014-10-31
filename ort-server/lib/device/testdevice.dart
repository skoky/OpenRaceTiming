import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:event_commander/event_commander.dart';
import 'package:OpenRaceTimingServer/bus.dart';

class TestDevice {

  int passingNumber = 0;
  Random ids = new Random();
  Random delays = new Random();
  EventBus event_bus;

  postEvent() {
    passingNumber++;
    var now = new DateTime.now().toString();
    var id  = ids.nextInt(10);
    String json = '{"passingId":"$id","passingNumber":"$passingNumber","time":"$now"}';  
    event_bus.signal(new MyEvent('device/TestDevice/Passings', json));

  }

  TestDevice(this.event_bus) {
    new Timer.periodic(const Duration(seconds:5), (t) {
        postEvent();
        });
  }
}

