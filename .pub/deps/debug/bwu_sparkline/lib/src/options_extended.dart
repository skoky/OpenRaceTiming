library bwu_sparkline.options_extended;

import 'dart:collection' as coll;
import 'options.dart';
import 'tooltip_options_extended.dart';

export 'options.dart';
export 'tooltip_options_extended.dart';

// Defaults for line charts
class LineOptions extends Options {
  static const SPOT_COLOR = 'spotColor';
  static const HIGLIGHT_SPOT_COLOR = 'highlightSpotColor';
  static const HIGHLIGHT_LINE_COLOR = 'highlightLineColor';
  static const SPOT_RADIUS = 'spotRadius';
  static const MIN_SPOT_COLOR = 'minSpotColor';
  static const MAX_SPOT_COLOR = 'maxSpotColor';
  static const LINE_WIDTH = 'lineWidth';
  static const NORMAL_RANGE_MIN = 'normalRangeMin';
  static const NORMAL_RANGE_MAX = 'normalRangeMax';
  static const NORMAL_RANGE_COLOR = 'normalRangeColor';
  static const DRAW_NORMAL_ON_TOP = 'drawNormalOnTop';
  static const CHART_RANGE_MIN = 'chartRangeMin';
  static const CHART_RANGE_MAX = 'chartRangeMax';
  static const CHART_RANGE_MIN_X = 'chartRangeMinX';
  static const CHART_RANGE_MAX_X = 'chartRangeMaxX';
  static const CHART_RANGE_CLIP = 'chartRangeClip';
  static const CHART_RANGE_CLIP_X = 'chartRangeClipX';
  static const X_VALUES = 'xValues';
  static const VALUE_SPOTS = 'valueSpots';

  LineOptions() : super();
  LineOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [
    Options.TYPE,
    Options.TOOLTIP,
    SPOT_COLOR,
    HIGLIGHT_SPOT_COLOR,
    HIGHLIGHT_LINE_COLOR,
    SPOT_RADIUS,
    MIN_SPOT_COLOR,
    MAX_SPOT_COLOR,
    LINE_WIDTH,
    NORMAL_RANGE_MIN,
    NORMAL_RANGE_MAX,
    NORMAL_RANGE_COLOR,
    DRAW_NORMAL_ON_TOP,
    CHART_RANGE_MIN,
    CHART_RANGE_MAX,
    CHART_RANGE_MIN_X,
    CHART_RANGE_MAX_X,
    CHART_RANGE_CLIP,
    CHART_RANGE_CLIP_X,
    X_VALUES,
    VALUE_SPOTS
  ];

  final Map _defaults = {
    Options.TYPE : LINE_TYPE,
    SPOT_COLOR : '#f80',
    HIGLIGHT_SPOT_COLOR : '#5f5',
    HIGHLIGHT_LINE_COLOR : '#f22',
    SPOT_RADIUS : 1.5,
    MIN_SPOT_COLOR : '#f80',
    MAX_SPOT_COLOR : '#f80',
    LINE_WIDTH : 1,
    NORMAL_RANGE_COLOR : '#ccc',
    DRAW_NORMAL_ON_TOP : false,
    Options.TOOLTIP : new LineChartTooltipOptions()
  };

  String get spotColor => this[SPOT_COLOR];
  set spotColor(String val) => this[SPOT_COLOR] = val;

  String get highlightSpotColor => this[HIGLIGHT_SPOT_COLOR];
  set highlightSpotColor(String val) => this[HIGLIGHT_SPOT_COLOR] = val;

  String get highlightLineColor => this[HIGHLIGHT_LINE_COLOR];
  set highlightLineColor(String val) => this[HIGHLIGHT_LINE_COLOR] = val;

  double get spotRadius => this[SPOT_RADIUS];
  set spotRadius(double val) => this[SPOT_RADIUS] = val;

  String get minSpotColor => this[MIN_SPOT_COLOR];
  set minSpotColor(String val) => this[MIN_SPOT_COLOR] = val;

  String get maxSpotColor => this[MAX_SPOT_COLOR];
  set maxSpotColor(String val) => this[MAX_SPOT_COLOR] = val;

