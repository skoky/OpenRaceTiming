import 'dart:io';
import 'package:OpenRaceTiming/ort_common.dart';
import 'package:redstone_web_socket/redstone_web_socket.dart';



class PresenterWs extends OrtModule {

  @OnOpen()
  void onOpen(WebSocketSession session) {
    print("connection established");

  }

  @OnMessage()
  void onMessage(String message, WebSocketSession session) {
    print("message received: $message");
    session.connection.add("echo $message");
  }

  @OnError()
  void onError(error, WebSocketSession session) {
    print("error: $error");
  }

  @OnClose()
  void onClose(WebSocketSession session) {
    print("connection closed");
  }

}


void updateRecords(WebSocket webSocket,OrtEvent event) {
  if (event.selector.startsWith("calculator/")) {
    if (webSocket != null) {
      print("Propagating event to GUI:" + event.jsonData);
      webSocket.add(event.jsonData);
    } else print("No websocket");
  }
}