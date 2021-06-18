import 'package:pigeon/pigeon.dart';

class StoredGlucoseRequest {
  double? startTimestamp;
  double? endTimestamp;
}

class StoredGlucoseResponse {
  // TODO: Use an actual structured response format when Pigeon supports it.
  //       https://github.com/flutter/flutter/issues/63468
  List<String>? serializedStoredGlucoseValues;
}

class StoredGlucoseSample {
  // Seconds since epoch.
  double? timestamp;
  // Glucose value in mg/dL.
  int? quantity;
}

@HostApi()
abstract class Api {
  void listenForHealthData();

  @async
  StoredGlucoseResponse getGlucoseSamples(StoredGlucoseRequest request);
}

@FlutterApi()
abstract class CallbackApi {
  void newSample(StoredGlucoseSample glucoseSample);
}
