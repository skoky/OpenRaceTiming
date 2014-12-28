library presenter;

import 'package:redstone/server.dart' as app;
import 'dart:core';
import 'package:redstone_mapper/plugin.dart';
import 'package:redstone_mapper_mongo/manager.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart_query/mongo_dart_query.dart';
import 'dart:async';
import 'package:json_object/json_object.dart';
import 'package:OpenRaceTiming/ort_service.dart';

@app.Group('/ui')
class PresenterService {

  @app.Route("/:entity", methods: const[app.GET,app.POST])
  @Encode()
  Future<String> listEvents(@app.Attr() MongoDb dbConn, String entity, @app.QueryParam("page") int page, @app.QueryParam("rows") int rows) {
    return new OrtService().query(dbConn,entity,rows,null,null).then((ret){
      var result = {"result":"[\"name\":\"xxx\"]"};
      JsonObject json = new JsonObject();
      json.result=ret;
      json.totalCount = ret.length;
      return  json.toString();
    });

  }

  @app.Route("/:entity", methods: const[app.PUT])
  @Encode()
  Future<String> saveEntity(@app.Attr() MongoDb dbConn, String entity, @app.Body(app.TEXT) Object data) {
    var  dataJson = JsonObject.decoder.convert(data);
    String id=null;
    if (dataJson["_id"]!=null) {
      id = dataJson["_id"].split("\"")[1]; // id must be extracted from data to be found in DB
      dataJson.remove("_id");
    }
    return new OrtService().update(dbConn,dataJson, entity, id);
  }

}


