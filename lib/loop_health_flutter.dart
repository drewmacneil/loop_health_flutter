import 'dart:async';

import 'messages.dart';
import 'stored_glucose_sample.dart';

class LoopHealthFlutter {
  static Api _api = Api();

  // TODO: Accept DateTime arguments for sample retrieval window.
  static Future<List<StoredGlucoseSample>> getGlucoseSamples() async {
    return (await _api.getGlucoseSamples(StoredGlucoseRequest()
          ..startTimestamp = DateTime.now()
                  .subtract(Duration(hours: 1))
                  .millisecondsSinceEpoch /
              1000))
        .deserialize();
  }
}
