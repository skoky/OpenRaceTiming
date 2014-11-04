import 'dart:convert';
import 'package:event_commander/event_commander.dart';
import 'package:OpenRaceTiming/bus.dart';

class TestCalculator {

  List results = new List();  // TODO improve storage
  EventBus event_bus;

  TestCalculator(this.event_bus) {
    event_bus.on(MyEvent, (MyEvent event) => processEvent(event));
  }
  
  void processEvent(MyEvent event) {
    print("Calculating:"+event.selector);
    if (!event.selector.startsWith("device/TestDevice/"))
      return; // not interested in
    
    if (event.selector.startsWith("device/TestDevice/Passings")) {
      Map data = JSON.decode(event.jsonData);
      print("Reseved passing for id:"+data["passingId"]);
      
      DataRecord newR=null;
      for(DataRecord r in results) {
        if (r.id == data["passingId"]) {
          r.laps++;
          newR = r;
          break;
        } 
      }
      if (newR == null) {
        newR = new DataRecord();
        newR.id = data["passingId"];
        newR.laps=1;
        results.add(newR);          
      }
      var json = newR.json();
      print("Calculator sending event:"+json);
      event_bus.signal(new MyEvent("calculator/TestCalculator/update", json));  
      
    }
    
  }
}


class DataRecord {
  String id;
  String racerName;
  int laps;
  int lastLapTime;
  int bestLapTime;
  
  String json() {
    return '{"id":"$id","racerName":"","laps":$laps}';
  }
}