  int get lineWidth => this[LINE_WIDTH];
  set lineWidth(int val) => this[LINE_WIDTH] = val;

  int get normalRangeMin => this[NORMAL_RANGE_MIN];
  set normalRangeMin(int val) => this[NORMAL_RANGE_MIN] = val;

  int get normalRangeMax => this[NORMAL_RANGE_MAX];
  set normalRangeMax(int val) => this[NORMAL_RANGE_MAX] = val;

  String get normalRangeColor => this[NORMAL_RANGE_COLOR];
  set normalRangeColor(String val) => this[NORMAL_RANGE_COLOR] = val;

  bool get drawNormalOnTop => this[DRAW_NORMAL_ON_TOP];
  set drawNormalOnTop(bool val) => this[DRAW_NORMAL_ON_TOP] = val;

  int get chartRangeMin => this[CHART_RANGE_MIN];
  set chartRangeMin(int val) => this[CHART_RANGE_MIN] = val;

  int get chartRangeMax => this[CHART_RANGE_MAX];
  set chartRangeMax(int val) => this[CHART_RANGE_MAX] = val;

  int get chartRangeMinX => this[CHART_RANGE_MIN_X];
  set chartRangeMinX(int val) => this[CHART_RANGE_MIN_X] = val;

  int get chartRangeMaxX => this[CHART_RANGE_MAX_X];
  set chartRangeMaxX(int val) => this[CHART_RANGE_MAX_X] = val;

  bool get chartRangeClip => this[CHART_RANGE_CLIP];
  set chartRangeClip(bool val) => this[CHART_RANGE_CLIP] = val;

  int get chartRangeClipX => this[CHART_RANGE_CLIP_X];
  set chartRangeClipX(int val) => this[CHART_RANGE_CLIP_X] = val;

  List<num> get xValues => this[X_VALUES];
  set xValues(List<num> val) => this[X_VALUES] = val;

  // a List with two values and a color [val, val, color]
  List<List> get valueSpots => this[VALUE_SPOTS];
  set valueSpots(List<List> val) => this[VALUE_SPOTS] = val;

  LineChartTooltipOptions get tooltip => this[Options.TOOLTIP];

  @override
  dynamic operator [](String key) {
    if(!_keys.contains(key)) {
      return super[key];
    }
    return _v[key];
  }

  @override
  void operator []=(String key, val) {
    if(!_keys.contains(key)) {
      super[key] = val;
    }
    _v[key] = val;
  }
}


// Defaults for bar charts
class BarOptions extends Options {
  static const BAR_COLOR = 'barColor';
  static const NEG_BAR_COLOR = 'negBarColor';
  static const STACKED_BAR_COLOR = 'stackedBarColor';
  static const ZERO_COLOR = 'zeroColor';
  static const NULL_COLOR = 'nullColor';
  static const ZERO_AXIS = 'zeroAxis';
  static const BAR_WIDTH = 'barWidth';
  static const BAR_SPACING = 'barSpacing';
  static const CHART_RANGE_MAX = 'chartRangeMax';
  static const CHART_RANGE_MIN = 'chartRangeMin';
  static const CHART_RANGE_CLIP = 'chartRangeClip';
  static const COLOR_MAP = 'colorMap';
  static const COLOR_LIST = 'colorList';

  BarOptions() : super();
  BarOptions.uninitialized() : super.uninitialized();

  @override
   void optionsInitDefaults() {
     super.optionsInitDefaults();
     _v.addAll(_defaults);
   }

   final Map _v = {};

   @override
   List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

   @override
   Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

