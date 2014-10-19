library bwu_sparkline.options_base;

abstract class OptionsBase {
  List<String> get optionKeys => [];
  Map get optionValues => {};
  Map get optionDefaults;

  OptionsBase() {
    optionsInitDefaults();
  }

  OptionsBase.uninitialized();

  void extend(OptionsBase o) {
    if(o == null) {
      return;
    }
    Map otherOv = o.optionValues;
    for(String key in otherOv.keys) {
      if(otherOv.containsKey(key)) {
        this[key] = o[key];
      }
    }
  }

  void optionsInitDefaults() {}

  dynamic operator [](String key) {
    return null;
  }

  void operator []=(String key, val) {
    throw 'Invalid option "${key}"';
  }

  dynamic getValue(String key, dynamic defaultValue) {
    if(optionKeys.contains(key)) {
      return this[key];
    } else {
      return defaultValue;
    }
  }
}
