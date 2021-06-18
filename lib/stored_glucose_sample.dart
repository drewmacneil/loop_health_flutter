import 'package:loop_health_flutter/messages.dart';

class DeserializedStoredGlucoseSample {
  DateTime? timestamp;
  int? quantity;
}

extension DeserializeStoredGlucoseSample on StoredGlucoseResponse {
  List<DeserializedStoredGlucoseSample> deserialize() {
    List<DeserializedStoredGlucoseSample> samples = List.from([]);
    this.serializedStoredGlucoseValues!.cast<String>().forEach((e) {
      List<String> values = e.split('|');
      assert(values.length == 2);
      DeserializedStoredGlucoseSample sample =
          DeserializedStoredGlucoseSample();
      sample.timestamp = DateTime.fromMillisecondsSinceEpoch(
          (double.parse(values[0]) * 1000).round());
      sample.quantity = double.parse(values[1]).round();
      samples.add(sample);
    });
    return samples;
  }
}
