import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/kanji_word.dart';
import 'package:kanji_remake/model/question_card.dart';
import 'package:kanji_remake/page/lesson_page/lesson_provider.dart';

final currentLessonKanjiWordsProvider = StateProvider<List<KanjiWord>>((ref) {
  final lessonList = ref.watch(lessonsListProvider);
  return lessonList.first.kanjiList;
});

final currentLearningOrderProvider =
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

final currentLearningOrderIndexProvider = StateProvider<int>((ref) {
  final kanjiWords = ref.watch(currentLessonKanjiWordsProvider);
  return 0;
});
final currentCardTokeWrongProvider = StateProvider<bool>((ref) {
  final currentQuestion = ref.watch(currentLearningCardProvider);
  return false;
});

final currentLearningCardProvider = Provider<QuestionCard>((ref) {
  final order = ref.watch(currentLearningOrderProvider);
  final index = ref.watch(currentLearningOrderIndexProvider);
  assert(order.length > 0);
  if (index.state >= order.length)
    return QuestionCard(
      KanjiWord.sample(),
      QuestionCardType.allDone,
      cardTypeToFieldMap[QuestionCardType.allDone] ?? [KanjiField.all],
    );
  else
    return order[index.state];
});
