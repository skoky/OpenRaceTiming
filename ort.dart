import 'dart:io';
import 'dart:async';
import 'package:http_server/http_server.dart';
import 'bin/core/core.dart';

void main() {
  var staticFiles = new VirtualDirectory('.')
    ..allowDirectoryListing = true;

  runZoned(() {
    HttpServer.bind('0.0.0.0', 7777).then((server) {
      print('Server running');
      server.listen(staticFiles.serveRequest);
    });
  },
  onError: (e, stackTrace) => print('Oh noes! $e $stackTrace'));

  var core = new Core();
  core.getBus().on(MyEvent, (MyEvent event) =>
  print("TODO send to WS to client:"+event.selector));
  // updateStatus("Event received:"+event.selector+" data:"+event.jsonData));


}