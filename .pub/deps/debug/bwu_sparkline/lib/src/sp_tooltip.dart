library bwu_sparkline.sp_tooltip;

import 'dart:html' as dom;
import 'dart:async' as async;

import 'package:polymer/polymer.dart';

import 'package:bwu_sparkline/bwu_sparkline.dart';

@CustomTag('sp-tooltip')
class SpTooltip extends PolymerElement with ChangeNotifier  {
  SpTooltip.created() : super.created();

  factory SpTooltip.singleton() {
    if(_toolTip == null) {
      _toolTip = new dom.Element.tag('sp-tooltip');
    }
    return _toolTip;
  }

  static SpTooltip _sizeTip;
  static SpTooltip _toolTip;

  Options options;

  @reflectable @observable bool get showTooltip => __$showTooltip; bool __$showTooltip = false; @reflectable set showTooltip(bool value) { __$showTooltip = notifyPropertyChange(#showTooltip, __$showTooltip, value); }

  int mousex;
  int mousey;
  int offsetLeft;
  int offsetTop;
  int scrollRight;
  int width;
  int height;
  int tooltipOffsetX;
  int tooltipOffsetY;
  bool hidden;
  dom.HtmlElement container;

  dom.NodeValidator nodeValidator = new dom.NodeValidatorBuilder()
      ..allowElement('DIV', attributes: ['class'])
      ..allowElement('SPAN', attributes: ['style']);

  async.StreamSubscription resizeSubscription;
  async.StreamSubscription scrollSubscription;

  bool isSizeTip = false;

  bool _isAttached = false;

  @override
  void attached() {
    super.attached();

    if(isSizeTip) return;

    offsetLeft = offset.left;
    if(offsetLeft == null) offsetLeft = 0;

    offsetTop = offset.top;
    if(offsetTop == null) offsetTop = 0 ;

    hidden = true;

    if(resizeSubscription != null) resizeSubscription.cancel();
    if(scrollSubscription != null) scrollSubscription.cancel();
    resizeSubscription = dom.window.onResize.listen((e) => updateWindowDims());
    scrollSubscription = dom.window.onScroll.listen((e) => updateWindowDims());

    updateWindowDims();

    _isAttached = true;
  }

  @override
  void detached() {
    super.detached();
    _isAttached = false;
  }

  void init(Options options) {
    this.options = options;
    this.classes.add(options.tooltip.cssClass);

    container = options.tooltip.container != null ? options.tooltip.container : dom.document.body;

    tooltipOffsetX = options.tooltip.offsetX;
    if(tooltipOffsetX == null) tooltipOffsetX = 10;

    tooltipOffsetY = options.tooltip.offsetY;
    if(tooltipOffsetY == null) tooltipOffsetY = 12;

    // remove any previous lingering tooltip
    if(_sizeTip != null) _sizeTip.remove();
    if(_isAttached) remove();
    _sizeTip = (new dom.Element.tag('sp-tooltip') as SpTooltip)
      ..isSizeTip = true
      ..classes.add(options.tooltip.cssClass)
      ..style.position ='static'
      ..style.visibility = 'hidden'
      ..style.float = 'left';

    container.append(this);
  }

  void updateWindowDims() {
    scrollTop = dom.window.scrollY;
    scrollLeft = dom.window.scrollX;
    scrollRight = scrollLeft + dom.window.innerWidth; // TODO with
    updatePosition();
  }

  void getSize(dom.DocumentFragment content) {
    _sizeTip
      ..children.clear()
      ..append(content);

    container.append(_sizeTip);
    var sizeElement = (_sizeTip.$['content'] as dom.ContentElement)
        .getDistributedNodes().firstWhere((e) => e is dom.HtmlElement, orElse: () => new dom.DivElement());
    if(sizeElement == null) {
      width = 0;
      height = 0;
    } else {
      width = sizeElement.offsetWidth + 1;
      height = sizeElement.offsetHeight;
    }
    _sizeTip.remove();
  }

  void setContent(String content) {
    if (content == null || content.isEmpty) {
      this.style.visibility = 'hidden';
      hidden = true;
      return;
    }
    var c = new dom.DocumentFragment.html(content, validator: nodeValidator);
    getSize(c.clone(true));
        this..children.clear()
        ..append(c)
        ..style.width = '${width}px'
        ..style.height = '${height}px'
        ..style.visibility = 'visible';
    if (hidden) {
      hidden = false;
      updatePosition();
    }
  }

  void updatePosition([int x, int y]) {
    if (x == null) {
      if (mousex == null) {
        return;
      }
      x = mousex - offsetLeft;
      y = mousey - offsetTop;
    } else {
      mousex = x = x - offsetLeft;
      mousey = y = y - offsetTop;
    }
    if (height == null || width == null || hidden) {
      return;
    }

    y -= height + tooltipOffsetY;
    x += tooltipOffsetX;

    if (y < scrollTop) {
      y = scrollTop;
    }
    if (x < scrollLeft) {
      x = scrollLeft;
    } else if (x + width > scrollRight) {
      x = scrollRight - width;
    }

    style
      ..left = '${x}px'
      ..top = '${y}px';
  }


  @override
  void remove() {
    super.remove();

    if(isSizeTip) return;

    _sizeTip.remove();
    _sizeTip = _toolTip = null;
    if(resizeSubscription != null) resizeSubscription.cancel();
    if(scrollSubscription != null) scrollSubscription.cancel();
  }
}