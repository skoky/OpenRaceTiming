import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:html_components/html_components.dart' show DatatableComponent, GrowlComponent;
import 'data/event.dart' as data;


@CustomTag('datatable-edit-demo')
class DatatableEditDemo extends PolymerElement {


  Event _selectedItem;

  @observable List<data.Event> events = toObservable(data.events);

  DatatableEditDemo.created() : super.created();

  void onItemEdited(Event event, var detail, DatatableComponent target) {
    GrowlComponent.postMessage('', 'Item edited!');
  }

  void onItemSelected(Event event, var detail, DatatableComponent target) {
    _selectedItem = target.selectedItems.first;
    GrowlComponent.postMessage('Selected items:', _selectedItem.toString());
  }

  void openEvent(Event event, var detail, DatatableComponent target) {
    GrowlComponent.postMessage('Open event ',_selectedItem.toString());
  }

  void addEvent(Event event, var detail, DatatableComponent target) {
    GrowlComponent.postMessage('', 'Add new event');
  }

}

main() => initPolymer();
