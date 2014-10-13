import 'dart:html';
import '../../core/openracetiming.dart';

void main() {
  new Presenter(); 
}

class Presenter {

  Presenter() {
    var ort = new OpenRaceTiming();
    updateStatus("Init done");

    
    ort.getBus().on(MyEvent, (MyEvent event) => 
          updateStatus("Event received:"+event.description));

  }
  
  void updateStatus(status) {
    querySelector("#status")..text=status;
  }
  
 
  
}