   @override
   Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);



  final List<String> _keys = [
    Options.TYPE,
    Options.TOOLTIP,
    BAR_COLOR,
    NEG_BAR_COLOR,
    STACKED_BAR_COLOR,
    ZERO_COLOR,
    NULL_COLOR,
    ZERO_AXIS,
    BAR_WIDTH,
    BAR_SPACING,
    CHART_RANGE_MAX,
    CHART_RANGE_MIN,
    CHART_RANGE_CLIP,
    COLOR_MAP
  ];

  final Map _defaults = {
    Options.TYPE: BAR_TYPE,
    BAR_COLOR : '#3366cc',
    NEG_BAR_COLOR : '#f44',
    STACKED_BAR_COLOR : ['#3366cc', '#dc3912', '#ff9900', '#109618', '#66aa00',
        '#dd4477', '#0099c6', '#990099'],
    ZERO_AXIS : true,
    BAR_WIDTH : 4,
    BAR_SPACING : 1,
    CHART_RANGE_CLIP : false,
    Options.TOOLTIP : new BarChartTooltipOptions()
  };

  String get barColor => this[BAR_COLOR];
  set barColor(String val) => this[BAR_COLOR] = val;

  String get negBarColor => this[NEG_BAR_COLOR];
  set negBarColor(String val) => this[NEG_BAR_COLOR] = val;

  String get stackedBarColor => this[STACKED_BAR_COLOR];
  set stackedBarColor(String val) => this[STACKED_BAR_COLOR] = val;

  String get zeroColor => this[ZERO_COLOR];
  set zeroColor(String val) => this[ZERO_COLOR] = val;

  String get nullColor => this[NULL_COLOR];
  set nullColor(String val) => this[NULL_COLOR] = val;

  bool get zeroAxis => this[ZERO_AXIS];
  set zeroAxis(bool val) => this[ZERO_AXIS] = val;

  int get barWidth => this[BAR_WIDTH];
  set barWidth(int val) => this[BAR_WIDTH] = val;

  int get barSpacing => this[BAR_SPACING];
  set barSpacing(int val) => this[BAR_SPACING] = val;

  int get chartRangeMax => this[CHART_RANGE_MAX];
  set chartRangeMax(int val) => this[CHART_RANGE_MAX] = val;

  int get chartRangeMin => this[CHART_RANGE_MIN];
  set chartRangeMin(int val) => this[CHART_RANGE_MIN] = val;

  bool get chartRangeClip => this[CHART_RANGE_CLIP];
  set chartRangeClip(bool val) => this[CHART_RANGE_CLIP] = val;

  // a list of Lists [[fromVal, toVal, color], [..], ...]
  List<List> get colorMap => this[COLOR_MAP];
  set colorMap(List val) => this[COLOR_MAP] = val;

  // a list colors // either colorMap or colorList can be used but not both
  List get colorList => this[COLOR_MAP];
  set colorList(List val) => this[COLOR_MAP] = val;

  BarChartTooltipOptions get tooltip => this[Options.TOOLTIP];

  @override
  dynamic operator [](String key) {
    if(!_keys.contains(key)) {
      return super[key];
    }
    return _v[key];
  }

  @override
  void operator []=(String key, val) {
    if(!_keys.contains(key)) {
      super[key] = val;
    }
    _v[key] = val;
  }
}

            // Defaults for tristate charts
class TristateOptions extends Options {
  static const BAR_WIDTH = 'barWidth';
  static const BAR_SPACING = 'barSpacing';
  static const POS_BAR_COLOR = 'posBarColor';
  static const NEG_BAR_COLOR = 'negBarColor';
  static const ZERO_BAR_COLOR = 'zeroBarColor';
  static const COLOR_MAP = 'colorMap';
  static const COLOR_LIST = 'colorList';

  TristateOptions() : super();
  TristateOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [
    Options.TYPE,
    Options.TOOLTIP,
    BAR_WIDTH,
    BAR_SPACING,
    POS_BAR_COLOR,
    NEG_BAR_COLOR,
    ZERO_BAR_COLOR,
    COLOR_MAP
  ];

  final Map _defaults = {
    Options.TYPE: TRISTATE_TYPE,
    BAR_WIDTH : 4,
    BAR_SPACING : 1,
    POS_BAR_COLOR : '#6f6',
    NEG_BAR_COLOR : '#f44',
    ZERO_BAR_COLOR : '#999',
    Options.TOOLTIP : new TristateChartTooltipOptions()
  };

  int get barWidth => this[BAR_WIDTH];
  set barWidth(int val) => this[BAR_WIDTH] = val;

