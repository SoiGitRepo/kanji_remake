import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanji_remake/model/lesson_pre.dart';
import 'package:kanji_remake/model/kanji_word.dart';
import 'package:kanji_remake/providers/lesson_providers.dart';

void main() {
  test('lessonsProvider addLesson updates state', () async {
    final container = ProviderContainer();

    expect(container.read(lessonsProvider), isEmpty);
    final words = [
      KanjiWord(word: '日本語', hiragana: 'にほんご', meanings: ['Japanese']),
      KanjiWord(word: '学校', hiragana: 'がっこう', meanings: ['school']),
    ];
    final lesson = LessonPre(0, words);
    container.read(lessonsProvider.notifier).addLesson(lesson);

    final lessons = container.read(lessonsProvider);
    expect(lessons.length, 1);
    expect(lessons.first.lessonID, 0);
    expect(lessons.first.wordList.length, 2);

    container.dispose();
  });
}
