class Event {
  String name;
  String location;
  String categories;

  Event(this.name, this.location, this.categories);

  String toString() => name;
}

List<Event> _events = [
    new Event("Boston marathon", "Boston", "---"),
    new Event("Prague marathon", "Boston", "---"),
];

List<Event> get events => new List<Event>.generate(
    _events.length,
        (int index) => new Event(_events[index].name, _events[index].location, _events[index].categories),
    growable: true
);
List<Event> getEvents(int count) => events.take(count);

abstract class EventsConverter {

  String eventToString(var event) {
    String name = '';
    String location = '';

    if (event is Map) {
      name = event['name'];
      location = event['location'];
    }
    else if (event is Event) {
      name = event.name;
      location = event.location;
    }

    return '$name ($location)';
  }

  String eventsToString(List<Event> events) {
    if (events.isEmpty) {
      return 'none';
    }

    StringBuffer resultBuffer = new StringBuffer();

    for (Event event in events) {
      resultBuffer.write('${event.name}, ');
    }

    String result = resultBuffer.toString();

    if (result.length > 0) {
      return result.substring(0, result.length - 2);
    }

    return result;
  }

}