  int get barSpacing => this[BAR_SPACING];
  set barSpacing(int val) => this[BAR_SPACING] = val;

  String get posBarColor => this[POS_BAR_COLOR];
  set posBarColor(String val) => this[POS_BAR_COLOR] = val;

  String get negBarColor => this[NEG_BAR_COLOR];
  set negBarColor(String val)  => this[NEG_BAR_COLOR] = val;

  String get zeroBarColor => this[ZERO_BAR_COLOR];
  set zeroBarColor(String val)  => this[ZERO_BAR_COLOR] = val;

  // a list of Lists [[fromVal, toVal, color], [..], ...]
  List<List> get colorMap => this[COLOR_MAP];
  set colorMap(List val) => this[COLOR_MAP] = val;

  // a list colors // either colorMap or colorList can be used but not both
  List get colorList => this[COLOR_MAP];
  set colorList(List val) => this[COLOR_MAP] = val;

  TristateChartTooltipOptions get tooltip => this[Options.TOOLTIP];

  @override
  dynamic operator [](String key) {
    if(!_keys.contains(key)) {
      return super[key];
    }
    return _v[key];
  }

  @override
  void operator []=(String key, val) {
    if(!_keys.contains(key)) {
      super[key] = val;
    }
    _v[key] = val;
  }
}


// Defaults for discrete charts
class DiscreteOptions extends Options {
  static const LINE_HEIGHT = 'lineHeight';
  static const THRESHOLD_COLOR = 'thresholdColor';
  static const THRESHOLD_VALUE = 'thresholdValue';
  static const CHART_RANGE_MAX = 'chartRangeMax';
  static const CHART_RANGE_MIN = 'chartRangeMin';
  static const CHART_RANGE_CLIP = 'chartRangeClip';

  DiscreteOptions() : super();
  DiscreteOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [
    Options.TYPE,
    Options.TOOLTIP,
    LINE_HEIGHT,
    THRESHOLD_COLOR,
    THRESHOLD_VALUE,
    CHART_RANGE_MAX,
    CHART_RANGE_MIN,
    CHART_RANGE_CLIP
  ];

  final Map _defaults = {
    Options.TYPE: DISCRETE_TYPE,
    LINE_HEIGHT : 'auto',
    THRESHOLD_VALUE : 0,
    CHART_RANGE_CLIP : false,
    Options.TOOLTIP : new DiscreteChartTooltipOptions()
  };

  int get lineHeight => this[LINE_HEIGHT];
  set lineHeight(int val) => this[LINE_HEIGHT] = val;

  String get thresholdColor => this[THRESHOLD_COLOR];
  set thresholdColor(String val) => this[THRESHOLD_COLOR] = val;

  int get thresholdValue => this[THRESHOLD_VALUE];
  set thresholdValue(int val) => this[THRESHOLD_VALUE] = val;

  int get chartRangeMax => this[CHART_RANGE_MAX];
  set chartRangeMax(int val) => this[CHART_RANGE_MAX] = val;

  int get chartRangeMin => this[CHART_RANGE_MIN];
  set chartRangeMin(int val) => this[CHART_RANGE_MIN] = val;

  bool get chartRangeClip => this[CHART_RANGE_CLIP];
  set chartRangeClip(bool val) => this[CHART_RANGE_CLIP] = val;

  DiscreteChartTooltipOptions get tooltip => this[Options.TOOLTIP];

  @override
  dynamic operator [](String key) {
    if(!_keys.contains(key)) {
      return super[key];
    }
    return _v[key];
  }

  @override
  void operator []=(String key, val) {
    if(!_keys.contains(key)) {
      super[key] = val;
    }
    _v[key] = val;
  }
}

// Defaults for bullet charts
class BulletOptions extends Options {
  static const TARGET_COLOR = 'targetColor';
  static const TARGET_WIDTH = 'targetWidth'; // width of the target bar in pixels
  static const PERFORMANCE_COLOR = 'performanceColor';
  static const RANGE_COLORS = 'rangeColors';
  static const BASE = 'base'; // set this to a number to change the base start number

