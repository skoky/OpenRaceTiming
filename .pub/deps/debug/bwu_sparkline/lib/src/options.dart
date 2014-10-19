library bwu_sparkline.options;

import 'dart:collection' as coll;

import 'options_base.dart';
import 'options_extended.dart';
import 'tooltip_options_extended.dart';

export 'options_base.dart';

/**
 * Default configuration settings
 */

typedef String NumberFormatterFn(String val);

const String BAR_TYPE = 'bar';
const String BOX_TYPE = 'box';
const String BULLET_TYPE = 'bullet';
const String DISCRETE_TYPE = 'discrete';
const String LINE_TYPE = 'line';
const String PIE_TYPE = 'pie';
const String TRISTATE_TYPE = 'tristate';


abstract class Options extends OptionsBase {

  factory Options.forType([String type, initialized = false]) {
    switch(type) {
      case BAR_TYPE:
        if(initialized) return new BarOptions();
        return new BarOptions.uninitialized();
      case BOX_TYPE:
        if(initialized)return new BoxOptions();
        return new BoxOptions.uninitialized();
      case BULLET_TYPE:
        if(initialized) return new BulletOptions();
        return new BulletOptions.uninitialized();
      case DISCRETE_TYPE:
        if(initialized) return new DiscreteOptions();
        return new DiscreteOptions.uninitialized();
      case LINE_TYPE:
        if(initialized) return new LineOptions();
        return new LineOptions.uninitialized();
      case PIE_TYPE:
        if(initialized) return new PieOptions();
        return new PieOptions.uninitialized();
      case TRISTATE_TYPE:
        if(initialized) return new TristateOptions();
        return new TristateOptions.uninitialized();
      default:
        if(initialized) return new LineOptions();
        return new LineOptions.uninitialized();
    }
  }

  // Settings common to most/all chart types

  static const TYPE = 'type';
  static const LINE_COLOR = 'lineColor';
  static const FILL_COLOR ='fillColor';
  static const DEFAULT_PIXELS_PER_VALUE = 'defaultPixelsPerValue';
  static const WIDTH ='width'; // null is 'auto'
  static const HEIGHT = 'height'; // null is 'auto'
  static const COMPOSITE = 'composite';
  static const TAG_VALUES_ATTRIBUTE = 'tagValuesAttribute';
  static const TAG_OPTIONS_PREFIX = 'tagOptionsPrefix';
  static const ENABLE_TAG_OPTIONS = 'enableTagOptions';
  static const ENABLE_HIGHLIGHT = 'enableHighlight';
  static const HIGHLIGHT_COLOR = 'highlightColor';
  static const HIGHLIGHT_LIGHTEN = 'highlightLighten';
  static const DISABLE_HIDDEN_CHECK = 'disableHiddenCheck';
  static const NUMBER_FORMATTER = 'numberFormatter';
  static const NUMBER_DIGIT_GROUP_COUNT = 'numberDigitGroupCount';
  static const NUMBER_DIGIT_GROUP_SEP = 'numberDigitGroupSep';
  static const NUMBER_DECIMAL_MARK = 'numberDecimalMark';
  static const DISABLE_TOOLTIPS = 'disableTooltips';
  static const DISABLE_INTERACTIONS = 'disableInteraction';
  static const TOOLTIP = 'tooltip';
  static const VALUES = 'values';

