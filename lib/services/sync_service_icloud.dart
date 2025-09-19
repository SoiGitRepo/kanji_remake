import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';
import 'package:kanji_remake/services/sync_service.dart';

/// iOS 平台：通过 MethodChannel 使用 iCloud Key-Value（NSUbiquitousKeyValueStore）实现
class ICloudSyncService implements SyncService {
  static const MethodChannel _channel = MethodChannel('com.soigrames.kanjiremake/icloud_sync');

  @override
  Future<bool> isAvailable() async {
    if (!Platform.isIOS) return false;
    try {
      final available = await _channel.invokeMethod<bool>('isAvailable');
      return available ?? false;
    } on PlatformException {
      return false;
    }
  }

  @override
  Future<void> enable() async {
    if (!Platform.isIOS) return;
    await _channel.invokeMethod('enable');
  }

  @override
  Future<void> disable() async {
    if (!Platform.isIOS) return;
    await _channel.invokeMethod('disable');
  }

  @override
  Future<void> pushProgress(Map<String, dynamic> data) async {
    if (!Platform.isIOS) return;
    await _channel.invokeMethod('push', {
      'data': data,
    });
  }

  @override
  Future<Map<String, dynamic>?> pullProgress() async {
    if (!Platform.isIOS) return null;
    final result = await _channel.invokeMapMethod<String, dynamic>('pull');
    if (result == null) return null;
    final payload = result['data'];
    if (payload is Map<String, dynamic>) return payload;
    return null;
  }
}
