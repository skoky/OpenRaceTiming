library device;

import 'package:event_commander/event_commander.dart';
import '../ort.dart';
import 'dart:async';
import 'dart:math';

class TestDevice {

  int passingNumber = 0;
  Random ids = new Random();
  Random delays = new Random();
 
  postEvent() {
    passingNumber++;
    var now = new DateTime.now().toString();
    var id  = ids.nextInt(10);
    String json = '{"passingId":"$id","passingNumber":"$passingNumber","time":"$now"}';  
    event_bus.signal(new MyEvent('device/TestDevice/Passings', json));

  }

  TestDevice(EventBus event_bus) {
    new Timer.periodic(const Duration(seconds:5), (t) {
        postEvent();
        });
  }
}

