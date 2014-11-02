library device;

import 'dart:io';
import 'package:yaml/yaml.dart';
import 'dart:convert';
import 'dart:mirrors';
import 'test/testdevice.dart';
import 'package:event_commander/event_commander.dart';

class DeviceConnector {


  List<String> modules;
  EventBus event_bus;

  DeviceConnector(this.event_bus) {
    print("Path:" + Platform.script.resolve('../lib/device/config.yaml').toFilePath());
    String config = new File("../lib/device/config.yaml").readAsStringSync();
    YamlMap m = loadYaml(config);
    modules = m['devices'].split(new RegExp(" "));
    print("modules:" + JSON.encode(modules));

    MirrorSystem mirrors = currentMirrorSystem();
    LibraryMirror lm = mirrors.libraries.values.firstWhere(
            (LibraryMirror lm) => lm.qualifiedName == new Symbol('device'));

    // TODO this does not work in Mirrors!
    // ClassMirror cm = lm.declarations[new Symbol('TestDevice')];
    // InstanceMirror im = cm.newInstance(new Symbol(''), []);
    // var tc = im.reflectee;
    // print("Device handler:"+tc.getName());

    TestDevice test_device = new TestDevice(event_bus);


  }

}




