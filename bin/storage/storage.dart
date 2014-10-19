import 'package:mongo_dart/mongo_dart.dart';
import 'package:event_commander/event_commander.dart';
import '../ort.dart';
import 'dart:convert';

/*
 * Stores data into MongoDB
 * Examples: https://github.com/vadimtsushko/mongo_dart/tree/master/example
 * MongoDB installation: http://docs.mongodb.org/manual/installation/
 */

class Storage {

 EventBus bus;
  
Storage(EventBus bus) {
  this.bus=bus;
  bus.on(MyEvent, (MyEvent event) => processEvent(event));
  
}

   
void processEvent(MyEvent event) {
  print("Received:"+event.selector);
      
  if (event.selector.startsWith("device/TestDevice/Passings")) {
    store(event);
  } else if (event.selector.startsWith("calculator/TestCalculator/update")) {
      String id = JSON.decode(event.jsonData)['id'];      
    update('id',id,event);
  }
}

void update(selectorId,selectorV,event) {
  Db db = new Db('mongodb://127.0.0.1/ort');
  ObjectId id;
  DbCollection c;
  db.open().then((_){
    c = db.collection(event.selector);
    Map data = JSON.decode(event.jsonData);
    print("Updating data $data");
    c.update(where.eq(selectorId, selectorV),data, upsert: true, writeConcern: WriteConcern.ACKNOWLEDGED)
      .then((_){
         db.close();
       });
      });
  
}

void store(event) {
  Db db = new Db('mongodb://127.0.0.1/ort');
  ObjectId id;
  DbCollection c;
  db.open().then((_){
  c = db.collection(event.selector);
  print("Storing passing "+event.jsonData);
  Map data = JSON.decode(event.jsonData);
  c.insert(data, writeConcern: WriteConcern.ACKNOWLEDGED)
  .then((_){
       db.close();
     });
    });
}

}