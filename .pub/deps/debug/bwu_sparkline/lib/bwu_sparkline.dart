/**
*
* jquery.sparkline.js
*
* v2.1.2
* (c) Splunk, Inc
* Contact: Gareth Watts (gareth@splunk.com)
* http://omnipotent.net/jquery.sparkline/
*
* Generates inline sparkline charts from data supplied either to the method
* or inline in HTML
*
* Compatible with Internet Explorer 6.0+ and modern browsers equipped with the canvas tag
* (Firefox 2.0+, Safari, Opera, etc)
*
* License: New BSD License
*
* Copyright (c) 2012, Splunk Inc.
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without modification,
* are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright notice,
*       this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright notice,
*       this list of conditions and the following disclaimer in the documentation
*       and/or other materials provided with the distribution.
*     * Neither the name of Splunk Inc nor the names of its contributors may
*       be used to endorse or promote products derived from this software without
*       specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
* OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
* SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
* SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
* OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
* HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
* OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*
* Usage:
*  $(selector).sparkline(values, options)
*
* If values is undefined or set to 'html' then the data values are read from the specified tag:
*   <p>Sparkline: <span class="sparkline">1,4,6,6,8,5,3,5</span></p>
*   $('.sparkline').sparkline();
* There must be no spaces in the enclosed data set
*
* Otherwise values must be an array of numbers or null values
*    <p>Sparkline: <span id="sparkline1">This text replaced if the browser is compatible</span></p>
*    $('#sparkline1').sparkline([1,4,6,6,8,5,3,5])
*    $('#sparkline2').sparkline([1,4,6,null,null,5,3,5])
*
* Values can also be specified in an HTML comment, or as a values attribute:
*    <p>Sparkline: <span class="sparkline"><!--1,4,6,6,8,5,3,5 --></span></p>
*    <p>Sparkline: <span class="sparkline" values="1,4,6,6,8,5,3,5"></span></p>
*    $('.sparkline').sparkline();
*
* For line charts, x values can also be specified:
*   <p>Sparkline: <span class="sparkline">1:1,2.7:4,3.4:6,5:6,6:8,8.7:5,9:3,10:5</span></p>
*    $('#sparkline1').sparkline([ [1,1], [2.7,4], [3.4,6], [5,6], [6,8], [8.7,5], [9,3], [10,5] ])
*
* By default, options should be passed in as teh second argument to the sparkline function:
*   $('.sparkline').sparkline([1,2,3,4], {type: 'bar'})
*
* Options can also be set by passing them on the tag itself.  This feature is disabled by default though
* as there's a slight performance overhead:
*   $('.sparkline').sparkline([1,2,3,4], {enableTagOptions: true})
*   <p>Sparkline: <span class="sparkline" sparkType="bar" sparkBarColor="red">loading</span></p>
* Prefix all options supplied as tag attribute with "spark" (configurable by setting tagOptionPrefix)
*
* Supported options:
*   lineColor - Color of the line used for the chart
*   fillColor - Color used to fill in the chart - Set to '' or false for a transparent chart
*   width - Width of the chart - Defaults to 3 times the number of values in pixels
*   height - Height of the chart - Defaults to the height of the containing element
*   chartRangeMin - Specify the minimum value to use for the Y range of the chart - Defaults to the minimum value supplied
*   chartRangeMax - Specify the maximum value to use for the Y range of the chart - Defaults to the maximum value supplied
*   chartRangeClip - Clip out of range values to the max/min specified by chartRangeMin and chartRangeMax
*   chartRangeMinX - Specify the minimum value to use for the X range of the chart - Defaults to the minimum value supplied
*   chartRangeMaxX - Specify the maximum value to use for the X range of the chart - Defaults to the maximum value supplied
*   composite - If true then don't erase any existing chart attached to the tag, but draw
*           another chart over the top - Note that width and height are ignored if an
*           existing chart is detected.
*   tagValuesAttribute - Name of tag attribute to check for data values - Defaults to 'values'
*   enableTagOptions - Whether to check tags for sparkline options
*   tagOptionPrefix - Prefix used for options supplied as tag attributes - Defaults to 'spark'
*   disableHiddenCheck - If set to true, then the plugin will assume that charts will never be drawn into a
*           hidden dom element, avoding a browser reflow
*   disableInteraction - If set to true then all mouseover/click interaction behaviour will be disabled,
*       making the plugin perform much like it did in 1.x
*   disableTooltips - If set to true then tooltips will be disabled - Defaults to false (tooltips enabled)
*  // TODO there is also an enableHighlight, settle for one
 * disableHighlight - If set to true then highlighting of selected chart elements on mouseover will be disabled
*       defaults to false (highlights enabled)
*   highlightLighten - Factor to lighten/darken highlighted chart values by - Defaults to 1.4 for a 40% increase
*   tooltipContainer - Specify which DOM element the tooltip should be rendered into - defaults to document.body
*   tooltipClassname - Optional CSS classname to apply to tooltips - If not specified then a default style will be applied
*   tooltipOffsetX - How many pixels away from the mouse pointer to render the tooltip on the X axis
*   tooltipOffsetY - How many pixels away from the mouse pointer to render the tooltip on the r axis
*   tooltipFormatter  - Optional callback that allows you to override the HTML displayed in the tooltip
*       callback is given arguments of (sparkline, options, fields)
*   tooltipChartTitle - If specified then the tooltip uses the string specified by this setting as a title
*   tooltipFormat - A format string or SPFormat object  (or an array thereof for multiple entries)
*       to control the format of the tooltip
*   tooltipPrefix - A string to prepend to each field displayed in a tooltip
*   tooltipSuffix - A string to append to each field displayed in a tooltip
*   tooltipSkipNull - If true then null values will not have a tooltip displayed (defaults to true)
*   tooltipValueLookups - An object or range map to map field values to tooltip strings
*       (eg. to map -1 to "Lost", 0 to "Draw", and 1 to "Win")
*   numberFormatter - Optional callback for formatting numbers in tooltips
*   numberDigitGroupSep - Character to use for group separator in numbers "1,234" - Defaults to ","
*   numberDecimalMark - Character to use for the decimal point when formatting numbers - Defaults to "."
*   numberDigitGroupCount - Number of digits between group separator - Defaults to 3
*
* There are 7 types of sparkline, selected by supplying a "type" option of 'line' (default),
* 'bar', 'tristate', 'bullet', 'discrete', 'pie' or 'box'
*    line - Line chart.  Options:
*       spotColor - Set to '' to not end each line in a circular spot
*       minSpotColor - If set, color of spot at minimum value
*       maxSpotColor - If set, color of spot at maximum value
*       spotRadius - Radius in pixels
*       lineWidth - Width of line in pixels
*       normalRangeMin
*       normalRangeMax - If set draws a filled horizontal bar between these two values marking the "normal"
*                      or expected range of values
*       normalRangeColor - Color to use for the above bar
*       drawNormalOnTop - Draw the normal range above the chart fill color if true
*       defaultPixelsPerValue - Defaults to 3 pixels of width for each value in the chart
*       highlightSpotColor - The color to use for drawing a highlight spot on mouseover - Set to null to disable
*       highlightLineColor - The color to use for drawing a highlight line on mouseover - Set to null to disable
*       valueSpots - Specify which points to draw spots on, and in which color.  Accepts a range map
*
*   bar - Bar chart.  Options:
*       barColor - Color of bars for postive values
*       negBarColor - Color of bars for negative values
*       zeroColor - Color of bars with zero values
*       nullColor - Color of bars with null values - Defaults to omitting the bar entirely
*       barWidth - Width of bars in pixels
*       colorMap - Optional mappnig of values to colors to override the *BarColor values above
*                  can be an Array of values to control the color of individual bars or a range map
*                  to specify colors for individual ranges of values
*       barSpacing - Gap between bars in pixels
*       zeroAxis - Centers the y-axis around zero if true
*
*   tristate - Charts values of win (>0), lose (<0) or draw (=0)
*       posBarColor - Color of win values
*       negBarColor - Color of lose values
*       zeroBarColor - Color of draw values
*       barWidth - Width of bars in pixels
*       barSpacing - Gap between bars in pixels
*       colorMap - Optional mappnig of values to colors to override the *BarColor values above
*                  can be an Array of values to control the color of individual bars or a range map
*                  to specify colors for individual ranges of values
*
*   discrete - Options:
*       lineHeight - Height of each line in pixels - Defaults to 30% of the graph height
*       thesholdValue - Values less than this value will be drawn using thresholdColor instead of lineColor
*       thresholdColor
*
*   bullet - Values for bullet graphs msut be in the order: target, performance, range1, range2, range3, ...
*       options:
*       targetColor - The color of the vertical target marker
*       targetWidth - The width of the target marker in pixels
*       performanceColor - The color of the performance measure horizontal bar
*       rangeColors - Colors to use for each qualitative range background color
*
*   pie - Pie chart. Options:
*       sliceColors - An array of colors to use for pie slices
*       offset - Angle in degrees to offset the first slice - Try -90 or +90
*       borderWidth - Width of border to draw around the pie chart, in pixels - Defaults to 0 (no border)
*       borderColor - Color to use for the pie chart border - Defaults to #000
*
*   box - Box plot. Options:
*       raw - Set to true to supply pre-computed plot points as values
*             values should be: low_outlier, low_whisker, q1, median, q3, high_whisker, high_outlier
*             When set to false you can supply any number of values and the box plot will
*             be computed for you.  Default is false.
*       showOutliers - Set to true (default) to display outliers as circles
*       outlierIQR - Interquartile range used to determine outliers.  Default 1.5
*       boxLineColor - Outline color of the box
*       boxFillColor - Fill color for the box
*       whiskerColor - Line color used for whiskers
*       outlierLineColor - Outline color of outlier circles
*       outlierFillColor - Fill color of the outlier circles
*       spotRadius - Radius of outlier circles
*       medianColor - Line color of the median line
*       target - Draw a target cross hair at the supplied value (default undefined)
*
*
*
*   Examples:
*   $('#sparkline1').sparkline(myvalues, { lineColor: '#f00', fillColor: false });
*   $('.barsparks').sparkline('html', { type:'bar', height:'40px', barWidth:5 });
*   $('#tristate').sparkline([1,1,-1,1,0,0,-1], { type:'tristate' }):
*   $('#discrete').sparkline([1,3,4,5,5,3,4,5], { type:'discrete' });
*   $('#bullet').sparkline([10,12,12,9,7], { type:'bullet' });
*   $('#pie').sparkline([1,1,2], { type:'pie' });
*/


library bwu_sparkline;

import 'dart:html' as dom;
import 'dart:async' as async;
import 'dart:math' as math;
import 'dart:collection' as coll;

import 'package:polymer/polymer.dart';
import 'package:bwu_utils/math/math.dart' as um;
import 'package:bwu_utils_browser/html/html.dart' as ub;

import 'src/utilities.dart';
import 'src/sp_format.dart';
import 'src/sp_tooltip.dart';
import 'src/options_extended.dart';
import 'src/tooltip_options_extended.dart';

export 'src/options_extended.dart';

//part 'src/tooltip_options.dart';
part 'src/range_map.dart';
part 'src/mouse_handler.dart';

@CustomTag('bwu-sparkline')
class BwuSparkline extends PolymerElement with ChangeNotifier  {
  BwuSparkline.created() : super.created();

