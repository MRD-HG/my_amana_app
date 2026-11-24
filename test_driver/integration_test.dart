// Host-side driver for `flutter drive`: runs integration_test/ on the device
// and saves the screenshots taken by the test into ./screenshots/.

import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (String name, List<int> bytes, [Map<String, Object?>? args]) async {
      final file = File('screenshots/$name.png');
      file.createSync(recursive: true);
      file.writeAsBytesSync(bytes);
      return true;
    },
  );
}
