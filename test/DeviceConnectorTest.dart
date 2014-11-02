import 'package:unittest/unittest.dart';
import 'package:OpenRaceTiming/device/device.dart';

main() {

  test('DeviceInit',(){
    expect(new DeviceConnector(null).modules.isEmpty, false);  // TODO does not work!
  });


}