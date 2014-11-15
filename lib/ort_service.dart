library ort;

import 'package:redstone/server.dart' as app;
import 'dart:convert';
import 'dart:core';
import 'package:redstone_mapper/mapper.dart';
import 'package:redstone_mapper/plugin.dart';
import 'package:redstone_mapper_mongo/manager.dart';
import 'package:redstone_mapper_mongo/metadata.dart';
import 'dart:async';

@app.Group('/')
class OrtService {



  @app.Route("/record", methods: const [app.GET])
  getRecord() {
    Map mapResponse = new Map();
    mapResponse["passingId"] = "1";
    mapResponse["passingNumber"] = "120";
    mapResponse["time"] = (new DateTime.now()).toString();

    String jsonData = JSON.encode(mapResponse);

    return jsonData;
  }

  @app.Route("/racers", methods: const [app.GET])
  getRacers() {
    Map mapResponse = new Map();
    mapResponse["racerName"] = "Michal";
    mapResponse["transponderId"] = "123344";
    mapResponse["category"] = "Beginner";

    String jsonData = JSON.encode(mapResponse);

    return jsonData;
  }

  @app.Route("/modules/all", methods: const [app.GET])
  getAllModules() {
    Map mapResponse = new Map();

    String jsonData = JSON.encode(mapResponse);

    return jsonData;
  }


  @app.Route("/event", methods: const[app.GET])
  @Encode()
  Future<List<String>> listEvents(@app.Attr() MongoDb dbConn) {
    return dbConn.collection("event").find().toList();
  }

  // invoke:
  @app.Route("/event", methods: const[app.POST])
  void addEvent(@app.Attr() MongoDb dbConn, @Decode() Event event) {
    dbConn.insert("event",event);
  }


}

class Event {
  @Id()
  String id;

  @Field()
  String name;

  String toString() {
    return "Event:$name";
  }


}