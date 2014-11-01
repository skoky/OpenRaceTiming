import 'dart:io';
import 'dart:async';
import 'package:http_server/http_server.dart' show VirtualDirectory;
import 'package:event_commander/event_commander.dart';

import 'package:redstone/server.dart' as app;
import 'package:di/di.dart';
import 'package:mongo_dart/mongo_dart.dart';

@app.Install()
import 'package:OpenRaceTiming/ort_service.dart';
import 'package:OpenRaceTiming/reporter/reporter.dart';
import 'package:OpenRaceTiming/device/testdevice.dart';
import 'package:OpenRaceTiming/calculator/testcalculator.dart';
import 'package:OpenRaceTiming/bus.dart';
import 'package:OpenRaceTiming/storage/storage.dart';
import 'package:shelf_static/shelf_static.dart';

EventBus event_bus = new EventBus();

handleMsg(msg) {
  print('Message received: $msg');
}

WebSocket webSocket;

void main() {

  app.setupConsoleLog();
  app.start(port: 8082);
  app.setShelfHandler(createStaticHandler("../web",
  defaultDocument: "ort_console.html",
  serveFilesOutsidePath: true));

  var staticFiles = new VirtualDirectory('.')
    ..allowDirectoryListing = true;

  TestCalculator test_calculator = new TestCalculator(event_bus);
  TestDevice test_device = new TestDevice(event_bus);
  Storage storage = new Storage(event_bus);

  event_bus.on(MyEvent, (MyEvent event) =>
  updateRecords(event));
  new Reporter();

  print("main done");
}

@app.Interceptor(r'/.*')
interceptor() {
  app.chain.next(() {
    app.response = app.response.change(headers: {
        "Access-Control-Allow-Origin": "*"
    });
  });
}


void updateRecords(MyEvent event) {
  if (event.selector.startsWith("calculator/TestCalculator/update")) {
    if (webSocket != null) {
      print("Propagating event to GUI:" + event.jsonData);
      webSocket.add(event.jsonData);
    }
  }

}
