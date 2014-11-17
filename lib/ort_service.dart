library ort;

import 'package:redstone/server.dart' as app;
import 'dart:convert';
import 'dart:core';
import 'package:redstone_mapper/mapper.dart';
import 'package:redstone_mapper/plugin.dart';
import 'package:redstone_mapper_mongo/manager.dart';
import 'package:redstone_mapper_mongo/metadata.dart';
import 'package:bson/bson.dart' as mongoBson;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart_query/mongo_dart_query.dart';
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

  // invoke like this:
  //  curl http://localhost:8082/get/event
  @app.Route("/get/:entity", methods: const[app.GET])
  @Encode()
  Future<List<String>> listEvents(@app.Attr() MongoDb dbConn, String entity) {
    return dbConn.collection(entity).find().toList();
  }


  // invoke like this:
  //  curl http://localhost:8082/get/event/5469b637f651bffd26855c3f
  @app.Route("/get/:entity/:id", methods: const[app.GET])
  @Encode()
  Future<List<String>> listEventsById(@app.Attr() MongoDb dbConn, String entity, String id) {
    mongoBson.ObjectId mid = mongoBson.ObjectId.parse(id);
    return dbConn.collection(entity).find(where.id(mid)).toList();
  }



  // invoke like this:
  // curl -X POST -d @event.txt http://localhost:8082/event --header "Content-Type:application/json"
  // event.txt file:
  // {"name":"test curl" }
  @app.Route("/store/:entity", methods: const[app.POST])
  void addEvent(@app.Attr() MongoDb dbConn, @app.Body(app.JSON) Object event,String entity) {
    dbConn.insert("event",event);
  }


}

