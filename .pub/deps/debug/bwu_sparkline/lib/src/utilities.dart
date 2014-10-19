library bwu_sparklines.utilities;

//import 'dart:math' as math;
import 'dart:html' as dom;

num clipval(num val, num min, num max) {
  if ((val == null && min != null) || val < min) {
    return min;
  }
  if ((val != null && max == null)|| val > max) {
    return max;
  }
  return val;
}

int quartile(List<int> values, int q) {
  var vl;
  if (q == 2) {
    vl = (values.length / 2).floor();
    return values.length % 2 != 0 ? values[vl] : (values[vl - 1] + values[vl]) /
        2;
  } else {
    if (values.length % 2 != null) { // odd
      vl = (values.length * q + q) / 4;
      return vl % 1 ? (values[vl.floor()] + values[vl.floor() - 1]) / 2 :
          values[vl - 1];
    } else { //even
      vl = (values.length * q + 2) / 4;
      return vl % 1 ? (values[vl.floor()] + values[vl.floor() - 1]) / 2 :
          values[vl - 1];
    }
  }
}

List<num> normalizeValue(dynamic val) {
  var result;
  var nf;

  if(val is List && val.every((v) => v is num)) return val;
  if(val == null) return [null];

  if(val is List && val.every((v) => v is String)) {
    List<num> newVal = [];
    (val as List).forEach((v) {
      if(val == null) {
        newVal.add(null);
      } else {
        newVal.add(num.parse(v, (e) => null));
      }
    });
    return newVal;
  }

  if(val is String) {
    String lcVal = val.toLowerCase();
    if(lcVal == 'null') return [null];
    if(lcVal == 'true') return [1];
    if(lcVal == 'false') return [0];

    return [num.parse(val, (_) => null)];
  }

  return [null];

//  switch (val) {
////       case 'undefined':
////           result = undefined;
////           break;
//    case 'null':
//      result = null;
//      break;
//    case 'true':
//      result = true;
//      break;
//    case 'false':
//      result = false;
//      break;
//    default:
//      var nf = double.parse(val);
//      if (val == nf.toString()) {
//        result = nf;
//      }
//  }
//  return result;
}

List normalizeValues(List vals) {
  int i;
  var result = [];
  for (i = 0; i < vals.length; i++) {
    result.add(normalizeValue(vals[i]));
  }
  return result;
}

List remove(List vals, dynamic filter) {
  int i;
  int vl = vals.length;
  List result = [];
  for (i = 0; i < vl; i++) {
    if (vals[i] != filter) {
      result.add(vals[i]);
    }
  }
  return result;
}

bool isNumber(dynamic val) {
  if (val is num) {
    return true;
  }

  if (val is String) {
    if (val == null) {
      return true;
    } else {
      var parsed = double.parse(val, (e) => null);
      return parsed != null && parsed != double.NAN && parsed != double.INFINITY
          && parsed != double.NEGATIVE_INFINITY;
    }
  } else {
    return false;
  }
}

String formatNumber(String val, int prec, int groupsize, String groupsep,
    String decsep) {
  int p, i;
  List result;
  double numVal;
  if (val == null) {
    numVal = 0.0;
  } else {
    numVal = double.parse(val, (e) => null);
  }
  if (numVal == null) {
    numVal = 0.0;
  }

  result = (prec == 0 || prec == null ? numVal.round().toString() :
      numVal.toStringAsFixed(prec)).split('');
  p = ((p = result.indexOf('.')) < 0) ? result.length : p;
  if (p < result.length) {
    result[p] = decsep;
  }
  for (i = p - groupsize; i > 0; i -= groupsize) {
    result.insert(i, groupsep);
  }
  return result.join('');
}

//// determine if all values of an array match a value
//// returns true if the array is empty
//all = function (val, arr, ignoreNull) {
//    var i;
//    for (i = arr.length; i--; ) {
//        if (ignoreNull && arr[i] === null) continue;
//        if (arr[i] !== val) {
//            return false;
//        }
//    }
//    return true;
//};

//// sums the numeric values in an array, ignoring other values
//sum = function (vals) {
//    var total = 0, i;
//    for (i = vals.length; i--;) {
//        total += typeof vals[i] === 'number' ? vals[i] : 0;
//    }
//    return total;
//};

List ensureArray (dynamic val) {
  return val is List ? val : [val];
}

// http://paulirish.com/2008/bookmarklet-inject-new-css-rules/
void addCSS (dom.ShadowRoot element, String css) {
  dom.StyleElement tag = new dom.StyleElement();
  tag.type = 'text/css';
  element.innerHtml = css;
  element.append(tag);
}

