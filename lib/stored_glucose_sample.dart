import 'package:loop_health_flutter/messages.dart';

class StoredGlucoseSample {
  DateTime? timestamp;
  int? quantity;
}

extension DeserializeStoredGlucoseSample on StoredGlucoseResponse {
  List<StoredGlucoseSample> deserialize() {
    List<StoredGlucoseSample> samples = List.from([]);
    this.serializedStoredGlucoseValues!.cast<String>().map((e) {
      List<String> values = e.split('|');
      assert(values.length == 2);
      StoredGlucoseSample sample = StoredGlucoseSample();
      sample.timestamp = DateTime.fromMillisecondsSinceEpoch(
          (double.parse(values[0]) * 1000).round());
      sample.quantity = int.parse(values[1]);
    });
    return samples;
  }
}
