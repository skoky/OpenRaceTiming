import 'package:event_commander/event_commander.dart';
import 'package:di/di.dart';

class OrtEvent extends Event {
  String selector;
  String jsonData;

  OrtEvent(this.selector, this.jsonData);
}



/**
 * modules abstract classes
 */

abstract class OrtModule extends Module {

  start(EventBus bus);
  stop();

}
abstract class Storage extends OrtModule {


  List<Json> getResults() {
    return new List();
  }

}

