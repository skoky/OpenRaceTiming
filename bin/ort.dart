import 'dart:io';
import 'dart:async';
import 'package:http_server/http_server.dart';
import 'package:event_commander/event_commander.dart';

import 'device/testdevice.dart';
import 'calculator/testcalculator.dart';

EventBus event_bus=new EventBus();

class MyEvent extends Event {
  String selector;
  String jsonData;
  MyEvent(this.selector,this.jsonData);
}

void main() {
  print("start main");
  
  var staticFiles = new VirtualDirectory('.')
    ..allowDirectoryListing = true;

  runZoned(() {
    HttpServer.bind('0.0.0.0', 7777).then((server) {
      print('Server running');
      server.listen(staticFiles.serveRequest);
    });
  },
  onError: (e, stackTrace) => print('Oh noes! $e $stackTrace'));
  
  TestCalculator test_calculator = new TestCalculator(event_bus);
  TestDevice test_device = new TestDevice(event_bus);

  event_bus.on(MyEvent, (MyEvent event) =>
  print("TODO send to WS to client:"+event.selector));
  // updateStatus("Event received:"+event.selector+" data:"+event.jsonData));

  print("stop main");
}