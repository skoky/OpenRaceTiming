import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:html_components/html_components.dart' show DatatableComponent, GrowlComponent;
import 'data/car.dart' as data;

@CustomTag('datatable-selection-demo')
class DatatableSelectionDemo extends PolymerElement with data.CarConverter {

  @observable List<data.Car> cars = toObservable(data.cars);
  @observable String paginator = 'top';
  @observable String selection = 'single';

  DatatableSelectionDemo.created() : super.created();

  void onItemSelected(Event event, var detail, DatatableComponent target) {
    GrowlComponent.postMessage('Selected items:', carsToString(target.selectedItems));
  }

}