import 'package:flutter/services.dart';

class HealthBridge {
  static const MethodChannel _channel = MethodChannel('runnerprime/health');

  static Future<bool> isAvailable() async {
    try {
      final result = await _channel.invokeMethod<bool>('isAvailable');
      return result ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> requestPermissions() async {
    try {
      final result = await _channel.invokeMethod<bool>('requestPermissions');
      return result ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<Map<String, dynamic>> readSummary() async {
    try {
      final result = await _channel.invokeMapMethod<String, dynamic>('readSummary');
      return result ?? <String, dynamic>{};
    } catch (_) {
      return <String, dynamic>{};
    }
  }
}
