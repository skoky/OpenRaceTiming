import 'dart:io';
import 'dart:async';
import 'package:http_server/http_server.dart';

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
}