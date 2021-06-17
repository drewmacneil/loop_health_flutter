// Autogenerated from Pigeon (v0.2.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types
// @dart = 2.12
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

import 'package:flutter/services.dart';

class StoredGlucoseResponse {
  List<Object?>? serializedStoredGlucoseValues;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['serializedStoredGlucoseValues'] = serializedStoredGlucoseValues;
    return pigeonMap;
  }

  static StoredGlucoseResponse decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return StoredGlucoseResponse()
      ..serializedStoredGlucoseValues = pigeonMap['serializedStoredGlucoseValues'] as List<Object?>?;
  }
}

class StoredGlucoseRequest {
  double? startTimestamp;
  double? endTimestamp;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['startTimestamp'] = startTimestamp;
    pigeonMap['endTimestamp'] = endTimestamp;
    return pigeonMap;
  }

  static StoredGlucoseRequest decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return StoredGlucoseRequest()
      ..startTimestamp = pigeonMap['startTimestamp'] as double?
      ..endTimestamp = pigeonMap['endTimestamp'] as double?;
  }
}

class Api {
  /// Constructor for [Api].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  Api({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  Future<StoredGlucoseResponse> getGlucoseSamples(StoredGlucoseRequest arg) async {
    final Object encoded = arg.encode();
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.Api.getGlucoseSamples', const StandardMessageCodec(), binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(encoded) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null,
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return StoredGlucoseResponse.decode(replyMap['result']!);
    }
  }
}
