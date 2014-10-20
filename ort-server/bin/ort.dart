import 'dart:io';
import 'dart:async';
import 'package:http_server/http_server.dart' show VirtualDirectory;
import 'package:event_commander/event_commander.dart';

import 'package:redstone/server.dart' as app;
import 'package:di/di.dart';
import 'package:mongo_dart/mongo_dart.dart';

@app.Install()
import '../lib/ort_service.dart';

import 'device/testdevice.dart';
import 'calculator/testcalculator.dart';
import 'storage/storage.dart';
import 'package:shelf_static/shelf_static.dart';

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
  
  app.setupConsoleLog();
  Db db = new Db('mongodb://localhost/snaps');
    db.open().then((_) {
    app.addModule(new Module()..bind(Db, toValue: db));
    //app.addPlugin(ObjectMapper);
    app.start(port: 8082);
    app.setShelfHandler(createStaticHandler("../../ort-client/web", 
        defaultDocument: "ort_event_main.html", 
        serveFilesOutsidePath: true));
  });
  
  
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
  Storage storage = new Storage(event_bus);

  event_bus.on(MyEvent, (MyEvent event) =>  
      updateRecords(event));
  
  print("stop main");
}

void updateRecords(MyEvent event) {
  if (event.selector.startsWith("calculator/TestCalculator/update"))
    print("TODO propagate event to GUI:"+event.jsonData);
  //TODO send data to WS
}
