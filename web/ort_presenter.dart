import 'dart:html';
import '../../core/core.dart';

void main() {
  new Presenter(); 
}

class Presenter {

  Presenter() {
    var core = new Core();
    updateStatus("Init done");

    
    core.getBus().on(MyEvent, (MyEvent event) =>
          updateStatus("Event received:"+event.selector+" data:"+event.jsonData));

  }
  
  void updateStatus(status) {
    querySelector("#status")..text=status;
  }
  
 
  
}