  BulletOptions() : super();
  BulletOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [
    Options.TYPE,
    Options.TOOLTIP,
    TARGET_COLOR,
    TARGET_WIDTH,
    PERFORMANCE_COLOR,
    RANGE_COLORS,
    BASE
  ];

  final Map _defaults = {
    Options.TYPE: BULLET_TYPE,
    TARGET_COLOR : '#f33',
    TARGET_WIDTH : 3,
    PERFORMANCE_COLOR : '#33f',
    RANGE_COLORS : ['#d3dafe', '#a8b6ff', '#7f94ff'],
    Options.TOOLTIP : new BulletChartTooltipOptions()
  };

  String get targetColor => this[TARGET_COLOR];
  set targetColor(String val) => this[TARGET_COLOR] = val;

  int get targetWidth => this[TARGET_WIDTH];
  set targetWidth(int val) => this[TARGET_WIDTH] = val;

  String get performanceColor => this[PERFORMANCE_COLOR];
  set performanceColor(String val) => this[PERFORMANCE_COLOR] = val;

  List<String> get rangeColors => this[RANGE_COLORS];
  set rangeColors(List<String> val) => this[RANGE_COLORS] = val;

  int get base => this[BASE];
  set base(int val) => this[BASE] = val;

  BulletChartTooltipOptions get tooltip => this[Options.TOOLTIP];

  @override
  dynamic operator [](String key) {
    if(!_keys.contains(key)) {
      return super[key];
    }
    return _v[key];
  }

  @override
  void operator []=(String key, val) {
    if(!_keys.contains(key)) {
      super[key] = val;
    }
    _v[key] = val;
  }
}

// Defaults for pie charts
class PieOptions extends Options {
  static const OFFSET = 'offset';
  static const SLICE_COLORS = 'sliceColors';
  static const BORDER_WIDTH = 'borderWidth';
  static const BORDER_COLOR = 'borderColor';

  PieOptions() : super();
  PieOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [
    Options.TYPE,
    Options.TOOLTIP,
    OFFSET,
    SLICE_COLORS,
    BORDER_WIDTH,
    BORDER_COLOR
  ];

  final Map _defaults = {
    Options.TYPE: PIE_TYPE,
    OFFSET : 0,
    SLICE_COLORS : const ['#3366cc', '#dc3912', '#ff9900', '#109618', '#66aa00',
        '#dd4477', '#0099c6', '#990099'],
    BORDER_WIDTH : 0,
    BORDER_COLOR : '#000',
    Options.TOOLTIP : new PieChartTooltipOptions()
  };

  int get offset => this[OFFSET];
  set offset(int val) => this[OFFSET] = val;

  List<String> get sliceColors => this[SLICE_COLORS];
  set sliceColors(List<String> val) => this[SLICE_COLORS] = val;

  int get borderWidth => this[BORDER_WIDTH];
  set borderWidth(int val) => this[BORDER_WIDTH] = val;

  String get borderColor => this[BORDER_COLOR];
  set borderColor(String val) => this[BORDER_COLOR] = val;

  PieChartTooltipOptions get tooltip => this[Options.TOOLTIP];

  @override
  dynamic operator [](String key) {
    if(!_keys.contains(key)) {
      return super[key];
    }
    return _v[key];
  }

  @override
  void operator []=(String key, val) {
    if(!_keys.contains(key)) {
      super[key] = val;
    }
    _v[key] = val;
  }
}

// Defaults for box plots
class BoxOptions extends Options {
  static const RAW = 'raw';
  static const BOX_LINE_COLOR = 'boxLineColor';
  static const BOX_FILL_COLOR = 'boxFillColor';
  static const WHISKER_COLOR = 'whiskerColor';
  static const OUTLIER_LINE_COLOR = 'outlierLineColor';
  static const OUTLIER_FILL_COLOR = 'outlierFillColor';
  static const MEDIAN_COLOR = 'medianColor';
  static const SHOW_OUTLIERS = 'showOutliers';
  static const OUTLIER_IQR = 'outlierIQR';
  static const SPOT_RADIUS = 'spotRadius';
  static const TARGET = 'target';
  static const TARGET_COLOR = 'targetColor';
  static const CHART_RANGE_MAX = 'chartRangeMax';
  static const CHART_RANGE_MIN = 'chartRangeMin';

