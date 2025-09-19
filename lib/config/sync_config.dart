/// 同步后端切换配置
///
/// - iOS 默认改为 Firebase（与 Android 一致）
/// - 如需切换回 iCloud，将 `iosUseICloud` 改为 true 即可
class SyncConfig {
  static const bool iosUseICloud = false;
}
