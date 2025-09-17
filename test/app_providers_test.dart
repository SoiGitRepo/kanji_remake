import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kanji_remake/providers/app_providers.dart';

void main() {
  group('AppProviders setters persist and update state', () {
    test('theme mode, language and jlpt level', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final container = ProviderContainer(overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ]);

      // Defaults
      expect(container.read(themeModeProvider), false);
      expect(container.read(appLanguageProvider), 'en');
      expect(container.read(lessonJlptLevelProvider), 5);

      // Update theme
      container.read(setThemeModeProvider)(true);
      expect(container.read(themeModeProvider), true);
      expect(prefs.getBool('darkMode'), true);

      // Update language
      container.read(setAppLanguageProvider)('zh');
      expect(container.read(appLanguageProvider), 'zh');
      expect(prefs.getString('language'), 'zh');

      // Update JLPT
      container.read(setJlptLevelProvider)(4);
      expect(container.read(lessonJlptLevelProvider), 4);
      expect(prefs.getInt('jlptLevel'), 4);

      container.dispose();
    });
  });
}
