import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:html_components/html_components.dart' show DatatableComponent, GrowlComponent;
import '../data/event.dart' as data;


@CustomTag('events-datatable')
class EventsEdit extends PolymerElement {

  var _selectedItem;
  @observable List<data.Event> events;

  EventsEdit.created() : super.created();

  void onItemEdited(Event event, var detail, DatatableComponent target) {
    GrowlComponent.postMessage('', 'Item edited!');
  }

  void onItemSelected(Event event, var detail, DatatableComponent target) {
    if (target.selectedItems.isEmpty)
        _selectedItem=null;
     else
    _selectedItem = target.selectedItems.first;
  }

  void openEvent(Event event, var detail, var target) {
    if (_selectedItem == null)
      GrowlComponent.postMessage('Select event to open', "");
    else
      GrowlComponent.postMessage('Open event ', _selectedItem.toString());
  }

  void addEvent(Event event, var detail, var target) {
//    querySelector("create-event").hidden = false;
//    GrowlComponent.postMessage('', 'Add new event pressed');
  }


}


main() => initPolymer();
