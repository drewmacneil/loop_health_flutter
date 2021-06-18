import 'dart:async';

import 'messages.dart';
import 'stored_glucose_sample.dart';

class LoopHealthFlutter {
  static Api _api = Api();

  static Future<void> listenForHealthData() async {
    CallbackApi.setup(CallbackApiImpl());
    return await _api.listenForHealthData();
  }

  // TODO: Accept DateTime arguments for sample retrieval window.
  static Future<List<DeserializedStoredGlucoseSample>>
      getGlucoseSamples() async {
    return (await _api.getGlucoseSamples(StoredGlucoseRequest()
          ..startTimestamp = DateTime.now()
                  .subtract(Duration(hours: 1))
                  .millisecondsSinceEpoch /
              1000))
        .deserialize();
  }
}

class CallbackApiImpl extends CallbackApi {
  @override
  void newSample(StoredGlucoseSample glucoseSample) {
    print(glucoseSample.quantity);
  }
}
