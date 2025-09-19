import 'dart:async';

/// 统一的学习进度同步服务接口
///
/// 注意：
/// - Android 侧建议使用 Firebase（Auth + Firestore）
/// - iOS 侧使用 iCloud（NSUbiquitousKeyValueStore，通过 MethodChannel）
abstract class SyncService {
  /// 当前平台是否可用（如 iOS 是否启用 iCloud 能力）
  Future<bool> isAvailable();

  /// 启用同步（iOS 为静默启用；Android 需确保已登录）
  Future<void> enable();

  /// 关闭同步
  Future<void> disable();

  /// 推送本地进度到云端
  /// 约定：data 为可 JSON 序列化的对象
  Future<void> pushProgress(Map<String, dynamic> data);

  /// 从云端拉取进度
  Future<Map<String, dynamic>?> pullProgress();
}
