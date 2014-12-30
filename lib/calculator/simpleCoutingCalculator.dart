import 'dart:convert';
import 'package:event_commander/event_commander.dart';
import 'package:OpenRaceTiming/ort_common.dart';
import 'package:logging/logging.dart';

final Logger log = new Logger('Calculator');

class TestCalculator {


  List results = new List();  // TODO improve storage
  EventBus event_bus;

  TestCalculator(this.event_bus) {
    event_bus.on(OrtEvent, (OrtEvent event) => processEvent(event));
  }
  
  void processEvent(OrtEvent event) {
    log.fine("Calculating:"+event.selector);
    if (!event.selector.startsWith("device/TranX3/"))
      return; // not interested in
    
    if (event.selector.startsWith("device/TranX3/Passings")) {
      Map data = JSON.decode(event.jsonData);
      log.fine("Reseved passing for id:"+data["transponder"]);
      
      DataRecord newR=null;
      for(DataRecord r in results) {
        if (r.id == data["transponder"]) {
          r.laps++;
          newR = r;
          break;
        } 
      }
      if (newR == null) {
        newR = new DataRecord();
        newR.id = data["transponder"];
        newR.laps=1;
        results.add(newR);          
      }
      var json = newR.json();
      log.fine("Calculator sending event:"+json);
      event_bus.signal(new OrtEvent("calculator/single/update", json));
      
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


