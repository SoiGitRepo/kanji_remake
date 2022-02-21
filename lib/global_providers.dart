import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/services/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final authServiceProvider = Provider<AuthServiceImpl>((ref) {
  return AuthServiceImpl();
});
