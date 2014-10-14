import 'dart:async';
import 'dart:convert';
import 'dart:html';

class Presenter {
  static const Duration RECONNECT_DELAY = const Duration(milliseconds: 500);
  
  ButtonElement sendMessageButton = querySelector('#sendMessageButton');
  Element statusText = querySelector("#status");
  
  bool connectPending = false;
  WebSocket webSocket;
  
  Presenter() {
    updateStatus("Init done");
    sendMessageButton.onClick.listen(sendMessage);
    connect();
  }
  
  void updateStatus(status) {
    statusText..text=status;
  }

  void connect() {
    connectPending = false;
    webSocket = new WebSocket('ws://127.0.0.1:4040/ws');
    webSocket.onOpen.first.then((_) {
      onConnected();
      webSocket.onClose.first.then((_) {
        print("Connection disconnected to ${webSocket.url}.");
        onDisconnected();
      });
    });
    webSocket.onError.first.then((_) {
      print("Failed to connect to ${webSocket.url}. "
            "Run bin/server.dart and try again.");
      onDisconnected();
    });
  }

  void onConnected() {
    webSocket.onMessage.listen((e) {
      handleMessage(e.data);
    });
  }
 
  void onDisconnected() {
    if (connectPending) return;
    connectPending = true;
    updateStatus('Disconnected. Start \'bin/server.dart\' to continue.');
    new Timer(RECONNECT_DELAY, connect);
  }
  void handleMessage(data) {
    print(data);
  }
  
  void sendMessage(Event e) {
    var request = {
      'request': 'search',
      'input': 'test'
    };
    webSocket.send(JSON.encode(request));   
  }
}

void main() {
  new Presenter(); 
}

