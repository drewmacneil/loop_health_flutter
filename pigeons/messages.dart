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

@HostApi()
abstract class Api {
  @async
  StoredGlucoseResponse getGlucoseSamples(StoredGlucoseRequest request);
}
