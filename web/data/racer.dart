class Racer {
  String name;
  String location;
  String categories;

  Racer(this.name, this.location, this.categories);

  String toString() => name;
}

List<Racer> _racers = [
    new Racer("Peter Pan", "Boston", "---"),
    new Racer("Mike Noop", "Boston", "---"),
];

List<Racer> get racers => new List<Racer>.generate(
    _racers.length,
        (int index) => new Racer(_racers[index].name, _racers[index].location, _racers[index].categories),
    growable: true
);
List<Racer> getRacers(int count) => racers.take(count);

abstract class RacersConverter {

  String racerToString(var racer) {
    String name = '';
    String location = '';

    if (racer is Map) {
      name = racer['name'];
      location = racer['location'];
    }
    else if (racer is Racer) {
      name = racer.name;
      location = racer.location;
    }

    return '$name ($location)';
  }

  String racersToString(List<Racer> racers) {
    if (racers.isEmpty) {
      return 'none';
    }

    StringBuffer resultBuffer = new StringBuffer();

    for (Racer racer in racers) {
      resultBuffer.write('${racer.name}, ');
    }

    String result = resultBuffer.toString();

    if (result.length > 0) {
      return result.substring(0, result.length - 2);
    }

    return result;
  }

}