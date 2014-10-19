part of bwu_sparkline;

class RangeMap {
  List<List> _map;
  List<List> _rangeList;

  RangeMap (List<List> map) {
    var key, range, rangelist = [];
    //for (List<int,int> key in map) {
    map.forEach((range) {
      if(range.length == 2) {
      //if (map.containsKey(key) && key is String && key.indexOf(':') > -1) {
      //  range = key.split(':');
        if(range[0] == null) range[0] = double.NEGATIVE_INFINITY;
        if(range[1] == null) range[1] = double.INFINITY;
        //range[0] = range[0].length == 0 ? double.NEGATIVE_INFINITY : double.parse(range[0]);
        //range[1] = range[1].length == 0 ? double.INFINITY : double.parse(range[1]);
        //range[2] = map[key]; // TODO should be color
        rangelist.add(range);
      }
    });
    _map = map;
    _rangeList = rangelist;
  }

  String get(num value) {
    int i;
    List range;
    String result;
    if ((result = _map[value][2]) != null) {
      return result;
    }
    if (_rangeList != null) {
      for (i = _rangeList.length; i--; i > 0) {
        range = _rangeList[i];
        if (range[0] <= value && range[1] >= value) {
          return range[2];
        }
      }
    }
    return null;
  }
}