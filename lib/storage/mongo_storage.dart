import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:event_commander/event_commander.dart';
import 'package:redstone/server.dart' hide JSON;
import 'package:OpenRaceTiming/ort_common.dart';

/*
 * Stores data into MongoDB
 * Examples: https://github.com/vadimtsushko/mongo_dart/tree/master/example
 * MongoDB installation: http://docs.mongodb.org/manual/installation/
 */

class MongoStorage extends Storage {

  EventBus _bus;

  start(EventBus bus) {
    _bus=bus;
    bus.on(OrtEvent, (OrtEvent event) => processEvent(event));
  }

  stop() {
    _bus.clearAllListeners();
  }

  void processEvent(OrtEvent event) {

    print("Storing:" + event.selector);

    if (event.selector.startsWith("device/")) {
      store(event);
    } else if (event.selector.startsWith("calculator/")) {
      String id = JSON.decode(event.jsonData)['id'];
      update('id', id, event);
    }
  }

  void update(selectorId, selectorV, event) {
    Db db = new Db('mongodb://127.0.0.1/ort');
    ObjectId id;
    DbCollection c;
    db.open().then((_) {
      c = db.collection(event.selector);
      Map data = JSON.decode(event.jsonData);
      print("Updating data $data");
      c.update(where.eq(selectorId, selectorV), data, upsert: true, writeConcern: WriteConcern.ACKNOWLEDGED)
      .then((_) {
        db.close();
      });
    });

  }

  void store(event) {
    Db db = new Db('mongodb://127.0.0.1/ort');
    ObjectId id;
    DbCollection c;
    db.open().then((_) {
      c = db.collection(event.selector);
      print("Storing passing " + event.jsonData);
      Map data = JSON.decode(event.jsonData);
      c.insert(data, writeConcern: WriteConcern.ACKNOWLEDGED)
      .then((_) {
        db.close();
      });
    });
  }

}