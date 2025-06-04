import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/services/firebase_auth.dart';
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

/// App language provider
final appLanguageProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString('language') ?? 'en';
});

/// User authentication state provider
final authStateProvider = StreamProvider<bool>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges().map((user) => user != null);
});
