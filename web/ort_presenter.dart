import 'dart:html';
import '../bin/ort.dart';

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

