import 'dart:async';

import 'messages.dart';

class LoopHealthFlutter {
  static Api _api = Api();

  static Future<String?> get platformVersion async {
    Version version = await _api.getPlatformVersion();
    return version.string;
  }
}
