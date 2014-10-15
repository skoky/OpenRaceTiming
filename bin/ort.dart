import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http_server/http_server.dart' show VirtualDirectory;
import 'package:event_commander/event_commander.dart';

import 'device/testdevice.dart';
import 'calculator/testcalculator.dart';

EventBus event_bus=new EventBus();

class MyEvent extends Event {
  String selector;
  String jsonData;
  MyEvent(this.selector,this.jsonData);
}

handleMsg(msg) {
  print('Message received: $msg');
}

WebSocket webSocket;

void main() {
  print("start main");
  
  var staticFiles = new VirtualDirectory('.')
    ..allowDirectoryListing = true;

  runZoned(() {
    HttpServer.bind('127.0.0.1', 4040).then((server) {
      server.listen((HttpRequest req) {
        if (req.uri.path == '/ws') {
          // Upgrade a HttpRequest to a WebSocket connection.
          WebSocketTransformer.upgrade(req).then((socket) {
             socket.listen(handleMsg);
             webSocket=socket;
          });
        }
      });
    });
  },
  onError: (e, stackTrace) => print('Oh noes! $e $stackTrace'));
  
  TestCalculator test_calculator = new TestCalculator(event_bus);
  TestDevice test_device = new TestDevice(event_bus);

  event_bus.on(MyEvent, (MyEvent event) =>  
      updateRecords(event));
  
  print("stop main");
}

void updateRecords(MyEvent event) {
  if (event.selector.startsWith("calculator/TestCalculator/update"))
    print("TODO propagate event to GUI:"+event.jsonData);
  //TODO send data to WS
}
