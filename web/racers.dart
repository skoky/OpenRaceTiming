import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:html_components/html_components.dart' show DatatableComponent, GrowlComponent;
import 'data/racer.dart' as data;

@CustomTag('datatable-edit-demo')
class DatatableEditDemo extends PolymerElement {

  @observable List<data.Racer> events = toObservable(data.racers);

  DatatableEditDemo.created() : super.created();

  void onItemEdited(Event event, var detail, DatatableComponent target) {
    GrowlComponent.postMessage('', 'Item edited!');
  }

  void openEvent(Event event, var detail, DatatableComponent target) {
    GrowlComponent.postMessage('', 'Open event '+target);
  }

}

main() => initPolymer();
