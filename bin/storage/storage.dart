import 'package:mongo_dart/mongo_dart.dart';
import 'package:event_commander/event_commander.dart';
import '../ort.dart';

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
  if (!event.selector.startsWith("device/TestDevice/"))
    return; // TODO see if to store
      
  if (event.selector.startsWith("device/TestDevice/Passings")) {
    store(event);
  }
}

void store(event) {
  Db db = new Db('mongodb://127.0.0.1/ort');
  
  ObjectId id;
  DbCollection c;
  db.open().then((_){
  c = db.collection(event.selector);
  print("Storing passing "+event.jsonData);
  Map data = new Map();
  data['data']=event.jsonData;
  c.insert(data, writeConcern: WriteConcern.ACKNOWLEDGED)
  .then((_){
       db.close();
     });
    });
}
}