
import 'dart:async';

import 'package:flutter/services.dart';

class WhatOsRust {
  static const MethodChannel _channel = MethodChannel('what_os_rust');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