  Options() : super();
  Options.uninitialized() : super.uninitialized();

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
       TYPE,
       LINE_COLOR,
       FILL_COLOR,
       DEFAULT_PIXELS_PER_VALUE,
       WIDTH,
       HEIGHT,
       COMPOSITE,
       TAG_VALUES_ATTRIBUTE,
       TAG_OPTIONS_PREFIX,
       ENABLE_TAG_OPTIONS,
       ENABLE_HIGHLIGHT,
       HIGHLIGHT_COLOR,
       HIGHLIGHT_LIGHTEN,
       DISABLE_HIDDEN_CHECK,
       NUMBER_FORMATTER,
       NUMBER_DIGIT_GROUP_COUNT,
       NUMBER_DIGIT_GROUP_SEP,
       NUMBER_DECIMAL_MARK,
       DISABLE_TOOLTIPS,
       DISABLE_INTERACTIONS,
       TOOLTIP,
       VALUES
       ];

  final Map _defaults = {
    TYPE: LINE_TYPE,
    LINE_COLOR : '#00f',
    FILL_COLOR : '#cdf',
    DEFAULT_PIXELS_PER_VALUE : 3,
    COMPOSITE : false,
    TAG_VALUES_ATTRIBUTE : 'values',
    TAG_OPTIONS_PREFIX : 'spark',
    ENABLE_TAG_OPTIONS : false,
    ENABLE_HIGHLIGHT : true,
    HIGHLIGHT_LIGHTEN : 1.4,
    DISABLE_HIDDEN_CHECK : false,
    NUMBER_DIGIT_GROUP_COUNT : 3,
    NUMBER_DIGIT_GROUP_SEP : ',',
    NUMBER_DECIMAL_MARK : '.',
    DISABLE_TOOLTIPS : false,
    DISABLE_INTERACTIONS : false
  };

  String get type => this[TYPE];
  //set type(String val) => this[TYPE] = val;

  String get lineColor => this[LINE_COLOR];
  set lineColor(String val) => this[LINE_COLOR] = val;

  String get fillColor => this[FILL_COLOR];
  set fillColor(String val) => this[FILL_COLOR] = val;

  int get defaultPixelsPerValue => this[DEFAULT_PIXELS_PER_VALUE];
  set defaultPixelsPerValue(int val) => this[DEFAULT_PIXELS_PER_VALUE] = val;

  String get width => this[WIDTH]; // null is 'auto'
  set width(String val) => this[WIDTH] = val; // null is 'auto'

  String get height => this[HEIGHT]; // null is 'auto'
  set height(String val) => this[HEIGHT] = val; // null is 'auto'

  bool get composite => this[COMPOSITE];
  set composite(bool val) => this[COMPOSITE] = val;

  String get tagValuesAttribute => this[TAG_VALUES_ATTRIBUTE];
  set tagValuesAttribute(String val) => this[TAG_VALUES_ATTRIBUTE] = val;

  String get tagOptionsPrefix => this[TAG_OPTIONS_PREFIX];
  set tagOptionsPrefix(String val) => this[TAG_OPTIONS_PREFIX] = val;

  bool get enableTagOptions => this[ENABLE_TAG_OPTIONS];
  set enableTagOptions(bool val) => this[ENABLE_TAG_OPTIONS] = val;

  bool get enableHighlight => this[ENABLE_HIGHLIGHT];
  set enableHighlight(bool val) => this[ENABLE_HIGHLIGHT] = val;

  String get highlightColor => this[HIGHLIGHT_COLOR];
  set highlightColor(String val) => this[HIGHLIGHT_COLOR] = val;

  double get highlightLighten => this[HIGHLIGHT_LIGHTEN];
  set highlightLighten(double val) => this[HIGHLIGHT_LIGHTEN] = val;

  bool get disableHiddenCheck => this[DISABLE_HIDDEN_CHECK];
  set disableHiddenCheck(bool val) => this[DISABLE_HIDDEN_CHECK] = val;

  NumberFormatterFn get numberFormatter => this[NUMBER_FORMATTER];
  set numberFormatter(NumberFormatterFn val) => this[NUMBER_FORMATTER] = val;

  int get numberDigitGroupCount => this[NUMBER_DIGIT_GROUP_COUNT];
  set numberDigitGroupCount(int val) => this[NUMBER_DIGIT_GROUP_COUNT] = val;

  String get numberDigitGroupSep => this[NUMBER_DIGIT_GROUP_SEP];
  set numberDigitGroupSep(String val) => this[NUMBER_DIGIT_GROUP_SEP] = val;

  String get numberDecimalMark => this[NUMBER_DECIMAL_MARK];
  set numberDecimalMark(String val) => this[NUMBER_DECIMAL_MARK] = val;

  bool get disableTooltips => this[DISABLE_TOOLTIPS];
  set disableTooltips(bool val) => this[DISABLE_TOOLTIPS] = val;

  bool get disableInteraction => this[DISABLE_INTERACTIONS];
  set disableInteraction(bool val) => this[DISABLE_INTERACTIONS] = val;

  Tooltip get tooltip => this[TOOLTIP];
  set tooltip(Tooltip val) => this[TOOLTIP] = val;

  List get values => this[VALUES];
  set values(List val) => this[VALUES] = val;

  @override
  dynamic operator [](String key) {
    if(!_keys.contains(key)) {
      return super[key];
    }
    return _v[key];
  }

  @override
  void operator []=(String key, val) {
    if(key == TYPE) return;
    if(!_keys.contains(key)) {
      super[key] = val;
    }
    _v[key] = val;
  }
}


