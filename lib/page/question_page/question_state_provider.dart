import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/kanji_word.dart';
import 'package:kanji_remake/model/kanji_word_1.dart';
import 'package:kanji_remake/model/question_card.dart';
import 'package:kanji_remake/page/lesson_page/lesson_provider.dart';
import 'package:kanji_remake/page/question_page/card_kanji_choice.dart';

final currentLessonKanjiWordsProvider = StateProvider<List<KanjiWord>>((ref) {
  final lessonList = ref.watch(lessonsListProvider);
  return lessonList.state.first.wordList;
});

final currentQuestionOrderProvider =
    StateNotifierProvider<ListCardOrder, List<QuestionCard>>((ref) {
  final kanjiWords = ref.watch(currentLessonKanjiWordsProvider).state;
  final questionCardType;
  if (kanjiWords.length <= 4) {
    questionCardType = questionCardTypeSet;
  } else {
    questionCardType = questionCardTypeSet.skip(1);
  }
  final cardOrder = ListCardOrder();
  int j = 0;
  for (; j < kanjiWords.length - 1; j += 2) {
    for (int i = 0; i < questionCardType.length; i++) {
      cardOrder.add(QuestionCard(
        kanjiWords[j],
        questionCardType[i],
        cardTypeToFieldMap[questionCardType[i]] ?? [KanjiField.all],
      ));
      cardOrder.add(QuestionCard(
        kanjiWords[j + 1],
        questionCardType[i],
        cardTypeToFieldMap[questionCardType[i]] ?? [KanjiField.all],
      ));
    }
  }
  if (kanjiWords.length > 4) cardOrder.shuffle();
  return cardOrder;
});

final currentProgressProvider = StateProvider<int>((ref) {
  ref.watch(currentLessonKanjiWordsProvider);
  return 0;
});

final currentFieldProgressProvider = StateProvider<int>((ref) {
  ref.watch(currentProgressProvider);
  return 0;
});

final ifTokeWrongProvider = StateProvider<bool>((ref) {
  ref.watch(currentQuestionCardProvider);
  return false;
});

final currentQuestionCardProvider = Provider<QuestionCard>((ref) {
  final order = ref.watch(currentQuestionOrderProvider);
  final index = ref.watch(currentProgressProvider);
  assert(order.length > 0);
  if (index.state >= order.length)
    return QuestionCard(
      KanjiWord(word: "sample"),
      QuestionCardType.allDone,
      cardTypeToFieldMap[QuestionCardType.allDone] ?? [KanjiField.all],
    );
  else
    return order[index.state];
});

final currentKanjiFieldAsking = Provider<KanjiField>((ref) {
  final currentCardFields =
      ref.watch(currentQuestionCardProvider).kanjiFieldAskingFor;
  final currentFieldProgress = ref.watch(currentFieldProgressProvider);
  if (currentFieldProgress.state < currentCardFields.length) {
    return currentCardFields[currentFieldProgress.state];
  }
  return KanjiField.none;
});

final allChoicesProvider = Provider<List>((ref) {
  final currentKanjiField = ref.watch(currentKanjiFieldAsking);
  final currentKanjiWords = ref.watch(currentLessonKanjiWordsProvider).state;
  final currentKanjiWord = ref.watch(currentQuestionCardProvider).kanjiWord;
  final currentAnswerList = ref.watch(currentKanjikataQueue);

  switch (currentKanjiField) {
    case KanjiField.kanjikata:
      return List.generate(9, (index) {
        if (index < currentAnswerList.length) {
          return MapEntry(
              index, String.fromCharCode(currentAnswerList[index].value));
        } else
          return MapEntry(index, "错");
      })
        ..shuffle();
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
final showSubTitle = Provider<bool>((ref) {
  final currentFieldProgress = ref.watch(currentFieldProgressProvider);
  if (currentFieldProgress.state == 0) {
    return false;
  }
  return true;
});
