import 'dart:io';
import 'dart:async';
import 'package:http_server/http_server.dart' show VirtualDirectory;
import 'package:event_commander/event_commander.dart';
import 'package:redstone_web_socket/redstone_web_socket.dart';
import 'package:redstone/server.dart' as app;
import 'package:OpenRaceTiming/device/device.dart';
import 'package:OpenRaceTiming/calculator/simpleCoutingCalculator.dart';
import 'package:OpenRaceTiming/ort_common.dart';
import 'package:OpenRaceTiming/storage/mongo_storage.dart';
import 'package:OpenRaceTiming/presenter/presenter.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:redstone_mapper/plugin.dart';
import 'package:redstone_mapper_mongo/manager.dart';


@app.Install()
import 'package:OpenRaceTiming/ort_service.dart';


EventBus _bus = new EventBus();

handleMsg(msg) {
  print('Message received: $msg');
}

WebSocket webSocket;

void main() {

  app.setupConsoleLog();

  // init modules
  var m = new MongoStorage();
  m.start(_bus);
  app.addModule(m);

  app.addPlugin(getWebSocketPlugin());
  app.addModule(new PresenterWs());
  var dbManager = new MongoDbManager("mongodb://localhost/ort", poolSize: 3);
  app.addPlugin(getMapperPlugin(dbManager));

  // TODO change to module
  TestCalculator calculator = new TestCalculator(_bus);
  new DeviceConnector(_bus);

  // start web server
  app.start(port: 8082);
  app.setShelfHandler(createStaticHandler("../web",
    defaultDocument: "index.html",
    serveFilesOutsidePath: true));

  var staticFiles = new VirtualDirectory('.')
    ..allowDirectoryListing = true;

  // websocket publishing back to client
  runZoned(() {
    HttpServer.bind('127.0.0.1', 8083).then((server) {
      print("push websocket init");
      server.listen((HttpRequest req) {
        if (req.uri.path == '/ws') {
          // Upgrade a HttpRequest to a WebSocket connection.
          WebSocketTransformer.upgrade(req).then((socket) {
            socket.listen(handleMsg);
            webSocket = socket;
            print("Push websocket done");
          });
        }
      });
    });
  },
  onError: (e, stackTrace) => print('Oh noes! $e $stackTrace'));
  _bus.on(OrtEvent, (OrtEvent event) => updateRecords(webSocket,event));  // assigning handlers
  print("Zoned done on $webSocket");
  print("startup done");
}

@WebSocketHandler("/ws")
class ServerEndPoint extends PresenterWs {}

@app.Interceptor(r'/.*')
interceptor() {
  app.chain.next(() {
    app.response = app.response.change(headers: {
        "Access-Control-Allow-Origin": "*"
    });
  });
}




