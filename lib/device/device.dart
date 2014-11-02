import 'dart:io';
import 'package:yaml/yaml.dart';

class DeviceConnector {


  DeviceConnector() {
    print("Path:"+Platform.script.resolve('../lib/device/config.yaml').toFilePath());
    new File("../lib/device/config.yaml").readAsString().then((String lines) {
      var doc = loadYaml(lines);
      print("Config loaded, $doc");
    }).catchError((e)=>print("Unable to open device connector config file:$e"));

  }

}


