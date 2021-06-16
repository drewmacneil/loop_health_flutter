
import 'dart:async';

import 'package:flutter/services.dart';

class LoopHealthFlutter {
  static const MethodChannel _channel =
      const MethodChannel('loop_health_flutter');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
