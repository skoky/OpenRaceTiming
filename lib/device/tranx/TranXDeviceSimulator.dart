/*

MyLaps TanX3 simulator of the decoder logic. Its generates JSON data based on conversion [http://ambconverter.appspot.com/]

 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:event_commander/event_commander.dart';
import 'package:OpenRaceTiming/ort_common.dart';
import 'dart:math';
import 'package:logging/logging.dart';

class TranX3Simulator {

  final Logger log = new Logger('TranX3Simulator');

  EventBus bus;
  var data;
  Map sequence;
  Map transponders;
  int passingNumber=0;
  var r = new Random();
  String decoderId;

  processEvent([key]) {
    if (key==null) key=0;
    log.finest("K:$key");
    Map nextStep = sequence[key];
    if (nextStep==null) {
      key=0;
      nextStep = sequence[key];
    }
    int delay=10;
    log.finest("Processing:"+nextStep.toString());
    if (nextStep['delay'] !=null) {
      delay = nextStep['delay'];
      if (nextStep['unit']=="sec") delay = delay * 1000;
    } else if (nextStep["passingNumber"]!=null) {
      passingNumber>9999?passingNumber=1:passingNumber++;
      nextStep['passingNumber']=passingNumber;
      var passing = JSON.encode(nextStep);
      nextStep['transponder']=transponders[r.nextInt(transponders.length)]['transponder'];
      nextStep['hits']=r.nextInt(100);
      nextStep['strength']=r.nextInt(100);
      nextStep['decoderId']=decoderId;
      bus.signal(new OrtEvent('device/TranX3/Passings', passing));
    } else {
      log.info("Invalid:"+nextStep["passing"]);
    }
    log.fine("Key $key end");
    new Future.delayed(new Duration(milliseconds:delay),()=> processEvent(key+1)).then(log.finest("Wait: $delay ms"));

  }

  var config;

  TranX3Simulator(this.bus) {
    data = JSON.decode(new File("../lib/device/tranx/P3data.json").readAsStringSync());
    // print("Transponders:");
    // data['transponders'].forEach((v)=> print(v));
    sequence = data['sequence'].asMap();
    transponders = data['transponders'].asMap();

    config = JSON.decode(new File("../lib/device/tranx/P3configdata.json").readAsStringSync());
    decoderId = config['decoderId'];

    new Future.delayed(new Duration(seconds:1),
        () => processEvent());
    log.fine("simul end");
  }


}