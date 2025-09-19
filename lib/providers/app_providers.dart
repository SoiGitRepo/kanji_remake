import 'dart:io' show Platform;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/services/firebase_auth.dart';
import 'package:kanji_remake/services/sync_service.dart';
import 'package:kanji_remake/services/sync_service_firebase.dart';
import 'package:kanji_remake/services/sync_service_icloud.dart';
import 'package:kanji_remake/config/sync_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global provider for SharedPreferences instance
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Should be overridden in ProviderScope');
});

/// Authentication service provider
final authServiceProvider = Provider<AuthServiceImpl>((ref) {
  return AuthServiceImpl();
});

/// App theme mode provider (light/dark)
final themeModeProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getBool('darkMode') ?? false;
});

/// Setter for theme mode, persists to SharedPreferences
final setThemeModeProvider = Provider<void Function(bool)>((ref) {
  return (bool isDark) {
    final prefs = ref.read(sharedPreferencesProvider);
    ref.read(themeModeProvider.notifier).state = isDark;
    prefs.setBool('darkMode', isDark);
  };
});

/// App language provider
final appLanguageProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString('language') ?? 'en';
});

/// Setter for app language, persists to SharedPreferences
final setAppLanguageProvider = Provider<void Function(String)>((ref) {
  return (String languageCode) {
    final prefs = ref.read(sharedPreferencesProvider);
    ref.read(appLanguageProvider.notifier).state = languageCode;
    prefs.setString('language', languageCode);
  };
});

/// JLPT level setting provider (default 5)
final lessonJlptLevelProvider = StateProvider<int>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getInt('jlptLevel') ?? 5;
});

/// Setter for JLPT level, persists to SharedPreferences
final setJlptLevelProvider = Provider<void Function(int)>((ref) {
  return (int jlpt) {
    final prefs = ref.read(sharedPreferencesProvider);
    ref.read(lessonJlptLevelProvider.notifier).state = jlpt;
    prefs.setInt('jlptLevel', jlpt);
  };
});

/// User authentication state provider
final authStateProvider = StreamProvider<bool>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.onUserChanges().map((user) => user != null);
});

/// Sync service provider (Android: Firebase, iOS: iCloud)
final syncServiceProvider = Provider<SyncService>((ref) {
  if (Platform.isAndroid) {
    return FirebaseSyncService();
  } else if (Platform.isIOS) {
    // iOS 默认改为 Firebase，如需切换到 iCloud 修改 SyncConfig.iosUseICloud
    if (SyncConfig.iosUseICloud) {
      return ICloudSyncService();
    } else {
      return FirebaseSyncService();
    }
  }
  // 默认返回一个不可用的占位实现
  return _NoopSyncService();
});

/// 当前是否使用 iCloud 同步（用于 UI 行为分支）
final isICloudSyncProvider = Provider<bool>((ref) {
  if (Platform.isIOS) return SyncConfig.iosUseICloud;
  return false;
});

class _NoopSyncService implements SyncService {
  @override
  Future<void> disable() async {}

  @override
  Future<void> enable() async {}

  @override
  Future<bool> isAvailable() async => false;

  @override
  Future<Map<String, dynamic>?> pullProgress() async => null;

  @override
  Future<void> pushProgress(Map<String, dynamic> data) async {}
}
