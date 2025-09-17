import 'package:flutter_test/flutter_test.dart';
import 'package:kanji_remake/model/kanji_field.dart';
import 'package:kanji_remake/model/kanji_word.dart';
import 'package:kanji_remake/model/question_card.dart';
import 'package:kanji_remake/providers/question_providers.dart';

void main() {
  group('QuestionCardsNotifier', () {
    test('initializeCards builds non-empty cards and supports requeue', () {
      final notifier = QuestionCardsNotifier();
      final words = [
        KanjiWord(word: '日本語', hiragana: 'にほんご', meanings: ['Japanese']),
        KanjiWord(word: '学校', hiragana: 'がっこう', meanings: ['school']),
        KanjiWord(word: '先生', hiragana: 'せんせい', meanings: ['teacher']),
      ];

      notifier.initializeCards(words);
      expect(notifier.state.isNotEmpty, true);

      final before = List<QuestionCard>.from(notifier.state);
      notifier.requeueAtEnd(0);
      expect(notifier.state.length, before.length);
      expect(notifier.state.last.kanjiWord.word, before.first.kanjiWord.word);

      notifier.shuffle();
      expect(notifier.state.length, before.length);
    });
  });

  group('Choice generation', () {
    test('cardTypeToFieldMap contains expected mappings', () {
      expect(cardTypeToFieldMap[QuestionCardType.chooseKanji]!.contains(KanjiField.kanjikata), true);
      expect(cardTypeToFieldMap[QuestionCardType.kanjiOnly]!.contains(KanjiField.hiragana), true);
      expect(cardTypeToFieldMap[QuestionCardType.kanjiOnly]!.contains(KanjiField.meaning), true);
    });
  });
}
