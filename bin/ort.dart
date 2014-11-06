import 'dart:io';
import 'dart:async';
import 'package:http_server/http_server.dart' show VirtualDirectory;
import 'package:event_commander/event_commander.dart';

import 'package:redstone/server.dart' as app;


@app.Install()
import 'package:OpenRaceTiming/ort_service.dart';
import 'package:OpenRaceTiming/reporter/reporter.dart';
import 'package:OpenRaceTiming/device/device.dart';
import 'package:OpenRaceTiming/calculator/testcalculator.dart';
import 'package:OpenRaceTiming/ort_common.dart';
import 'package:OpenRaceTiming/storage/mongo_storage.dart';
import 'package:shelf_static/shelf_static.dart';

EventBus event_bus = new EventBus();

handleMsg(msg) {
  print('Message received: $msg');
}

WebSocket webSocket;

void main() {

  app.setupConsoleLog();

  // init modules
  var m = new MongoStorage();
  m.bus=event_bus;
  m.start();
  app.addModule(m);

  app.start(port: 8082);
  app.setShelfHandler(createStaticHandler("../web",
    defaultDocument: "ort_console.html",
    serveFilesOutsidePath: true));

  var staticFiles = new VirtualDirectory('.')
    ..allowDirectoryListing = true;

  TestCalculator test_calculator = new TestCalculator(event_bus);
  new DeviceConnector(event_bus);

  event_bus.on(OrtEvent, (OrtEvent event) =>
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


void updateRecords(OrtEvent event) {
  if (event.selector.startsWith("calculator/TestCalculator/update")) {
    if (webSocket != null) {
      print("Propagating event to GUI:" + event.jsonData);
      webSocket.add(event.jsonData);
    }
  }

}
