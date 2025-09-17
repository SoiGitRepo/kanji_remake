import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/kanji_field.dart';
import 'package:kanji_remake/model/kanji_word_1.dart';
import 'package:kanji_remake/model/question_card.dart';
import 'package:kanji_remake/providers/lesson_providers.dart';

/// State notifier for managing question cards order
class QuestionCardsNotifier extends StateNotifier<List<QuestionCard>> {
  QuestionCardsNotifier() : super([]);

  /// Initialize question cards from kanji words
  void initializeCards(List<KanjiWord> kanjiWords) {
    final List<QuestionCard> cards = [];
    final questionCardType = kanjiWords.length <= 4 
        ? questionCardTypeSet 
        : questionCardTypeSet.skip(1);
    
    int j = 0;
    for (; j < kanjiWords.length - 1; j += 2) {
      for (int i = 0; i < questionCardType.length; i++) {
        cards.add(QuestionCard(
          kanjiWords[j],
          questionCardType.elementAt(i),
          cardTypeToFieldMap[questionCardType.elementAt(i)] ?? [KanjiField.all],
        ));
        cards.add(QuestionCard(
          kanjiWords[j + 1],
          questionCardType.elementAt(i),
          cardTypeToFieldMap[questionCardType.elementAt(i)] ?? [KanjiField.all],
        ));
      }
    }
    
    // Handle odd number of words
    if (j < kanjiWords.length) {
      for (int i = 0; i < questionCardType.length; i++) {
        cards.add(QuestionCard(
          kanjiWords[j],
          questionCardType.elementAt(i),
          cardTypeToFieldMap[questionCardType.elementAt(i)] ?? [KanjiField.all],
        ));
      }
    }
    
    if (kanjiWords.length > 4) {
      cards.shuffle();
    }
    
    state = cards;
  }

  /// Shuffle cards
  void shuffle() {
    final shuffled = [...state]..shuffle();
    state = shuffled;
  }

  /// Remove a card at index
  void removeAt(int index) {
    if (index >= 0 && index < state.length) {
      final next = [...state];
      next.removeAt(index);
      state = next;
    }
  }

  /// Append a card to the end
  void add(QuestionCard card) {
    state = [...state, card];
  }

  /// Requeue current card to the end (used when answered wrong)
  void requeueAtEnd(int index) {
    if (index >= 0 && index < state.length) {
      final next = [...state];
      final card = next.removeAt(index);
      next.add(card);
      state = next;
    }
  }
}

/// Provider for current lesson's kanji words
final currentLessonKanjiWordsProvider = StateProvider<List<KanjiWord>>((ref) {
  final selectedLesson = ref.watch(selectedLessonProvider);
  return selectedLesson?.wordList ?? [];
});

/// Provider for question cards state notifier
final questionCardsProvider = StateNotifierProvider<QuestionCardsNotifier, List<QuestionCard>>((ref) {
  final notifier = QuestionCardsNotifier();
  
  // Initialize cards when kanji words change
  ref.listen(currentLessonKanjiWordsProvider, (previous, next) {
    if (previous != next) {
      notifier.initializeCards(next);
    }
  });
  
  return notifier;
});

/// Provider for current progress index
final currentProgressProvider = StateProvider<int>((ref) {
  ref.watch(currentLessonKanjiWordsProvider); // Reset when words change
  return 0;
});

/// Provider for current field progress
final currentFieldProgressProvider = StateProvider<int>((ref) {
  ref.watch(currentProgressProvider); // Reset when progress changes
  return 0;
});

/// Provider for tracking if answer was wrong
final isWrongAnswerProvider = StateProvider<bool>((ref) {
  ref.watch(currentQuestionCardProvider); // Reset when card changes
  return false;
});

/// Provider for current question card
final currentQuestionCardProvider = Provider<QuestionCard>((ref) {
  final cards = ref.watch(questionCardsProvider);
  final index = ref.watch(currentProgressProvider);
  
  if (cards.isEmpty) {
    // Return a placeholder card if no cards are available
    return QuestionCard(
      KanjiWord(word: "sample"),
      QuestionCardType.allDone,
      [KanjiField.all],
    );
  }
  
  if (index >= cards.length) {
    // Return completion card when all cards are done
    return QuestionCard(
      KanjiWord(word: "sample"),
      QuestionCardType.allDone,
      [KanjiField.all],
    );
  }
  
  return cards[index];
});

/// Provider for current kanji field being asked
final currentKanjiFieldProvider = Provider<KanjiField>((ref) {
  final currentCard = ref.watch(currentQuestionCardProvider);
  final currentFieldProgress = ref.watch(currentFieldProgressProvider);
  
  if (currentFieldProgress < currentCard.kanjiFieldAskingFor.length) {
    return currentCard.kanjiFieldAskingFor[currentFieldProgress];
  }
  
  return KanjiField.none;
});

/// Provider for all choices for current question
final allChoicesProvider = Provider<List>((ref) {
  final currentKanjiField = ref.watch(currentKanjiFieldProvider);
  final currentKanjiWords = ref.watch(currentLessonKanjiWordsProvider);
  final currentKanjiWord = ref.watch(currentQuestionCardProvider).kanjiWord;
  final currentAnswerList = ref.watch(currentKanjikataQueue);
  
  switch (currentKanjiField) {
    case KanjiField.kanjikata:
      return List.generate(9, (index) {
        if (index < currentAnswerList.length) {
          return MapEntry(index, String.fromCharCode(currentAnswerList[index].value));
        } else {
          return MapEntry(index, "错");
        }
      })..shuffle();
    case KanjiField.hiragana:
      return currentKanjiWords
          .where((element) => element.word != currentKanjiWord.word)
          .take(3)
          .map((e) => e.hiragana)
          .toList()
        ..add(currentKanjiWord.hiragana)
        ..shuffle();
    case KanjiField.meaning:
      return currentKanjiWords
          .where((element) => element.word != currentKanjiWord.word)
          .take(3)
          .map((e) => e.meanings.toString())
          .toList()
        ..add(currentKanjiWord.meanings.toString())
        ..shuffle();
    default:
      return [];
  }
});

/// Provider for showing subtitle
final showSubtitleProvider = Provider<bool>((ref) {
  final currentFieldProgress = ref.watch(currentFieldProgressProvider);
  return currentFieldProgress > 0;
});

/// Queue of kanji positions/charCodes to answer for Kanji-Kata selection
final currentKanjikataQueue = Provider<List<MapEntry<int, int>>>((ref) {
  final currentKanjiWord = ref.watch(currentQuestionCardProvider).kanjiWord;
  final codeUnits = currentKanjiWord.word.codeUnits;
  final List<MapEntry<int, int>> queue = [];
  for (int i = 0; i < codeUnits.length; i++) {
    queue.add(MapEntry(i, codeUnits[i]));
  }
  return queue
      .where((value) => value.value < 0x3041 || value.value > 0x309F) // 非平假名
      .toList();
});
