import 'dart:io';
import 'package:OpenRaceTiming/ort_common.dart';
import 'package:redstone_web_socket/redstone_web_socket.dart';
import 'package:logging/logging.dart';

final Logger log = new Logger('Presenter');

class PresenterWs extends OrtModule {

  @OnOpen()
  void onOpen(WebSocketSession session) {
    log.fine("connection established");

  }

  @OnMessage()
  void onMessage(String message, WebSocketSession session) {
    log.fine("message received: $message");
    session.connection.add("echo $message");
  }

  @OnError()
  void onError(error, WebSocketSession session) {
    log.severe("error: $error");
  }

  @OnClose()
  void onClose(WebSocketSession session) {
    log.fine("connection closed");
  }

}


void updateRecords(WebSocket webSocket,OrtEvent event) {
  if (event.selector.startsWith("calculator/")) {
    if (webSocket != null) {
      log.fine("Propagating event to GUI:" + event.jsonData);
      webSocket.add(event.jsonData);
    } else log.finest("No websocket");
  }
}