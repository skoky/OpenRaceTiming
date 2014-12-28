
import 'dart:html';
import 'dart:js';
import 'package:polymer/polymer.dart';

@CustomTag('create-event')
class CreateEvent extends PolymerElement {
  @observable int page = 0;
  @observable String name;
  CreateEvent.created() : super.created();
  add(e) {
    print("Add called");
    saveEvent(name);

  }
  complete() {
    // complete handling goes here...
  }

  void saveEvent(String name) {
    HttpRequest request = new HttpRequest(); // create a new XHR

    // add an event handler that is called when the request finishes
    request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE &&
      (request.status == 200 || request.status == 0)) {
        // data saved OK.
        print(request.responseText); // output the response from the server
      }
    });

    // POST the data to the server
    var url = "/ui/event";
    request.open("PUT", url, async: false);

    String jsonData = '{"name":"$name"}';
    request.send(jsonData); // perform the async POST
  }
}