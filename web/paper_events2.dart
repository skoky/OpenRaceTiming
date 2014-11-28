import 'dart:html';
import 'dart:convert';
import 'package:polymer/polymer.dart';

@CustomTag('events-list')
class EventsList extends PolymerElement {


  @observable ObservableList data = new ObservableList();
  @observable bool selectionEnabled = true;
  @observable var selection;
  @observable bool multi = false;

  @observable String addIdx = '0';
  @observable String deleteIdx = '0';
  @observable String scrollToIdx = '0';
  @observable int count = 0;


  EventsList.created() : super.created();

  @override ready() {
    downloadData();
    data = generateData();
  }

  generateData() {
    var names = <String>[];
    var data = new ObservableList();
    for (var i = 0; i < 5; i++) {
      names.add("name" );
    }
    names.sort();
    for (var i = 0; i < 5; i++) {
      data.add(new EventItem(
          id: i,
          name: names[i],
          details: "dddd",
          image: i % 4,
          value: 0,
          type: 0,
          checked: false
      ));
    }
    return data;
  }


  addRecord() {
    data.insert(int.parse(addIdx), new EventItem(
        id: ++this.count,
        name: _generateName(4, 8),
        details: strings[this.count % 3],
        image: this.count % 4,
        value: 0,
        type: 0,
        checked: false));
  }

  deleteRecord() {
    data.removeAt(int.parse(deleteIdx));
  }

  downloadData() {
    var request = HttpRequest.getString("http://localhost:8082/get/event").then(onDataLoaded);
  }

  void onDataLoaded(String responseText) {
    List events = JSON.decode(responseText);
    print(events);
    data.clear();
    events.forEach((event) =>
    data.add(new EventItem(
        id:1,
        name: event["name"]
    )));
  }

}

class EventItem extends Observable {
  final int id;
  final String name;
  final String details;
  final int image;
  @observable int value;
  @observable int type;
  @observable bool checked;

  EventItem({this.id, this.name, this.details, this.image, this.value, this.type,
           this.checked});
}

main() => initPolymer();