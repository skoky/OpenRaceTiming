import 'dart:html';
import '../bin/core/core.dart';

void main() {
  new Presenter(); 
}

class Presenter {

  Presenter() {
    updateStatus("Init done");

    // TODO add ws listener to get events from server

  }
  
  void updateStatus(status) {
    querySelector("#status")..text=status;
  }
  
 
  
}