  @reflectable @published dynamic get optionsMap => __$optionsMap; dynamic __$optionsMap; @reflectable set optionsMap(dynamic value) { __$optionsMap = notifyPropertyChange(#optionsMap, __$optionsMap, value); } // Map literal
  @reflectable @published Options get options => __$options; Options __$options; @reflectable set options(Options value) { __$options = notifyPropertyChange(#options, __$options, value); } // Options instance
  @reflectable @published List get values => __$values; List __$values; @reflectable set values(List value) { __$values = notifyPropertyChange(#values, __$values, value); }     // List of values
  //@published List valuesString; // attribute values inline values

  // VCanvasCanvas target;
  Options _options; // this one are used
  Options _attributeOptions;
  //Options _extendedOptions;
  //List _userValues;
  List<List<num>> _values;

  String height;
  String width;
  int pixelWidth;
  int pixelHeight;
//  MouseHandler mhandler;
  String _tagOptionsPrefix = '';

  async.Timer _initJob;

  void optionsMapChanged(old) {
    _loadAttributeOptions();
    _doInit();
  }

  void optionsChanged(old) {
    _options = options;
    _doInit();
  }

  void valuesChanged(old) {
    _values=values.toList();
    _doInit();
  }

  /**
   * Prevent repeated execution of init for each changed attribute.
   * _doInit() waits 10ms and when it is called again within this time frame
   * it starts waiting again. When more than 10ms no new call was received
   * inti() is finally called.
   */
  void _doInit() {
    if(_initJob != null) {
      _initJob.cancel();
    }
    _initJob = new async.Timer(new Duration(milliseconds: 10), () {
      init();
      _initJob = null;
    });
  }

  async.Timer _delayedRender;

  VCanvas canvas(String width, String height, bool interact) {
    if (width == null) {
      width = ub.innerWidth(this).toString();
    }
    if (height == null) {
      height = ub.innerHeight(this).toString();
    }
    var target = new VCanvas(width, height, this /*$['canvas']*/, interact);
    //mhandler = $(this).data('_jqs_mhandler');
    if (mHandler != null) {
        mHandler.registerCanvas(target);
    }
    return target;
  }

  bool _isAttached = false;

// TODO check if this the correct string value to check opacity
  // TODO allso check all parents
  bool get isVisible => style.display != 'none' && style.visibility != 'hidden' && style.opacity == '0.0';

  @override
  void attached() {
    try {
      super.attached();
      _isAttached = true;
    } catch(e, s) {
      print('bwu-sparkline - attached - error: ${e}\n\n${s}');
    }
  }

  @override
  void detached() {
    super.detached();
    _isAttached = false;
  }

  void init() {
    _loadAttributeOptions();

    String chartType;

    if(options != null) {
      chartType = options.type;
    } else if(_attributeOptions != null) {
      chartType = _attributeOptions.type;
    }

    _options = new Options.forType(chartType, true)
        ..extend(options)
        ..extend(_attributeOptions);

    if(_values == null && _options.values != null) {
      _values = _options.values.toList();
    }

    if (innerHtml.trim() == '' && !_options.disableHiddenCheck && !isVisible || !_isAttached) {
      if (!_options.composite) {
        render();
      }
    } else {
      render();
    }
  }

  void _loadAttributeOptions() {

    // TODO remove redundant options like tagOptionsPrefix
    if(optionsMap == null) {
      return;
    }

    String chartType;
    if(optionsMap.containsKey('type')) {
      chartType = optionsMap['type'];
    } else if(options != null) {
      chartType = options.type;
    }

    _attributeOptions = new Options.forType(chartType);
    optionsMap.keys.forEach((k) {
      _attributeOptions[k] = optionsMap[k];
    });
  }

  MouseHandler mHandler;

  void render () {
    _delayedRender = null;
    List<List<num>> values;

    if (_values == null) {
      String vals = attributes[_options.tagValuesAttribute];
      if (vals == null || vals.isEmpty) {
        vals = innerHtml;
      }
      values = [];
      vals.replaceAll(new RegExp(r'(^\s*<!--)|(-->\s*$)|\s+')/*/g*/, '').split(',').forEach((f) {
        values.add(normalizeValue([f]));
        // TODO split them if they contain ':'
      });
      _values = values.toList();
    } else {
      if(_values.every((e) => e is List && e.every((v) => v is num))) {
        values = _values.toList();
      } else {
        values = _values.map((e) => [e]).toList();
      }
    }

    width = _options.width == null ? (values.length * _options.defaultPixelsPerValue).toString() : _options.width;
    if (_options.height == null) {
      if (!_options.composite) {
        // must be a better way to get the line height
        dom.SpanElement tmp = new dom.SpanElement();
        tmp.innerHtml = 'a';
        children.clear();
        append(tmp); //$this.html(tmp);
        height = tmp.offsetHeight.toString();
        tmp.remove();
      }
    } else {
      height = _options.height;
    }
    children.clear();

    if (!_options.disableInteraction) {
      //mhandler = $.data(this, '_jqs_mhandler');
      if (mHandler == null) {
         mHandler = new MouseHandler(this, _options);
        //$.data(this, '_jqs_mhandler', mhandler);
      } else if (!_options.composite) {
         mHandler.reset();
      }
    } else {
      mHandler = null;
    }

//    if (_options.composite && !$.data(this, '_jqs_vcanvas')) {
//      if (!$.data(this, '_jqs_errnotify')) {
//        alert('Attempted to attach a composite sparkline to an element with no existing sparkline');
//        $.data(this, '_jqs_errnotify', true);
//      }
//      return;
//    }

    ChartBase sp = new ChartBase(_options.type, this, values, _options, width, height);

    sp.render();


    if (mHandler != null) {
      mHandler.registerSparkline(sp);
    }
  }


//  $.fn.sparkline.defaults = getDefaults();


//  void displayVisible() {
//    dom.HtmlElement el;
//    int i;
//    int pl = pending.length;
//    List<int> done = [];
//    for (i = 0;  i < pl; i++) {
//      el = pending[i][0];
//      if ($(el).is(':visible') && !$(el).parents().is(':hidden')) {
//        pending[i][1].call(el);
//        $.data(pending[i][0], '_jqs_pending', false);
//        done.push(i);
//      } else if (!$(el).closest('html').length && !$.data(el, '_jqs_pending')) {
//        // element has been inserted and removed from the DOM
//        // If it was not yet inserted into the dom then the .data request
//        // will return true.
//        // removing from the dom causes the data to be removed.
//        $.data(pending[i][0], '_jqs_pending', false);
//        done.push(i);
//      }
//    }
//    for (i = done.length; i; i--) {
//      pending.splice(done[i - 1], 1);
//    }
//  }
//}

///**
// * User option handler
// */
//class UserOptions {
//  UserOptions(String tag, userOptions) { // TODO tag is the sparkline tag
////    var extendedOptions, defaults, base, tagOptionType;
////    this.userOptions = userOptions = userOptions || {};
////    this.tag = tag;
//    this.tagValCache = {};
////    defaults = $.fn.sparkline.defaults;
////    base = defaults.common;
//    this.tagOptionsPrefix = userOptions.enableTagOptions && (userOptions.tagOptionsPrefix != null);
//
//    tagOptionType = getTagSetting('type');
//    //if (tagOptionType == UNSET_OPTION) {
//      //extendedOptions = defaults[userOptions.type || base.type];
////    } else {
//      //extendedOptions = defaults[tagOptionType];
////    }
//    //this.mergedOptions = $.extend({}, base, extendedOptions, userOptions);
//  }

// TODO
//  void getTagSetting(String key) {
//    bool prefix = _tagOptionsPrefix;
//    int val;
//    int i;
//    int pairs;
//    String keyval;
//
//    if (prefix == null) {
//      return UNSET_OPTION;
//    }
//    if (this.tagValCache.hasOwnProperty(key)) {
//      val = this.tagValCache.key;
//    } else {
//      val = this.tag.getAttribute(prefix + key);
//      if (val == null) {
//          val = UNSET_OPTION;
//      } else if (val.substr(0, 1) == '[') {
//        val = val.substr(1, val.length - 2).split(',');
//        for (i = val.length; i--;) {
//            val[i] = normalizeValue(val[i].replace(r'(^\s*)|(\s*$)' /*/g*/, ''));
//        }
//      } else if (val.substr(0, 1) == '{') {
//        pairs = val.substr(1, val.length - 2).split(',');
//        val = {};
//        for (i = pairs.length; i--;) {
//          keyval = pairs[i].split(':', 2);
//          val[keyval[0].replace(r'(^\s*)|(\s*$)'/*/g*/, '')] = normalizeValue(keyval[1].replace(r'(^\s*)|(\s*$)'/*/g*/''));
//        }
//      } else {
//        val = normalizeValue(val);
//      }
//      this.tagValCache.key = val;
//    }
//    return val;
//  }

//  void get(String key, int defaultval) {
//    var tagOption = this.getTagSetting(key),
//        result;
//    if (tagOption != UNSET_OPTION) {
//        return tagOption;
//    }
//    return (result = this.mergedOptions[key]) == undefined ? defaultval : result;
//  }
}


abstract class ChartBase {
  bool disabled = false;
  String type;
  BwuSparkline el;
  List<List<num>> values;
  Options options;
  String width;
  String height;
  int currentRegion;
  VCanvas target;
  int canvasWidth;
  int canvasHeight;
  int canvasTop;
  int canvasLeft;

  VShape regionShapes = new VShape.list();

  ChartBase.sub(this.type, this.el, this.values, this.options, this.width, this.height);

  factory ChartBase(String type, BwuSparkline el, List<List<num>> values, Options options, String width, String height) {
    switch(type) {
      case BAR_TYPE:
        return new Bar(el, values, options, width, height);
      case BOX_TYPE:
        return new Box(el, values, options, width, height);
      case BULLET_TYPE:
        return new Bullet(el, values, options, width, height);
      case DISCRETE_TYPE:
        return new Discrete(el, values, options, width, height);
      case LINE_TYPE:
        return new Line(type, el, values, options, width, height);
      case PIE_TYPE:
        return new Pie(el, values, options, width, height);
      case TRISTATE_TYPE:
        return new Tristate(el, values, options, width, height);
    }
  }

  // necessary for BarHighlightMixing
  bool superRender() {
    if (disabled) {
      el.innerHtml = '';
      return false;
    }
    return true;
  }


  /**
   * Setup the canvas
   */
  void initTarget() {
    bool interactive = !options.disableInteraction;
    target = el.canvas(width, height, interactive);
    canvasWidth = target.pixelWidth;
    canvasHeight = target.pixelHeight;
  }

  /**
   * Actually render the chart to the canvas
   */
  bool render() {
    return superRender();
  }

  /**
   * Return a region id for a given x/y co-ordinate
   */
  int getRegion(int x, int y);

  /**
   * Highlight an item based on the moused-over x,y co-ordinate
   */
  bool setRegionHighlight(int x, int y) {
    bool highlightEnabled = options.enableHighlight;
    int newRegion;
    if (x >= canvasWidth || y >= canvasHeight || x < 0 || y < 0) {
      return false;
    }
    newRegion = getRegion(x, y);
    if (currentRegion != newRegion) {
      if (currentRegion != null && highlightEnabled) {
        removeHighlight();
      }
      currentRegion = newRegion;
      if (newRegion != null && highlightEnabled) {
        renderHighlight();
      }
      return true;
    }
    return false;
  }

  /**
   * Reset any currently highlighted item
   */
  bool clearRegionHighlight() {
    if (currentRegion != null) {
      removeHighlight();
      currentRegion = null;
      return true;
    }
    return false;
  }

  void renderHighlight() {
    changeHighlight(true);
  }

  void removeHighlight() {
    changeHighlight(false);
  }

  void changeHighlight(bool highlight) {}

  /**
   * Fetch the HTML to display as a tooltip
   */
  String getCurrentRegionTooltip() {
    String header = '';
    List<String> entries = [];
//    int formatlen;
//    int fclass;
//    String text;
//    int i;
//    //bool showFields;
//    //bool showFieldsKey;
//    List<int> newFields;
//    int fv;
//    String format;
//    int fieldlen;
//    int j;

    if (currentRegion == null) {
      return '';
    }
    List<Map> fields = getCurrentRegionFields();
    TooltipFormatterFn formatter = options.tooltip.formatter;
    if (formatter != null) {
      return formatter(this, options, fields);
    }
    if (options.tooltip.chartTitle != null) {
      header += '<div class="jqs jqstitle">${options.tooltip.chartTitle}</div>\n';
    }

    List<SPFormat> formats = options.tooltip.formats;
    if (formats == null) {
      return '';
    }

    if(options is BoxOptions) {
      List<String> showFields = (options.tooltip as BoxChartTooltipOptions).formatFieldlist;
      String showFieldsKey = (options.tooltip as BoxChartTooltipOptions).formatFieldlistKey;
      if (showFields != null && showFieldsKey != null) {
        // user-selected ordering of fields
        List<Map> newFields = [];
        for (int i = 0; i < fields.length; i++) {
          String fv = fields[i][showFieldsKey];
          int j;
          if ((j = showFields.indexOf(fv)) != -1) {
            newFields[j] = fields[i];
          }
        }
        fields = newFields;
      }
    }
    int formatlen = formats.length;
    int fieldlen = fields.length;
    for (int i = 0; i < formatlen; i++) {
      SPFormat format = formats[i];
// TODO allow to set Format as String
//      if (format is String) {
//        format = new SPFormat(format);
//      }
      String fclass = format.fclass != null ? format.fclass : 'jqsfield'; // TODO shouldn't this be default in the options?
      for (int j = 0; j < fieldlen; j++) {
        if (!fields[j]['isNull'] == true || !options.tooltip.skipNull) {
          if(!fields[j].containsKey('prefix')) fields[j]['prefix'] = options.tooltip.prefix;
          if(!fields[j].containsKey('suffix')) fields[j]['suffix'] = options.tooltip.suffix;
//          $.extend(fields[j], {
//            prefix: options.tooltipOptions.prefix,
//            suffix: options.tooltipOptions.tooltipSuffix
//          });
          String text = format.render(fields[j], (options.tooltip[BoxChartTooltipOptions.VALUE_LOOKUPS]), options);
          entries.add('<div class="${fclass}">${text}</div>');
        }
      }
    }
    if (entries.length > 0) {
      return header + entries.join('\n');
    }
    return '';
  }

  List<Map> getCurrentRegionFields();

  String calcHighlightColor(String color, Options options) {
    String highlightColor = options.highlightColor;
    double lighten = options.highlightLighten;
    Match parse;
    int mult;
    List<int> rgbnew;
    int i;
    if (highlightColor != null) {
      return highlightColor;
    }
    if (lighten != null) {
      // extract RGB values
      parse = new RegExp(r'^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$').firstMatch(color);
      if(parse == null) {
        parse = new RegExp(r'^#([0-9a-f])([0-9a-f])([0-9a-f])$').firstMatch(color);
      }
      if (parse != null) {
        rgbnew = [];
        mult = color.length == 4 ? 16 : 1;
        for (i = 0; i < 3; i++) {
          // TODO verify
          rgbnew[i] = clipval((int.parse(parse.group(i + 1), radix: 16) * mult * lighten).round(), 0, 255);
        }
        return 'rgb(' + rgbnew.join(',') + ')';
      }
    }
    return color;
  }
}

class Shapes {
  int id;
  List<int> values;
}

abstract class BarHighlightMixin  {
//  int currentRegion;
//  VCanvasBase target;
  VShape newShapes;
  //VShape regionShapes;

  ChartBase base;

  initBarHighlightMixing(ChartBase base) => this.base = base;

  VShape renderRegion(int region, [bool highlight = false]);

  void changeHighlight(bool highlight) {
    VShape shapeids = new VShape.list()..add(base.regionShapes[base.currentRegion]);
    // will be null if the region value was null
    if (shapeids != null) {
      newShapes = renderRegion(base.currentRegion, highlight);
      if (newShapes.length > 1 || shapeids.length > 1) {
        base.target.replaceWithShapes(shapeids, newShapes);
        base.regionShapes[base.currentRegion] = newShapes.map((newShape) => newShape.id);
      } else {
        base.target.replaceWithShape(shapeids, newShapes);
        base.regionShapes[base.currentRegion] = newShapes.id;
     }
    }
  }

  void render() {
    VShape shapes;
    List<int> ids;
    int i;
    int j;

    if (!base.superRender()) {
      return;
    }
    for (i = base.values.length - 1; i >= 0; i--) {
      shapes = renderRegion(i);
      if (shapes != null) {
        if (shapes.type == VShape.CONTAINER) {
          ids = [];
          for (j = shapes.length; j > 0; j--) {
            shapes[j].append();
            ids.add(shapes[j].id);
          }
          base.regionShapes[i] = ids; // TODO
        } else {
          shapes.append();
          base.regionShapes.add(shapes.id); // store just the shapeid
        }
      } else {
        // null value
        base.regionShapes.add(null);
      }
    }
    base.target.render();
  }
}

//class RegionFields {
//  bool isNull;
//  int x;
//  int y;
//  String color;
//  String fillColor;
//  math.Point<int> offset;
//
//  RegionFields({this.isNull, this.x, this.y, this.color, this.fillColor, this.offset);
//}

/**
 * Line charts
 */
class Line extends ChartBase {
  List<List<int>> vertices = [];
  List<List<int>> regionMap = [];
  List<num> xvalues = [];
  List<num> yvalues = [];
  List<num> yminmax = [];
  int hightlightSpotId;
  int highlightLineId;
  int lastShapeId;
  num minx;
  num maxx;
  num miny;
  num maxy;
  double spotRadius = 0.0;
  int highlightSpotId;
  num maxyorg;
  int minxorg;
  num minyorg;


  LineOptions get options => super.options;

  Line (String type, BwuSparkline el, List<List<num>> values, Options options, String width, String height) : super.sub(type, el, values, options, width, height) {
    initTarget();
  }

  int getRegion(int x, int y) {
    for (int i = regionMap.length - 1; i >= 0; i--) {
      if (regionMap[i] != null && x >= regionMap[i][0] && x <= regionMap[i][1]) {
        return regionMap[i][2];
      }
    }
    return null;
  }

  List<Map> getCurrentRegionFields() {
    return [{
        'isNull': yvalues[currentRegion] == null,
        'x': xvalues[currentRegion],
        'y': yvalues[currentRegion],
        'color': options.lineColor,
        'fillColor': options.fillColor,
        'offset': currentRegion
    }];
  }

  @override
  void renderHighlight() {

    List<int> vertex = vertices[currentRegion];
    String highlightSpotColor = options.highlightSpotColor;
    String highlightLineColor = options.highlightLineColor;
    VShape highlightSpot;
    VShape highlightLine;

    if (vertex == null) {
      return;
    }
    if (spotRadius != null && highlightSpotColor != null) {
      highlightSpot = target.drawCircle(vertex[0], vertex[1],
          spotRadius, null, highlightSpotColor, null);
      highlightSpotId = highlightSpot.id;
      target.insertAfterShape(lastShapeId, highlightSpot);
    }

    if (highlightLineColor != null) {
        highlightLine = target.drawLine(vertex[0], canvasTop, vertex[0],
            canvasTop + canvasHeight, highlightLineColor, null);
        highlightLineId = highlightLine.id;
        target.insertAfterShape(lastShapeId, highlightLine);
    }
  }

  void removeHighlight() {
    if (highlightSpotId != null) {
      target.removeShapeId(highlightSpotId);
      highlightSpotId = null;
    }
    if (highlightLineId != null) {
        target.removeShapeId(highlightLineId);
        highlightLineId = null;
    }
  }

  void scanValues() {
    int valcount = values.length;
    int i;
    List<num> val;
    bool isStr;
    bool isArray;
    List<SPFormat> sp;
    for (i = 0; i < valcount; i++) {
      val = values[i];
      //isStr = values[i] is String;
      isArray = values[i] is List && values.every((e) => e.length > 1);
      //sp = isStr && values[i].split(':');

//      if (isStr && sp.length == 2) { // x:y
//        xvalues.add(Number(sp[0]));
//        yvalues.add(Number(sp[1]));
//        yminmax.add(Number(sp[1]));
      //} else
      if (isArray) {
        xvalues.add(val[0]);
        yvalues.add(val[1]);
        yminmax.add(val[1]);
      } else {
        xvalues.add(i);
        if (values[i] == null) {
          yvalues.add(null);
        } else {
          yvalues.add(/*Number*/(val[0]));
          yminmax.add(/*Number*/(val[0]));
        }
      }
    }
    if (options.xValues != null) {
      xvalues = options.xValues;
    }

    if(yminmax.length != 0) {
      maxy = maxyorg = yminmax.reduce(um.nullSafeMax); // TODO is this nullsafe really necessary?
      miny = minyorg = yminmax.reduce(um.nullSafeMin);
    }
    if(xvalues.length != 0) {
      maxx = xvalues.reduce(um.nullSafeMax);
      minx = xvalues.reduce(um.nullSafeMin);
    }
  }

  void processRangeOptions() {
    int normalRangeMin = options.normalRangeMin;
    int normalRangeMax = options.normalRangeMax;

    if (normalRangeMin != null) {
      if (normalRangeMin < miny) {
        miny = normalRangeMin;
      }
      if (normalRangeMax > maxy) {
        maxy = normalRangeMax;
      }
    }
    if (options.chartRangeMin != null && (options.chartRangeClip != null || options.chartRangeMin < miny)) {
      miny = options.chartRangeMin;
    }
    if (options.chartRangeMax != null && (options.chartRangeClip != null || options.chartRangeMax > maxy)) {
      maxy = options.chartRangeMax;
    }
    if (options.chartRangeMinX != null && (options.chartRangeClipX != null || options.chartRangeMinX < minx)) {
      minx = options.chartRangeMinX;
    }
    if (options.chartRangeMaxX != null && (options.chartRangeClipX != null || options.chartRangeMaxX > maxx)) {
      maxx = options.chartRangeMaxX;
    }
  }

  void drawNormalRange(int canvasLeft, int canvasTop, int canvasHeight, int canvasWidth, int rangey) {
    int normalRangeMin = options.normalRangeMin;
    int normalRangeMax = options.normalRangeMax;
    int ytop = canvasTop + (canvasHeight - (canvasHeight * ((normalRangeMax - miny) / rangey))).round();
    int height = ((canvasHeight * (normalRangeMax - normalRangeMin)) / rangey).round();
    target.drawRect(canvasLeft, ytop, canvasWidth, height, null, options.normalRangeColor).append();
  }

  @override
  bool render() {
    num rangex;
    num rangey;
    num yvallast;
//    int canvasTop;
//
    List<num> vertex;
    List<List<num>> path;
    List<List<List<num>>> paths;
    int x;
    num y;
    int xnext;
    int xpos;
    int xposnext;
    num last;
    num next;
    int yvalcount;
    List<List<List<num>>> lineShapes;
    List<List<List<num>>> fillShapes;
    int plen;
    RangeMap valueSpots;
    bool hlSpotsEnabled;
    String color;
//    List<int> xvalues;
//    List<int> yvalues;
    int i;
    int canvasWidth = this.canvasWidth;
    int canvasHeight = this.canvasHeight;

    if (!super.render()) {
      return false;
    }

    scanValues();
    processRangeOptions();

    if (yminmax.length == 0 || yvalues.length < 2) {
      // empty or all null valuess
      return false;
    }

    canvasTop = canvasLeft = 0;

    rangex = maxx - minx == 0 ? 1 : maxx - minx;
    rangey = maxy - miny == 0 ? 1 : maxy - miny;
    yvallast = yvalues.length - 1;

    spotRadius = options.spotRadius;
    if (spotRadius != 0 && (canvasWidth < (spotRadius * 4) || canvasHeight < (spotRadius * 4))) {
      spotRadius = 0.0;
    }
    if (spotRadius != 0.0) {
      // adjust the canvas size as required so that spots will fit
      hlSpotsEnabled = options.highlightSpotColor != null &&  !options.disableInteraction;
      if (hlSpotsEnabled || options.minSpotColor != null || (options.spotColor != null && yvalues[yvallast] == miny)) {
        canvasHeight -= spotRadius.ceil();
      }
      if (hlSpotsEnabled || options.maxSpotColor != null|| (options.spotColor != null && yvalues[yvallast] == maxy)) {
          canvasHeight -= spotRadius.ceil();
          canvasTop += spotRadius.ceil();
      }
      if (hlSpotsEnabled ||
           ((options.minSpotColor != null || options.maxSpotColor != null ) && (yvalues[0] == miny || yvalues[0] == maxy))) {
          canvasLeft += spotRadius.ceil();
          canvasWidth -= spotRadius.ceil();
      }
      if (hlSpotsEnabled || options.spotColor != null ||
        (options.minSpotColor != null || options.maxSpotColor != null &&
          (yvalues[yvallast] == miny || yvalues[yvallast] == maxy))) {
        canvasWidth -= spotRadius.ceil();
      }
    }


    canvasHeight--;

    if (options.normalRangeMin != null && !options.drawNormalOnTop) {
      drawNormalRange(canvasLeft, canvasTop, canvasHeight, canvasWidth, rangey);
    }

    path = [];
    paths = [path];
    last = next = null;
    yvalcount = yvalues.length;
    for (i = 0; i < yvalcount; i++) {
      x = xvalues[i];
      if(xvalues.length > i + 1) {
        xnext = xvalues[i + 1];
      } else {
        xnext = null;
      }
      y = yvalues[i];
      xpos = canvasLeft + ((x - minx) * (canvasWidth / rangex)).round();
      xposnext = i < yvalcount - 1 ? canvasLeft + ((xnext - minx) * (canvasWidth / rangex)).round() : canvasWidth;
      next = xpos + ((xposnext - xpos) / 2);
      regionMap.add([last != null ? last : 0, next, i]);
      last = next;
      if (y == null) {
        if (i != 0) {
          if (yvalues[i - 1] != null) {
            path = [];
            paths.add(path);
          }
          vertices.add(null);
        }
      } else {
        if (y < miny) {
          y = miny;
        }
        if (y > maxy) {
          y = maxy;
        }
        if (path.length == 0) {
          // previous value was null
          path.add([xpos, canvasTop + canvasHeight]);
        }
        vertex = [xpos, canvasTop + (canvasHeight - (canvasHeight * ((y - miny) / rangey))).round()];
        path.add(vertex);
        vertices.add(vertex);
      }
    }

    lineShapes = [];
    fillShapes = [];
    plen = paths.length;
    for (i = 0; i < plen; i++) {
      path = paths[i];
      if (path.length > 0) {
        if (options.fillColor != null) {
          path.add([path[path.length - 1][0], (canvasTop + canvasHeight)]);
          fillShapes.add(path.toList());
          path.removeLast();
        }
        // if there's only a single point in this path, then we want to display it
        // as a vertical line which means we keep path[0]  as is
        if (path.length > 2) {
          // else we want the first value
          path[0] = [path[0][0], path[1][1]];
        }
        lineShapes.add(path);
      }
    }

    // draw the fill first, then optionally the normal range, then the line on top of that
    plen = fillShapes.length;
    for (i = 0; i < plen; i++) {
      target.drawShape(fillShapes[i],
          options.fillColor, null, fillColor: options.fillColor).append();
    }

    if (options.normalRangeMin != null && options.drawNormalOnTop) {
      drawNormalRange(canvasLeft, canvasTop, canvasHeight, canvasWidth, rangey);
    }

    plen = lineShapes.length;
    for (i = 0; i < plen; i++) {
      target.drawShape(lineShapes[i], options.lineColor,
          options.lineWidth).append();
    }

    if (spotRadius != null && options.valueSpots != null) {
      var vs = options.valueSpots;
      if(vs != null) {
      //if (valueSpots.get == null) {
        valueSpots = new RangeMap(vs);
      }
      for (i = 0; i < yvalcount; i++) {
        color = valueSpots.get(yvalues[i]);
        if (color != null) {
            target.drawCircle(canvasLeft + ((xvalues[i] - minx) * (canvasWidth / rangex)).round(),
                canvasTop + (canvasHeight - (canvasHeight * ((yvalues[i] - miny) / rangey))).round(),
                spotRadius, null,
                color, null).append();
        }
      }
    }
    if (spotRadius != null && options.spotColor != null && yvalues[yvallast] != null) {
      target.drawCircle(canvasLeft + ((xvalues[xvalues.length - 1] - minx) * (canvasWidth / rangex)).round(),
          canvasTop + (canvasHeight - (canvasHeight * ((yvalues[yvallast] - miny) / rangey))).round(),
          spotRadius, null,
          options.spotColor, null).append();
    }
    if (maxy != minyorg) {
      if (spotRadius != null && options.minSpotColor != null) {
        x = xvalues[yvalues.indexOf(minyorg)];
        target.drawCircle(canvasLeft + ((x - minx) * (canvasWidth / rangex)).round(),
            canvasTop + (canvasHeight - (canvasHeight * ((minyorg - miny) / rangey))).round(),
            spotRadius, null,
            options.minSpotColor, null).append();
      }
      if (spotRadius != null&& options.maxSpotColor != null) {
          x = xvalues[yvalues.indexOf(maxyorg)];
          target.drawCircle(canvasLeft + ((x - minx) * (canvasWidth / rangex)).round(),
              canvasTop + (canvasHeight - (canvasHeight * ((maxyorg - miny) / rangey))).round(),
              spotRadius, null,
              options.maxSpotColor, null).append();
      }
    }

    lastShapeId = target.getLastShapeId();
    target.render();
    return true;
  }
}

/**
 * Bar charts
 */
class Bar extends ChartBase with BarHighlightMixin {
  BarOptions get options => super.options;

  int totalBarWidth;
  List colorMapByIndex;
  RangeMap colorMapByValue;
  num yoffset;
  num xaxisOffset;
  num range;
  bool stacked = false;
  int canvasHeightEf;
  int barWidth;

  Bar(BwuSparkline el, List<List<num>> values, BarOptions options, String width, String height) : super.sub(BAR_TYPE, el, values, options, width, height) {
    initBarHighlightMixing(this);
    barWidth = options.barWidth;
    int barSpacing = options.barSpacing;
    int chartRangeMin = options.chartRangeMin;
    int chartRangeMax = options.chartRangeMax;
    bool chartRangeClip = options.chartRangeClip;
    num stackMin = double.INFINITY;
    num stackMax = double.NEGATIVE_INFINITY;
    bool isStackString = false;
    int groupMin;
    int groupMax;
    List<List<num>> stackRanges;
    List<List<num>> numValues;
    int i;
    int vlen;
    bool zeroAxis;
    num min;
    num max;
    double clipMin;
    double clipMax;
    List<num> vlist;
    //int j;
    int slen;
    List<List<num>> svals;
    List<num> val;
    int yMaxCalc;


    // scan values to determine whether to stack bars
    vlen = values.length;
    for (i = 0; i < vlen; i++) {
      val = values[i].toList();
      // TODO isStackString = val is String && val.indexOf(':') > -1;
      if (isStackString || val is List && val.length > 1) {
        stacked = true;
        if (isStackString) {
          // TODO val = values[i] = normalizeValues(val.split(':'));
        }
        // TODO val = remove(val, null); // min/max will treat null as zero
        groupMin = val.reduce(math.min); //(Math, val);
        groupMax = val.reduce(math.max); //(Math, val);
        if (groupMin < stackMin) {
          stackMin = groupMin;
        }
        if (groupMax > stackMax) {
          stackMax = groupMax;
        }
      }
    }

    totalBarWidth = barWidth + barSpacing;
    this.width = ((values.length * barWidth) + ((values.length - 1) * barSpacing)).toString();

    initTarget();

    if (chartRangeClip != null) {
      clipMin = chartRangeMin == null ? double.NEGATIVE_INFINITY : chartRangeMin;
      clipMax = chartRangeMax == null ? double.INFINITY: chartRangeMax;
    }

    numValues = [];
    stackRanges = stacked ? [] : numValues;
    var stackTotals = [];
    List<List<num>> stackRangesNeg = [];
    vlen = values.length;
    for (i = 0; i < vlen; i++) {
      if (stacked) {
        vlist = values[i].toList();
        values[i] = svals = [];
        stackTotals.add([0]);
        stackRanges.add([0]);
        stackRangesNeg.add([0]);
        for (int j = 0, slen = vlist.length; j < slen; j++) {
          val = chartRangeClip != null ? [clipval(vlist[j], clipMin, clipMax)] : [vlist[j]];
          svals.add(val);
          if (val[0] != null) {
            if (val[0] > 0) {
              stackTotals[i][0] += val[0];
            }
            if (stackMin < 0 && stackMax > 0) {
              if (val[0] < 0) {
                stackRangesNeg[i][0] += val[0].abs();
              } else {
                stackRanges[i][0] += val[0];
              }
            } else {
              stackRanges[i][0] += (val[0] - (val[0] < 0 ? stackMax : stackMin)).abs();
            }
            numValues.add(val);
          }
        }
      } else {
        val = chartRangeClip != null ? [clipval(values[i][0], clipMin, clipMax)] : values[i].toList();
        val = values[i] = normalizeValue(val);
        if (val != null && val.every((e) => e != null)) {
          numValues.add(val);
        }
      }
    }
    max = numValues.reduce((a, b) => [math.max(a[0], b[0])])[0];
    min = numValues.reduce((a, b) => [math.min(a[0], b[0])])[0];
    stackMax = stackMax = stacked ? stackTotals.reduce((a, b) => [math.max(a[0], b[0])])[0] : max;
    stackMin = stackMin = stacked ? numValues.reduce((a, b) => [math.min(a[0], b[0])])[0] : min;

    if (options.chartRangeMin != null && (options.chartRangeClip != null || options.chartRangeMin < min)) {
      min = options.chartRangeMin;
    }
    if (options.chartRangeMax != null && (options.chartRangeClip != null|| options.chartRangeMax > max)) {
      max = options.chartRangeMax;
    }

    zeroAxis = zeroAxis = options.getValue('zeroAxis', true);
    if (min <= 0 && max >= 0 && zeroAxis != null) {
      xaxisOffset = 0;
    } else if (zeroAxis == false) {
      xaxisOffset = min;
    } else if (min > 0) {
      xaxisOffset = min;
    } else {
      xaxisOffset = max;
    }

    range = stacked ? stackRanges.reduce((a, b) => [math.max(a[0], b[0])])[0] + stackRangesNeg.reduce((a, b) => [math.max(a[0], b[0])])[0] : max - min;

    // as we plot zero/min values a single pixel line, we add a pixel to all other
    // values - Reduce the effective canvas size to suit
    canvasHeightEf = (zeroAxis != null && min < 0) ? canvasHeight - 2 : canvasHeight - 1;

    if (min < xaxisOffset) {
      yMaxCalc = (stacked && max >= 0) ? stackMax : max;
      yoffset = (yMaxCalc - xaxisOffset) / range * canvasHeight;
      if (yoffset != yoffset.ceil()) {
        canvasHeightEf -= 2;
        yoffset = yoffset.ceil();
      }
    } else {
      yoffset = canvasHeight;
    }
    yoffset = yoffset;

    if (options.colorList != null) {
      colorMapByIndex = options.colorList;
      //colorMapByValue = null;
    } else if(options.colorMap != null ){
      //colorMapByIndex = null;
      var map = options.colorMap;
      //if (colorMapByValue && colorMapByValue.get == null) {
        colorMapByValue = new RangeMap(map);
      //}
    }
  }

  int getRegion(/*dom.HtmlElement el, */int x, int y) {
    var result = (x / totalBarWidth).floor();
    return (result < 0 || result >= values.length) ? null : result;
  }

  List<Map> getCurrentRegionFields() {
    var vals = ensureArray(values[currentRegion]);
    List<Map> result = [];
    num value;
    int i;
    for (i = vals.length - 1; i >= 0; i--) {
      value = vals[i];
      result.add({
        'isNull': value == null,
        'value': value,
        'color': calcColor(i, value, currentRegion),
        'offset': currentRegion
      });
    }
    return result;
  }

  String calcColor(int stacknum, num value, int valuenum) {
    String color;
    String newColor;
    if (stacked) {
      color = options.stackedBarColor;
    } else {
      color = (value < 0) ? options.negBarColor : options.barColor;
    }
    if (value == 0 && options.zeroColor != null) {
      color = options.zeroColor;
    }
    if (colorMapByValue != null && ((newColor = colorMapByValue.get(value)) != null)) {
      color = newColor;
    } else if (colorMapByIndex != null&& colorMapByIndex.length > valuenum) {
      color = colorMapByIndex[valuenum];
    }
    return color is List ? color[stacknum % color.length] : color;
  }

  /**
   * Render bar(s) for a region
   */
  List<VShape> renderRegion(int valuenum, [bool highlight = false]) {
    List<num> vals = values[valuenum].toList();
    List<VShape> result = [];
    int x = valuenum * totalBarWidth;
    int y;
    int height;
    String color;
    int yoffset = this.yoffset;
    int yoffsetNeg;
    int i;
    bool minPlotted;

    //vals = vals is List ? vals : [vals];
    int valcount = vals.length;
    num val = vals[0];
    bool isNull = vals.every((v) => v == null);
    bool allMin = vals.every((v) => v == xaxisOffset || v == null);

    if (isNull) {
      if (options.nullColor != null) {
        color = highlight ? options.nullColor : calcHighlightColor(options.nullColor, options);
        y = (yoffset > 0) ? yoffset - 1 : yoffset;
        return target.drawRect(x, y, barWidth - 1, 0, color, color);
      } else {
        return null;
      }
    }
    yoffsetNeg = yoffset;
    for (i = 0; i < valcount; i++) {
      val = vals[i];

      if (stacked && val == xaxisOffset) {
        if (!allMin || minPlotted) {
          continue;
        }
        minPlotted = true;
      }

      if (range > 0) {
        height = (canvasHeightEf * (((val - xaxisOffset).abs() / range))).floor() + 1;
      } else {
        height = 1;
      }
      if (val < xaxisOffset || (val == xaxisOffset && yoffset == 0)) {
        y = yoffsetNeg;
        yoffsetNeg += height;
      } else {
        y = yoffset - height;
        yoffset -= height;
      }
      color = calcColor(i, val, valuenum);
      if (highlight) {
        color = calcHighlightColor(color, options);
      }
      result.add(target.drawRect(x, y, barWidth - 1, height - 1, color, color));
    }
    if (result.length == 1) {
      return result[0];
    }
    return result;
  }
}

/**
 * Tristate charts
 */
class Tristate extends ChartBase with BarHighlightMixin {

  TristateOptions get options => super.options;

  int barWidth;
  int totalBarWidth;
  List colorMapByIndex;
  RangeMap colorMapByValue;

  Tristate(dom.HtmlElement el, List<List<num>> values, TristateOptions options, String width, String height)
      : super.sub(TRISTATE_TYPE, el, values, options, width, height){
    barWidth = options.barWidth;
    int barSpacing = options.barSpacing;

    regionShapes; // TODO = {};
    totalBarWidth = barWidth + barSpacing;
    //values = $.map(values, Number);
    this.width = ((values.length * barWidth) + ((values.length - 1) * barSpacing)).toString();

    if (options.colorList != null) {
      colorMapByIndex = options.colorList;
      //colorMapByValue = null;
    } else if(options.colorMap != null ){
      //colorMapByIndex = null;
      var map = options.colorMap;
      //if (colorMapByValue && colorMapByValue.get == null) {
        colorMapByValue = new RangeMap(map);
      //}
    }

    initTarget();
  }

  int getRegion(/*dom.HtmlElement el, */int x, int y) {
    return (x / totalBarWidth).floor();
  }

  List<Map> getCurrentRegionFields() {
    return [{
      'isNull': values[currentRegion] == null,
      'value': values[currentRegion],
      'color': calcColor(values[currentRegion][0], currentRegion),
      'offset': currentRegion
    }];
  }

  String calcColor(int value, int valuenum) {
    String color;
    String newColor;

    if (colorMapByValue != null&& ((newColor = colorMapByValue.get(value)) != null)) {
      color = newColor;
    } else if (colorMapByIndex != null && colorMapByIndex.length > valuenum) {
      color = colorMapByIndex[valuenum];
    } else if (values[valuenum][0] < 0) {
      color = options.negBarColor;
    } else if (values[valuenum][0] > 0) {
      color = options.posBarColor;
    } else {
      color = options.zeroBarColor;
    }
    return color;
  }

  VShape renderRegion(int valuenum, [bool highlight = false]) {
    int canvasHeight;
    int height;
    int halfHeight;
    int x;
    int y;
    String color;

    canvasHeight = target.pixelHeight;
    halfHeight = (canvasHeight / 2).round();

    x = valuenum * totalBarWidth;
    if (values[valuenum][0] < 0) {
      y = halfHeight;
      height = halfHeight - 1;
    } else if (values[valuenum][0] > 0) {
      y = 0;
      height = halfHeight - 1;
    } else {
      y = halfHeight - 1;
      height = 2;
    }
    color = calcColor(values[valuenum][0], valuenum);
    if (color == null) {
        return null;
    }
    if (highlight) {
      color = calcHighlightColor(color, options);
    }
    return target.drawRect(x, y, barWidth - 1, height - 1, color, color);
  }
}

/**
 * Discrete charts
 */
class Discrete extends ChartBase with BarHighlightMixin {

  DiscreteOptions get options => super.options;

  int range;
  int interval;
  int itemWidth;
  int lineHeight;
  int min;
  int max;

  Discrete (dom.HtmlElement el, List<List<num>> values, DiscreteOptions options, String width, String height)
      : super.sub(DISCRETE_TYPE, el, values, options, width, height){
    //regionShapes = {};
    //values = $.map(values, Number);
    min = values.reduce((a, b) => [math.min(a[0], b[0])])[0];
    max = values.reduce((a, b) => [math.max(a[0], b[0])])[0];
    range = max - min;
    width = options.width == null ? values.length * 2 : width;
    if (options.chartRangeMin != null && (options.chartRangeClip || options.chartRangeMin < min)) {
        min = options.chartRangeMin;
    }
    if (options.chartRangeMax != null && (options.chartRangeClip || options.chartRangeMax > max)) {
      max = options.chartRangeMax;
    }
    initTarget();
    if (target != null) {
      lineHeight = options.lineHeight == null ? (canvasHeight * 0.3).round() : options.lineHeight;
    }
    interval = (canvasWidth / values.length).floor();
    itemWidth = (canvasWidth / values.length).round();

  }

  int getRegion(/*dom.HtmlElement el, */int x, int y) {
      return (x / itemWidth).floor();
  }

  List<Map> getCurrentRegionFields() {
    return [{
        'isNull': values[currentRegion] == null,
        'value': values[currentRegion],
        'offset': currentRegion
    }];
  }

  VShape renderRegion(int valuenum, [bool highlight = false]) {
    int pheight = canvasHeight - lineHeight;
    int ytop;
    int val;
    String color;
    int x;

    val = clipval(values[valuenum][0], min, max);
    x = valuenum * interval;
    ytop = (pheight - pheight * ((val - min) / range)).round();
    color = (options.thresholdColor != null && val < options.thresholdValue) ? options.thresholdColor : options.lineColor;
    if (highlight) {
      color = calcHighlightColor(color, options);
    }
    return target.drawLine(x, ytop, x, ytop + lineHeight, color, null);
  }
}

/**
 * Bullet charts
 */
class Bullet extends ChartBase {

  BulletOptions get options => super.options;

  Bullet(dom.HtmlElement el, List<List<num>> values, BulletOptions options, String width, String height)
    : super.sub(BULLET_TYPE, el, values, options, width, height) {
    int min;
    int max;
    List<int> vals;

    // values: target, performance, range1, range2, range3
    values = normalizeValues(values);
    // target or performance could be null
    vals = values.slice();
    vals[0] = vals[0] == null ? vals[2] : vals[0];
    vals[1] = values[1] == null ? vals[2] : vals[1];
    min = math.min(Math, values);
    max = math.max(Math, values);
    if (options.base == null) {
      min = min < 0 ? min : 0;
    } else {
      min = options.base;
    }
    range = max - min;
    shapes = {};
    valueShapes = {};
    regiondata = {};
    width = options.width == null ? '4.0em' : width;
    target = $el.simpledraw(width, height, options.composite);
    if (values.length == 0) {
      disabled = true;
    }
    initTarget();
  }

  void getRegion(dom.HtmlElement el, int x, int y) {
    var shapeid = target.getShapeAt(el, x, y);
    return (shapeid != null && shapes[shapeid] != null) ? shapes[shapeid] : null;
  }

  List<Map> getCurrentRegionFields() {
    return [{
      'fieldkey': currentRegion.substr(0, 1),
      'value': values[currentRegion.substr(1)],
      'region': currentRegion
    }];
  }

  void changeHighlight(bool highlight) {
    int shapeid = valueShapes[currentRegion];
    int shape;
    shapes.remove(shapeid);
    switch (currentRegion.substr(0, 1)) {
      case 'r':
        shape = renderRange(currentRegion.substr(1), highlight);
        break;
      case 'p':
        shape = renderPerformance(highlight);
        break;
      case 't':
        shape = renderTarget(highlight);
        break;
    }
    valueShapes[currentRegion] = shape.id;
    shapes[shape.id] = currentRegion;
    target.replaceWithShape(shapeid, shape);
  }

  void renderRange(int rn, bool highlight) {
    int rangeval = values[rn];
    int rangewidth = (canvasWidth * ((rangeval - min) / range)).round();
    String color = options.rangeColors[rn - 2];
    if (highlight) {
      color = calcHighlightColor(color, options);
    }
    return target.drawRect(0, 0, rangewidth - 1, canvasHeight - 1, color, color);
  }

  void renderPerformance(bool highlight) {
    int perfval = values[1];
    int perfwidth = (canvasWidth * ((perfval - min) / range)).round();
    String color = options.performanceColor;
    if (highlight) {
      color = calcHighlightColor(color, options);
    }
    return target.drawRect(0, (canvasHeight * 0.3).round(), perfwidth - 1,
        (canvasHeight * 0.4).round() - 1, color, color);
  }

  void renderTarget(bool highlight) {
    int targetval = values[0];
    int x = (canvasWidth * ((targetval - min) / range) - (options.targetWidth / 2)).round();
    int targettop = (canvasHeight * 0.10).round();
    int targetheight = canvasHeight - (targettop * 2);
    String color = options.targetColor;
    if (highlight) {
      color = calcHighlightColor(color, options);
    }
    return target.drawRect(x, targettop, options.targetWidth - 1, targetheight - 1, color, color);
  }

  void render() {
    int vlen = values.length;
    int i;
    int shape;
    if (!super.render()) {
      return;
    }
    for (i = 2; i < vlen; i++) {
      shape = renderRange(i).append();
      shapes[shape.id] = 'r' + i;
      valueShapes['r' + i] = shape.id;
    }
    if (values[1] != null) {
      shape = renderPerformance().append();
      shapes[shape.id] = 'p1';
      valueShapes.p1 = shape.id;
    }
    if (values[0] != null) {
      shape = renderTarget().append();
      shapes[shape.id] = 't0';
      valueShapes.t0 = shape.id;
    }
    target.render();
  }
}

/**
 * Pie charts
 */
class Pie extends ChartBase {

  PieOptions get options => super.options;

  Pie(dom.HtmlElement el, List<List<num>> values, PieOptions options, String width, String height)
      : super.sub(PIE_TYPE, el, values, options, width, height){
    int total = 0;
    int i;

    shapes = {}; // map shape ids to value offsets
    valueShapes = {}; // maps value offsets to shape ids
    values = $.map(values, Number);

    if (options.width == null) {
      width = height;
    }

    if (values.length > 0) {
      for (i = values.length; i--;) {
        total += values[i];
      }
    }
    initTarget();
    radius = (math.min(canvasWidth, canvasHeight) / 2).floor();
  }

  void getRegion(dom.HtmlElement el, int x, int y) {
      int shapeid = target.getShapeAt(el, x, y);
      return (shapeid != null && shapes[shapeid] != null) ? shapes[shapeid] : null;
  }

  List<Map> getCurrentRegionFields() {
    return [{
      'isNull': values[currentRegion] == null,
      'value': values[currentRegion],
      'percent': values[currentRegion] / total * 100,
      'color': options.sliceColors[currentRegion % options.sliceColors.length],
      'offset': currentRegion
    }];
  }

  void changeHighlight(bool highlight) {
    int newslice = renderSlice(currentRegion, highlight);
    int shapeid = valueShapes[currentRegion];
    shapes.remove(shapeid);
    target.replaceWithShape(shapeid, newslice);
    valueShapes[currentRegion] = newslice.id;
    shapes[newslice.id] = currentRegion;
  }

  void renderSlice(int valuenum, bool highlight) {
    int borderWidth = options.borderWidth;
    int offset = options.offset;
    int circle = 2 * math.PI;
    int next = offset ? (2 * math.PI) * (offset/360) : 0;
    int start;
    int end;
    int i;
    int vlen;
    String color;

    vlen = values.length;
    for (i = 0; i < vlen; i++) {
      start = next;
      end = next;
      if (total > 0) {  // avoid divide by zero
        end = next + (circle * (values[i] / total));
      }
      if (valuenum == i) {
        color = options.sliceColors[i % options.sliceColors.length];
        if (highlight) {
          color = calcHighlightColor(color, options);
        }

        return target.drawPieSlice(radius, radius, radius - borderWidth, start, end, null, color);
      }
      next = end;
    }
  }

  void render() {
    int shape;
    int i;

    if (!super.render()) {
      return;
    }
    if (borderWidth == null) {
      target.drawCircle(radius, radius, (radius - (borderWidth / 2)).floor(),
          options.borderColor, null, borderWidth).append();
    }
    for (i = values.length; i--;) {
      if (values[i]) { // don't render zero values
        shape = renderSlice(i).append();
        valueShapes[i] = shape.id; // store just the shapeid
        shapes[shape.id] = i;
      }
    }
    target.render();
  }
}

/**
 * Box plots
 */
class Box extends ChartBase {

  BoxOptions get options => super.options;

  Box(dom.HtmlElement el, List<List<num>> values, BoxOptions options, String width, String height)
      : super.sub(BOX_TYPE, el, values, options, width, height) {
    values = $.map(values, Number);
    width = options.width == null ? '4.0em' : width;
    initTarget();
    if (values.length == 0) {
        disabled = true;
    }
  }

  /**
   * Simulate a single region
   */
  int getRegion() {
      return 1;
  }

  List<Map> getCurrentRegionFields() {
    var result = [
        { 'field': 'lq', 'value': quartiles[0] },
        { 'field': 'med', 'value': quartiles[1] },
        { 'field': 'uq', 'value': quartiles[2] }
    ];
    if (loutlier != null) {
        result.add({ 'field': 'lo', 'value': loutlier});
    }
    if (routlier != null) {
        result.add({ 'field': 'ro', 'value': routlier});
    }
    if (lwhisker != null) {
        result.add({ 'field': 'lw', 'value': lwhisker});
    }
    if (rwhisker != null) {
        result.add({ 'field': 'rw', 'value': rwhisker});
    }
    return result;
  }

  void render() {
    int vlen = values.length;
    int minValue = options.chartRangeMin == null ? math.min(Math, values) : options.chartRangeMin;
    int maxValue = options.chartRangeMax == null ? math.max(Math, values) : options.chartRangeMax;
    int canvasLeft = 0;
    int lwhisker;
    int loutlier;
    int iqr;
    int q1;
    int q2;
    int q3;
    int rwhisker;
    int routlier;
    int i;
    int size;
    int unitSize;

    if (!super.render()) {
      return;
    }

    if (options.raw) {
      if (options.showOutliers && values.length > 5) {
        loutlier = values[0];
        lwhisker = values[1];
        q1 = values[2];
        q2 = values[3];
        q3 = values[4];
        rwhisker = values[5];
        routlier = values[6];
      } else {
        lwhisker = values[0];
        q1 = values[1];
        q2 = values[2];
        q3 = values[3];
        rwhisker = values[4];
      }
    } else {
      values.sort((a, b) { return a - b; });
      q1 = quartile(values, 1);
      q2 = quartile(values, 2);
      q3 = quartile(values, 3);
      iqr = q3 - q1;
      if (options.showOutliers) {
        lwhisker = rwhisker = null;
        for (i = 0; i < vlen; i++) {
          if (lwhisker == null && values[i] > q1 - (iqr * options.outlierIQR)) {
            lwhisker = values[i];
          }
          if (values[i] < q3 + (iqr * options.outlierIQR)) {
            rwhisker = values[i];
          }
        }
        loutlier = values[0];
        routlier = values[vlen - 1];
      } else {
        lwhisker = values[0];
        rwhisker = values[vlen - 1];
      }
    }
    quartiles = [q1, q2, q3];

    unitSize = canvasWidth / (maxValue - minValue + 1);
    if (options.showOutliers) {
      canvasLeft = (options.spotRadius).ceil();
      canvasWidth -= 2 * (options.spotRadius).ceil();
      unitSize = canvasWidth / (maxValue - minValue + 1);
      if (loutlier < lwhisker) {
        target.drawCircle((loutlier - minValue) * unitSize + canvasLeft,
            canvasHeight / 2,
            options.spotRadius,
            options.outlierLineColor,
            options.outlierFillColor).append();
      }
      if (routlier > rwhisker) {
        target.drawCircle((routlier - minValue) * unitSize + canvasLeft,
            canvasHeight / 2,
            options.spotRadius,
            options.outlierLineColor,
            options.outlierFillColor).append();
      }
    }

    // box
    target.drawRect(
        ((q1 - minValue) * unitSize + canvasLeft).round(),
        (canvasHeight * 0.1).round(),
        ((q3 - q1) * unitSize).round(),
        (canvasHeight * 0.8).round(),
        options.boxLineColor,
        options.boxFillColor).append();
    // left whisker
    target.drawLine(
        ((lwhisker - minValue) * unitSize + canvasLeft).round(),
        (canvasHeight / 2).round(),
        ((q1 - minValue) * unitSize + canvasLeft).round(),
        (canvasHeight / 2).round(),
        options.lineColor).append();
    target.drawLine(
        ((lwhisker - minValue) * unitSize + canvasLeft).round(),
        (canvasHeight / 4).round(),
        ((lwhisker - minValue) * unitSize + canvasLeft).round(),
        (canvasHeight - canvasHeight / 4).round(),
        options.whiskerColor).append();
    // right whisker
    target.drawLine(((rwhisker - minValue) * unitSize + canvasLeft).round(),
        (canvasHeight / 2).round(),
        ((q3 - minValue) * unitSize + canvasLeft).round(),
        (canvasHeight / 2).round(),
        options.lineColor).append();
    target.drawLine(
        ((rwhisker - minValue) * unitSize + canvasLeft).round(),
        (canvasHeight / 4).round(),
        ((rwhisker - minValue) * unitSize + canvasLeft).round(),
        (canvasHeight - canvasHeight / 4).round(),
        options.whiskerColor).append();
    // median line
    target.drawLine(
        ((q2 - minValue) * unitSize + canvasLeft).round(),
        (canvasHeight * 0.1).round(),
        ((q2 - minValue) * unitSize + canvasLeft).round(),
        (canvasHeight * 0.9).round(),
        options.medianColor).append();
    if (options.target) {
      size = (options.get('spotRadius')).ciel();
      target.drawLine(
          ((options.target - minValue) * unitSize + canvasLeft).round(),
          ((canvasHeight / 2) - size).round(),
          ((options.target - minValue) * unitSize + canvasLeft).round(),
          ((canvasHeight / 2) + size).round(),
          options.targetColor).append();
      target.drawLine(
          ((options.get('target') - minValue) * unitSize + canvasLeft - size).round(),
          (canvasHeight / 2).round(),
          ((options.target - minValue) * unitSize + canvasLeft + size).round(),
          (canvasHeight / 2).round(),
          options.targetColor).append();
    }
    target.render();
  }
}

// Setup a very simple "virtual canvas" to make drawing the few shapes we need easier
// This is accessible as $(foo).simpledraw()

class VShape extends coll.ListBase {
  static const SHAPE = 'Shape';
  static const CIRCLE = 'Circle';
  static const PIE_SLICE = 'PieSlice';
  static const RECT = 'Rect';
  static const CONTAINER = 'Container';

  List<int> _list = <int>[];

  VCanvas target;
  int id;
  String type;
  Map args;

  VShape(this.target, this.id, this.type, this.args);
  VShape.list() : this.type = CONTAINER;

  VShape append() {
    target.appendShape(this);
    return this;
  }

  @override
  int operator [](int index) => _list[index];

  @override
  operator []=(int index, value) => _list[index] = value;

  @override
  set length(int newLength) => _list.length = newLength;

  @override
  int get length => _list.length;
}

abstract class VCanvasBase {
  String _pxregex = r'(\d+)(px)?\s*$' /*/i*/;
  String width;
  String height;

  int pixelWidth;
  int pixelHeight;

  BwuSparkline target;
  int lastShapeId;
  dom.CanvasElement canvas;
  int shapeCount = 0;

  void replaceWithShapes(VShape shapeids, List<VShape> shapes);

  VCanvasBase (this.width, this.height, this.target) {
    if (width == null) {
      return;
    }
//    if (target[0]) {
//        target = target[0];
//    }
//    $.data(target, '_jqs_vcanvas', this);
  }

  VShape drawLine(int x1, int y1, int x2, int y2, String lineColor, int lineWidth) {
    return drawShape([[x1, y1], [x2, y2]], lineColor, lineWidth);
  }

  VShape drawShape(List<List<num>> path, String lineColor, int lineWidth, {String fillColor}) {
    return _genShape(VShape.SHAPE, {'path': path, 'lineColor':lineColor, 'fillColor':fillColor, 'lineWidth':lineWidth});
  }

  VShape drawCircle(int x, int y, double radius, String lineColor, String fillColor, int lineWidth) {
    return _genShape(VShape.CIRCLE, {'x':x, 'y':y, 'radius':radius, 'lineColor':lineColor, 'fillColor':fillColor, 'lineWidth':lineWidth});
  }

  VShape drawPieSlice(int x, int y, double radius, int startAngle, int endAngle, String lineColor, String fillColor) {
    return _genShape(VShape.PIE_SLICE, {'x':x, 'y':y, 'radius':radius, 'startAngle':startAngle, 'endAngle':endAngle, 'lineColor':lineColor, 'fillColor':fillColor});
  }

  VShape drawRect(int x, int y, int width, int height, String lineColor, String fillColor) {
    return _genShape(VShape.RECT, {'x':x, 'y':y, 'width':width, 'height':height, 'lineColor':lineColor, 'fillColor':fillColor});
  }

  dom.CanvasElement getElement() {
    return canvas;
  }

  /**
   * Return the most recently inserted shape id
   */
  int getLastShapeId() {
    return lastShapeId;
  }

  /**
   * Clear and reset the canvas
   */
  void reset(); /* {
    throw 'reset not implemented';
  }*/

  // el is here definitivle the canvas element and target BwuSparkline
  void _insert(dom.CanvasElement el, BwuSparkline target) {
    //$(target).html(el);
    target
        ..children.clear()
        ..append(el);
  }

  /**
   * Calculate the pixel dimensions of the canvas
   */
  void _calculatePixelDims(String width, String height, dom.CanvasElement canvas) {
    var match;
    var regex = new RegExp(_pxregex);
    match = regex.firstMatch(height);
    if (match != null) {
      pixelHeight = int.parse(match.group(1), onError: (e) => 0); //[1];
    } else {
      pixelHeight = canvas.clientHeight;
    }
    match = regex.firstMatch(width);
    if (match != null) {
      pixelWidth = int.parse(match.group(1), onError: (e) => 0); //[1];
    } else {
      pixelWidth = canvas.clientWidth;
    }
//    pixelHeight = height;
//    pixelWidth = width;
  }

  /**
   * Generate a shape object and id for later rendering
   */
  VShape _genShape (String shapetype, Map shapeargs) {
    var id = shapeCount++;
    shapeargs['id'] = id;
    return new VShape(this, id, shapetype, shapeargs);
  }

  /**
   * Add a shape to the end of the render queue
   */
  void appendShape(VShape shape); /* {
    throw 'appendShape not implemented';
  }*/

  /**
   * Replace one shape with another
   */
  void replaceWithShape(VShape shapeid, VShape shape); /* {
    throw 'replaceWithShape not implemented';
  }*/

  /**
   * Insert one shape after another in the render queue
   */
  void insertAfterShape(int shapeid, VShape shape); /* {
    throw 'insertAfterShape not implemented';
  }*/

  /**
   * Remove a shape from the queue
   */
  void removeShapeId(int shapeid); /* {
    throw('removeShapeId not implemented');
  },*/

  /**
   * Find a shape at the specified x/y co-ordinates
   */
  void getShapeAt(dom.HtmlElement el, int x, int y); /* {
      alert('getShapeAt not implemented');
  },*/

  /**
   * Render all queued shapes onto the canvas
   */
  void render(); /* {
      alert('render not implemented');
  }*/
}

class VCanvas extends VCanvasBase {
  Map<int,VShape> shapes = <int,VShape>{};
  List<int> shapeseq = [];
  int currentTargetShapeId;
  int pixelHeight;
  int pixelWidth;
  int targetX;
  int targetY;
  bool interact;

  VCanvas(String width, String height, BwuSparkline target, this.interact)
      : super(width, height, target) {
    canvas = target.$['canvas'] as dom.CanvasElement; //dom.document.createElement('canvas');
//    if (target[0]) {
//      target = target[0];
//    }
//    $.data(target, '_jqs_vcanvas', this);
    canvas.style
      ..width = width
      ..height = height;

    //_insert(canvas, target);
    _calculatePixelDims(width, height, canvas);
    canvas.width = pixelWidth;
    canvas.height = pixelHeight;
    canvas
        ..width = pixelWidth
        ..height = pixelHeight;
    _getContext().fillStyle = '#fff';
  }

  dom.CanvasRenderingContext2D _getContext({String lineColor, String fillColor, int lineWidth}) {
    dom.CanvasRenderingContext2D context = canvas.getContext('2d');
    if (lineColor != null) {
      context.strokeStyle = lineColor;
    }
    context.lineWidth = lineWidth == null? 1 : lineWidth;
    if (fillColor != null) {
      context.fillStyle = fillColor;
    }
    return context;
  }

  void reset() {
    var context = _getContext();
    context.clearRect(0, 0, pixelWidth, pixelHeight);
    shapes.clear();
    shapeseq = [];
    currentTargetShapeId = null;
  }

  void _drawShape(int shapeid, List<List<num>> path, String lineColor, String fillColor, int lineWidth) {
    dom.CanvasRenderingContext2D context = _getContext(lineColor: lineColor, fillColor: fillColor, lineWidth: lineWidth);
    int i;
    int plen= path.length;
    context.beginPath();
    context.moveTo(path[0][0] + 0.5, path[0][1] + 0.5);
    for (i = 1; i < plen ; i++) {
      context.lineTo(path[i][0] + 0.5, path[i][1] + 0.5); // the 0.5 offset gives us crisp pixel-width lines
    }
    if (lineColor != null) {
      context.stroke();
    }
    if (fillColor != null) {
      context.fill();
    }
    if (targetX != null && targetY != null &&
      context.isPointInPath(targetX, targetY)) {
      currentTargetShapeId = shapeid;
    }
  }

  void _drawCircle(int shapeid, int x, int y, double radius, String lineColor, String fillColor, int lineWidth) {
    var context = _getContext(lineColor: lineColor, fillColor: fillColor, lineWidth: lineWidth);
    context.beginPath();
    context.arc(x, y, radius, 0, 2 * math.PI, false);
    if (targetX != null && targetY != null &&
      context.isPointInPath(targetX, targetY)) {
      currentTargetShapeId = shapeid;
    }
    if (lineColor != null) {
      context.stroke();
    }
    if (fillColor != null) {
      context.fill();
    }
  }

  void _drawPieSlice(int shapeid, int x, int y, double radius, int startAngle, int endAngle, String lineColor, String fillColor) {
    dom.CanvasRenderingContext2D context = _getContext(lineColor: lineColor, fillColor: fillColor);
    context.beginPath();
    context.moveTo(x, y);
    context.arc(x, y, radius, startAngle, endAngle, false);
    context.lineTo(x, y);
    context.closePath();
    if (lineColor != null) {
      context.stroke();
    }
    if (fillColor != null) {
      context.fill();
    }
    if (targetX != null && targetY != null &&
      context.isPointInPath(targetX, targetY)) {
      currentTargetShapeId = shapeid;
    }
  }

  void _drawRect(int shapeid, int x, int y, int width, int height, String lineColor, String fillColor) {
    return _drawShape(shapeid, [[x, y], [x + width, y], [x + width, y + height], [x, y + height], [x, y]], lineColor, fillColor, null);
  }

  int appendShape(VShape shape) {
    shapes[shape.id] = shape;
    shapeseq.add(shape.id);
    lastShapeId = shape.id;
    return shape.id;
  }

  void replaceWithShape(VShape shapeid, VShape shape) {
    int  i;
    shapes[shape.id] = shape;
    for (i = shapeseq.length - 1; i >= 0; i--) {
      if (shapeseq[i] == shapeid) {
        shapeseq[i] = shape.id;
      }
    }
    shapes.remove(shapeid);
  }

  void replaceWithShapes(List<int> shapeids, List<VShape> shapes) {
    Map shapemap = {};
    int sid;
    int i;
    int first;

    for (i = shapeids.length - 1; i >= 0; i--) {
      shapemap[shapeids[i]] = true;
    }
    for (i = shapeseq.length - 1; i >= 0; i--) {
      sid = shapeseq[i];
      if (shapemap[sid] != null) {
        shapeseq.removeAt(i);
        shapes.remove(sid);
        first = i;
      }
    }
    for (i = shapes.length -1; i >= 0; i--) {
      shapeseq.insert(0, shapes[i].id);
      shapes[shapes[i].id] = shapes[i];
    }
  }

  void insertAfterShape(int shapeid, VShape shape) {
    int i;
    for (i = shapeseq.length - 1; i > 0; i--) {
      if (shapeseq[i] == shapeid) {
        shapeseq.insert(i + 1, shape.id);
        shapes[shape.id] = shape;
        return;
      }
    }
  }

  void removeShapeId(int shapeid) {
    int i;
    for (i = shapeseq.length - 1; i >= 0;  i--) {
      if (shapeseq[i] == shapeid) {
        shapeseq.removeAt(i);
        break;
      }
    }
    shapes.remove(shapeid);
  }

  int getShapeAt(dom.HtmlElement el, int x, int y) {
    targetX = x;
    targetY = y;
    render();
    return currentTargetShapeId;
  }

  void render() {
    int shapeCount = shapeseq.length;
    dom.CanvasRenderingContext2D context = _getContext();
    int shapeid;
    VShape shape;
    int i;
    context.clearRect(0, 0, pixelWidth, pixelHeight);
    for (i = 0; i < shapeCount; i++) {
      shapeid = shapeseq[i];
      shape = shapes[shapeid];
      //this['_draw' + shape.type].apply(this, shape.args);
      switch(shape.type) {
        case VShape.CIRCLE:
          _drawCircle(shape.args['shapeid'], shape.args['x'], shape.args['y'], shape.args['radius'], shape.args['lineColor'], shape.args['fillColor'], shape.args['lineWidth']);
          break;
        case VShape.PIE_SLICE:
          _drawPieSlice(shape.args['shapeid'], shape.args['x'], shape.args['y'], shape.args['radius'], shape.args['startAngle'], shape.args['endAngle'], shape.args['lineColor'], shape.args['fillColor']);
          break;
        case VShape.RECT:
          _drawRect(shape.args['shapeid'], shape.args['x'], shape.args['y'], shape.args['width'], shape.args['height'], shape.args['lineColor'], shape.args['fillColor']);
          break;
        case VShape.SHAPE:
          _drawShape(shape.args['shapeid'], shape.args['path'], shape.args['lineColor'], shape.args['fillColor'], shape.args['lineWidth']);
      }
    }
    if (!interact) {
      // not interactive so no need to keep the shapes array
      shapes = {};
      shapeseq = [];
    }
  }
}

//  VCanvas_vml = createClass(VCanvas_base, {
//    init: function (width, height, target) {
//        var groupel;
//        VCanvas_vml._super.init.call(this, width, height, target);
//        if (target[0]) {
//            target = target[0];
//        }
//        $.data(target, '_jqs_vcanvas', this);
//        this.canvas = document.createElement('span');
//        $(this.canvas).css({ display: 'inline-block', position: 'relative', overflow: 'hidden', width: width, height: height, margin: '0px', padding: '0px', verticalAlign: 'top'});
//        this._insert(this.canvas, target);
//        this._calculatePixelDims(width, height, this.canvas);
//        this.canvas.width = this.pixelWidth;
//        this.canvas.height = this.pixelHeight;
//        groupel = '<v:group coordorigin="0 0" coordsize="' + this.pixelWidth + ' ' + this.pixelHeight + '"' +
//                ' style="position:absolute;top:0;left:0;width:' + this.pixelWidth + 'px;height=' + this.pixelHeight + 'px;"></v:group>';
//        this.canvas.insertAdjacentHTML('beforeEnd', groupel);
//        this.group = $(this.canvas).children()[0];
//        this.rendered = false;
//        this.prerender = '';
//    },
//
//    _drawShape: function (shapeid, path, lineColor, fillColor, lineWidth) {
//        var vpath = [],
//            initial, stroke, fill, closed, vel, plen, i;
//        for (i = 0, plen = path.length; i < plen; i++) {
//            vpath[i] = '' + (path[i][0]) + ',' + (path[i][1]);
//        }
//        initial = vpath.splice(0, 1);
//        lineWidth = lineWidth === undefined ? 1 : lineWidth;
//        stroke = lineColor === undefined ? ' stroked="false" ' : ' strokeWeight="' + lineWidth + 'px" strokeColor="' + lineColor + '" ';
//        fill = fillColor === undefined ? ' filled="false"' : ' fillColor="' + fillColor + '" filled="true" ';
//        closed = vpath[0] === vpath[vpath.length - 1] ? 'x ' : '';
//        vel = '<v:shape coordorigin="0 0" coordsize="' + this.pixelWidth + ' ' + this.pixelHeight + '" ' +
//             ' id="jqsshape' + shapeid + '" ' +
//             stroke +
//             fill +
//            ' style="position:absolute;left:0px;top:0px;height:' + this.pixelHeight + 'px;width:' + this.pixelWidth + 'px;padding:0px;margin:0px;" ' +
//            ' path="m ' + initial + ' l ' + vpath.join(', ') + ' ' + closed + 'e">' +
//            ' </v:shape>';
//        return vel;
//    },
//
//    _drawCircle: function (shapeid, x, y, radius, lineColor, fillColor, lineWidth) {
//        var stroke, fill, vel;
//        x -= radius;
//        y -= radius;
//        stroke = lineColor === undefined ? ' stroked="false" ' : ' strokeWeight="' + lineWidth + 'px" strokeColor="' + lineColor + '" ';
//        fill = fillColor === undefined ? ' filled="false"' : ' fillColor="' + fillColor + '" filled="true" ';
//        vel = '<v:oval ' +
//             ' id="jqsshape' + shapeid + '" ' +
//            stroke +
//            fill +
//            ' style="position:absolute;top:' + y + 'px; left:' + x + 'px; width:' + (radius * 2) + 'px; height:' + (radius * 2) + 'px"></v:oval>';
//        return vel;
//
//    },
//
//    _drawPieSlice: function (shapeid, x, y, radius, startAngle, endAngle, lineColor, fillColor) {
//        var vpath, startx, starty, endx, endy, stroke, fill, vel;
//        if (startAngle === endAngle) {
//            return '';  // VML seems to have problem when start angle equals end angle.
//        }
//        if ((endAngle - startAngle) === (2 * Math.PI)) {
//            startAngle = 0.0;  // VML seems to have a problem when drawing a full circle that doesn't start 0
//            endAngle = (2 * Math.PI);
//        }
//
//        startx = x + Math.round(Math.cos(startAngle) * radius);
//        starty = y + Math.round(Math.sin(startAngle) * radius);
//        endx = x + Math.round(Math.cos(endAngle) * radius);
//        endy = y + Math.round(Math.sin(endAngle) * radius);
//
//        if (startx === endx && starty === endy) {
//            if ((endAngle - startAngle) < Math.PI) {
//                // Prevent very small slices from being mistaken as a whole pie
//                return '';
//            }
//            // essentially going to be the entire circle, so ignore startAngle
//            startx = endx = x + radius;
//            starty = endy = y;
//        }
//
//        if (startx === endx && starty === endy && (endAngle - startAngle) < Math.PI) {
//            return '';
//        }
//
//        vpath = [x - radius, y - radius, x + radius, y + radius, startx, starty, endx, endy];
//        stroke = lineColor === undefined ? ' stroked="false" ' : ' strokeWeight="1px" strokeColor="' + lineColor + '" ';
//        fill = fillColor === undefined ? ' filled="false"' : ' fillColor="' + fillColor + '" filled="true" ';
//        vel = '<v:shape coordorigin="0 0" coordsize="' + this.pixelWidth + ' ' + this.pixelHeight + '" ' +
//             ' id="jqsshape' + shapeid + '" ' +
//             stroke +
//             fill +
//            ' style="position:absolute;left:0px;top:0px;height:' + this.pixelHeight + 'px;width:' + this.pixelWidth + 'px;padding:0px;margin:0px;" ' +
//            ' path="m ' + x + ',' + y + ' wa ' + vpath.join(', ') + ' x e">' +
//            ' </v:shape>';
//        return vel;
//    },
//
//    _drawRect: function (shapeid, x, y, width, height, lineColor, fillColor) {
//        return this._drawShape(shapeid, [[x, y], [x, y + height], [x + width, y + height], [x + width, y], [x, y]], lineColor, fillColor);
//    },
//
//    reset: function () {
//        this.group.innerHTML = '';
//    },
//
//    appendShape: function (shape) {
//        var vel = this['_draw' + shape.type].apply(this, shape.args);
//        if (this.rendered) {
//            this.group.insertAdjacentHTML('beforeEnd', vel);
//        } else {
//            this.prerender += vel;
//        }
//        this.lastShapeId = shape.id;
//        return shape.id;
//    },
//
//    replaceWithShape: function (shapeid, shape) {
//        var existing = $('#jqsshape' + shapeid),
//            vel = this['_draw' + shape.type].apply(this, shape.args);
//        existing[0].outerHTML = vel;
//    },
//
//    replaceWithShapes: function (shapeids, shapes) {
//        // replace the first shapeid with all the new shapes then toast the remaining old shapes
//        var existing = $('#jqsshape' + shapeids[0]),
//            replace = '',
//            slen = shapes.length,
//            i;
//        for (i = 0; i < slen; i++) {
//            replace += this['_draw' + shapes[i].type].apply(this, shapes[i].args);
//        }
//        existing[0].outerHTML = replace;
//        for (i = 1; i < shapeids.length; i++) {
//            $('#jqsshape' + shapeids[i]).remove();
//        }
//    },
//
//    insertAfterShape: function (shapeid, shape) {
//        var existing = $('#jqsshape' + shapeid),
//             vel = this['_draw' + shape.type].apply(this, shape.args);
//        existing[0].insertAdjacentHTML('afterEnd', vel);
//    },
//
//    removeShapeId: function (shapeid) {
//        var existing = $('#jqsshape' + shapeid);
//        this.group.removeChild(existing[0]);
//    },
//
//    getShapeAt: function (el, x, y) {
//        var shapeid = el.id.substr(8);
//        return shapeid;
//    },
//
//    render: function () {
//        if (!this.rendered) {
//            // batch the intial render into a single repaint
//            this.group.innerHTML = this.prerender;
//            this.rendered = true;
//        }
//    }
//  }


//  bool getDefaults;
//  String createClass;
//  int SPFormat;
//  int clipval;
//  int quartile;
//  int normalizeValue;
//  int normalizeValues;
//  int remove;
//  int isNumber;
//  int all;
//  int sum;
//  String addCSS;
//  int ensureArray;
//  int formatNumber;
//  int RangeMap;
//  int MouseHandler;
//  int Tooltip;
//  int barHighlightMixin;
//  int line;
//  int bar;
//  int tristate;
//  int discrete;
//  int bullet;
//  int pie;
//  int box;
//  int defaultStyles;
//  int initStyles;
//  int VShape;
//  int VCanvas_base;
//  int VCanvas_canvas;
//  int VCanvas_vml;
//  int pending;
//  int shapeCount = 0;
//  Map UNSET_OPTION = {};


///**
// * Utilities
// */
//
//createClass = function (/* [baseclass, [mixin, ...]], definition */) {
//    var Class, args;
//    Class = function () {
//        this.init.apply(this, arguments);
//    };
//    if (arguments.length > 1) {
//        if (arguments[0]) {
//            Class.prototype = $.extend(new arguments[0](), arguments[arguments.length - 1]);
//            Class._super = arguments[0].prototype;
//        } else {
//            Class.prototype = arguments[arguments.length - 1];
//        }
//        if (arguments.length > 2) {
//            args = Array.prototype.slice.call(arguments, 1, -1);
//            args.unshift(Class.prototype);
//            $.extend.apply($, args);
//        }
//    } else {
//        Class.prototype = arguments[0];
//    }
//    Class.prototype.cls = Class;
//    return Class;
//};



//// convience method to avoid needing the new operator
//$.spformat = function(format, fclass) {
//    return new SPFormat(format, fclass);
//};