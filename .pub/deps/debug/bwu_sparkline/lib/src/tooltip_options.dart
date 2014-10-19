library bwu_sparkline.tooltip_options;

import 'dart:html' as dom;
import 'dart:collection' as coll;

import 'options_base.dart';
import 'options.dart';
import 'sp_format.dart';

typedef String TooltipFormatterFn(BwuSparkline, Options options, List<Map> fields);

class Tooltip extends OptionsBase {
  static const SKIP_NULL = 'skipNull';
  static const PREFIX = 'prefix';
  static const SUFFIX = 'suffix';
  static const CSS_CLASS = 'cssClass';
  static const CONTAINER = 'container';
  static const FORMATS = 'formats';
  static const OFFSET_X = 'offsetX';
  static const OFFSET_Y = 'offsetY';
  static const FORMATTER = 'formatter';
  static const CHART_TITLE = 'chartTitle';

  Tooltip() : super();
  Tooltip.uninitialized() : super.uninitialized();

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
    SKIP_NULL,
    PREFIX,
    SUFFIX,
    CSS_CLASS,
    CONTAINER,
    FORMATS,
    OFFSET_X,
    OFFSET_Y,
    FORMATTER,
    CHART_TITLE
  ];

  final Map _defaults = {
    SKIP_NULL : true,
    PREFIX : '',
    SUFFIX : '',
    CSS_CLASS : 'jqstooltip',
    OFFSET_X : 10,
    OFFSET_Y : 12
  };

  bool get skipNull => this[SKIP_NULL];
  set skipNull(bool val) => this[SKIP_NULL];

  String get prefix => this[PREFIX];
  set prefix(String val) => this[PREFIX];

  String get suffix => this[SUFFIX];
  set suffix(String val) => this[SUFFIX];

  String get cssClass => this[CSS_CLASS];
  set cssClass(String val) => this[CSS_CLASS];

  dom.HtmlElement get container => this[CONTAINER];
  set container(dom.HtmlElement val) => this[CONTAINER];

  List<SPFormat> get formats => this[FORMATS];
  set formats(List<SPFormat> val) => this[FORMATS];

  int get offsetX => this[OFFSET_X];
  set offsetX(int val) => this[OFFSET_X];

  int get offsetY => this[OFFSET_Y];
  set offsetY(int val) => this[OFFSET_Y];

  TooltipFormatterFn get formatter => this[FORMATTER];
  set formatter(TooltipFormatterFn val) => this[FORMATTER];

  String get chartTitle => this[CHART_TITLE];
  set chartTitle(String val) => this[CHART_TITLE];

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