  BoxOptions() : super();
  BoxOptions.uninitialized() : super.uninitialized();

  @override
  void optionsInitDefaults() {
    super.optionsInitDefaults();
    _v.addAll(_defaults);
  }

  final Map _v = {};

  @override
  List<String> get optionKeys => new coll.UnmodifiableListView(new List<String>.from(_keys)..addAll(super.optionKeys));

  @override
  Map get optionValues => new coll.UnmodifiableMapView(new Map.from(_v)..addAll(super.optionValues));

  @override
  Map get optionDefaults => new coll.UnmodifiableMapView(_defaults);

  final List<String> _keys = [
    Options.TYPE,
    Options.TOOLTIP,
    RAW,
    BOX_LINE_COLOR,
    BOX_FILL_COLOR,
    WHISKER_COLOR,
    OUTLIER_LINE_COLOR,
    OUTLIER_FILL_COLOR,
    MEDIAN_COLOR,
    SHOW_OUTLIERS,
    OUTLIER_IQR,
    SPOT_RADIUS,
    TARGET,
    TARGET_COLOR,
    CHART_RANGE_MAX,
    CHART_RANGE_MIN
  ];

  final Map _defaults = {
    Options.TYPE: BOX_TYPE,
    RAW : false,
    BOX_LINE_COLOR : '#000',
    BOX_FILL_COLOR : '#cdf',
    WHISKER_COLOR : '#000',
    OUTLIER_LINE_COLOR : '#333',
    OUTLIER_FILL_COLOR : '#fff',
    MEDIAN_COLOR : '#f00',
    SHOW_OUTLIERS : true,
    OUTLIER_IQR : 1.5,
    SPOT_RADIUS : 1.5,
    TARGET_COLOR : '#4a2',
    Options.TOOLTIP : new BoxChartTooltipOptions()
  };

  bool get raw => this[RAW];
  set raw(bool val) => this[RAW];

  String get boxLineColor => this[BOX_LINE_COLOR];
  set boxLineColor(String val) => this[BOX_LINE_COLOR];

  String get boxFillColor => this[BOX_FILL_COLOR];
  set boxFillColor(String val) => this[BOX_FILL_COLOR];

  String get whiskerColor => this[WHISKER_COLOR];
  set whiskerColor(String val) => this[WHISKER_COLOR];

  String get outlierLineColor => this[OUTLIER_LINE_COLOR];
  set outlierLineColor(String val) => this[OUTLIER_LINE_COLOR];

  String get outlierFillColor => this[OUTLIER_FILL_COLOR];
  set outlierFillColor(String val) => this[OUTLIER_FILL_COLOR];

  String get medianColor => this[MEDIAN_COLOR];
  set medianColor(String val) => this[MEDIAN_COLOR];

  bool get showOutliers => this[SHOW_OUTLIERS];
  set showOutliers(bool val) => this[SHOW_OUTLIERS];

  double get outlierIQR => this[OUTLIER_IQR];
  set outlierIQR(double val) => this[OUTLIER_IQR];

  double get spotRadius => this[SPOT_RADIUS];
  set spotRadius(double val) => this[SPOT_RADIUS];

  int get target => this[TARGET];
  set target(int val) => this[TARGET];

  String get targetColor => this[TARGET_COLOR];
  set targetColor(String val) => this[TARGET_COLOR];

  int get chartRangeMax => this[CHART_RANGE_MAX];
  set chartRangeMax(int val) => this[CHART_RANGE_MAX];

  int get chartRangeMin => this[CHART_RANGE_MIN];
  set chartRangeMin(int val) => this[CHART_RANGE_MIN];

  BoxChartTooltipOptions get tooltip => this[Options.TOOLTIP];

  @override
  dynamic operator [](String key) {
    if(!_keys.contains(key)) {
      return super[key];
    }
    return _v[key];
  }

  @override
  void operator []=(String key, val) {
    if(!_keys.contains(key)) {
      super[key] = val;
    }
    _v[key] = val;
  }
}
