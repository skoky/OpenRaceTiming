library device;

import 'package:event_commander/event_commander.dart';
import '../ort.dart';
import 'dart:async';


class TestDevice {

  int passingNumber = 0;
  

  postEvent() {
    passingNumber++;
    var now = new DateTime.now().toString();
    String json = '{"passingId":"1","passingNumber":"$passingNumber","time","$now"}';  
    event_bus.signal(new MyEvent('device/TestDevice/Passings', json));
    // doSomething() will be called
  }

  TestDevice(EventBus event_bus) {
    
    var stream = new Stream.periodic(const Duration(seconds: 1), (count) {
      print("Event fired");
       postEvent();
     });
    stream.listen((result) {
       print("Result");
     });
  }
}

