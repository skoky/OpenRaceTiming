import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:html_components/html_components.dart' show DatatableComponent, GrowlComponent;
import 'data/car.dart' as data;

@CustomTag('datatable-edit-demo')
class DatatableEditDemo extends PolymerElement {

  @observable List<data.Car> cars = toObservable(data.cars);

  DatatableEditDemo.created() : super.created();

  void onItemEdited(Event event, var detail, DatatableComponent target) {
    GrowlComponent.postMessage('', 'Item edited!');
  }

}