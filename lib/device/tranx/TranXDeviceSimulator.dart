/*

MyLaps TanX3 simulator of the decoder logic. Its generates JSON data based on conversion [http://ambconverter.appspot.com/]

 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:event_commander/event_commander.dart';
import 'package:OpenRaceTiming/bus.dart';
import 'dart:math';

class TranX3Simulator {

  proc(key, value) {
    print(key+value);
  }

  EventBus bus;
  var data;
  Map sequence;
  Map transponders;
  int passingNumber=0;
  var r = new Random();
  String decoderId;

  processEvent([key]) {
    if (key==null) key=0;
    print("K:$key");
    Map nextStep = sequence[key];
    if (nextStep==null) {
      key=0;
      nextStep = sequence[key];
    }
    int delay=10;
    print("Processing:"+nextStep.toString());
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
      bus.signal(new MyEvent('device/TranX3/Passings', passing));
    } else {
      print("Invalid:"+nextStep["passing"]);
    }
    print("Key $key end");
    new Future.delayed(new Duration(milliseconds:delay),()=> processEvent(key+1)).then(print("Wait: $delay ms"));

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
    print("simul end");
  }


}