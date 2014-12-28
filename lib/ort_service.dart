library ort;

import 'package:redstone/server.dart' as app;
import 'package:logging/logging.dart';
import 'dart:core';
import 'package:redstone_mapper/mapper.dart';
import 'package:redstone_mapper/plugin.dart';
import 'package:redstone_mapper_mongo/manager.dart';
import 'package:redstone_mapper_mongo/metadata.dart';
import 'package:bson/bson.dart' as mongoBson;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart_query/mongo_dart_query.dart';
import 'dart:async';

// see wiki for usage https://github.com/skoky/OpenRaceTiming/wiki/Server's-REST-API
@app.Group('/rest')
class OrtService {

  var logger = new Logger("OrtService");

  // queries the Entity for query attribute containing queryString
  // invoke like this:
  //  curl http://localhost:8082/rest/event?limit=3&queryString=Lenin&queryAttribute=name
  @app.Route("/:entity", methods: const[app.GET])
  @Encode()
  Future<List<String>> query(@app.Attr() MongoDb dbConn, String entity, @app.QueryParam("limit") int limit,
                             @app.QueryParam("queryString") String queryString,
                             @app.QueryParam("queryAttribute") String queryAttribute) {

    if (limit == null) limit = 100;
    entity = Uri.decodeFull(entity); // for entities with complex names
    logger.info("Query items $entity with limit $limit");

    if (queryAttribute == null && queryString == null)
      return dbConn.collection(entity).find(where.limit(limit)).toList().catchError((e) {
        logger.warning("Unable to get item: $e");
      });
    else {
      if (queryString == null || queryAttribute == null)
        return null;
      List l = new List();
      l.add(queryString);
      return dbConn.collection(entity).find(where.limit(limit).all(queryAttribute, l)).toList();
    }
  }


  // querying entity with the ID
  // invoke like this:
  //  curl http://localhost:8082/rest/event/5469b637f651bffd26855c3f
  @app.Route("/:entity/:id", methods: const[app.GET])
  @Encode()
  Future<List<String>> getById(@app.Attr() MongoDb dbConn, String entity, String id) {
    entity = Uri.decodeFull(entity); // for entities with complex names
    logger.info("Get item $entity with id $id");
    mongoBson.ObjectId mid = mongoBson.ObjectId.parse(id);
    return dbConn.collection(entity).find(where.id(mid)).toList().catchError((e) {
      logger.warning("Unable to get item: $e");
    });
  }


  // inserting new attribute
  // invoke like this:
  // curl -X POST -d @event.txt http://localhost:8082/rest/event --header "Content-Type:application/json"
  // event.txt file:
  // {"name":"test curl" }
  @app.Route("/:entity", methods: const[app.POST])
  add(@app.Attr() MongoDb dbConn, @app.Body(app.JSON) Object data, String entity) {
    entity = Uri.decodeFull(entity); // for entities with complex names
    logger.info("Insert into $entity ");
    return dbConn.insert(entity, data).catchError((e) {
      logger.warning("Unable to update item: $e");
    });
  }

  // inserting or updating entity if already exists
  // invoke like this: ... TBD
  @app.Route("/:entity/:id", methods: const[app.PUT])
  update(@app.Attr() MongoDb dbConn, @app.Body(app.JSON) Object data, String entity, String id) {
    entity = Uri.decodeFull(entity); // for entities with complex names
    logger.info("Insert/update $entity with id $id");
    return dbConn.update(entity, {"_id": ObjectId.parse(id)}, data,upsert:true).catchError((e) {
      logger.warning("Unable to update item: $e");
    });
  }


  // deleting an entity if exists
  // invoke like this:
  // curl -X DELETE -d @event.txt http://localhost:8082/rest/event/xxxxxxx
  @app.Route("/:entity/:id", methods: const[app.DELETE])
  delete(@app.Attr() MongoDb dbConn, String entity, String id) {
    logger.info("Deleting item $id");
    entity = Uri.decodeFull(entity); // for entities with complex names
    // Remove item from database
    return dbConn.remove(entity, {
        "_id": ObjectId.parse(id)
    }).then((dbRes) {
      logger.info("Mongodb: $dbRes");
    }).catchError((e) {
      logger.warning("Unable to update item: $e");
    });
  }
}

