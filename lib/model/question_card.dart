import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/kanji_word.dart';

enum QuestionCardType { overview, chooseKanji, kanjiOnly, meaningOnly, allDone }
const questionCardTypeSet = [
  QuestionCardType.overview,
  QuestionCardType.chooseKanji,
  QuestionCardType.kanjiOnly,
  QuestionCardType.meaningOnly,
];

class QuestionCard {
  final KanjiWord kanjiWord;
  final QuestionCardType questionCardType;
  final List<KanjiField> kanjiFieldAskingFor;

  const QuestionCard(
    this.kanjiWord,
    this.questionCardType,
    this.kanjiFieldAskingFor,
  );
}

class ListCardOrder extends StateNotifier<List<QuestionCard>> {
  ListCardOrder() : super([]);

  add(QuestionCard learningCard) {
    state = [...state, learningCard];
  }

  remove(QuestionCard learningCard) {
    state = state.where((element) => element != learningCard).toList();
  }

  removeAt(index) {
    state = state..removeAt(index);
  }

  shuffle() {
    print('shuffled');
    state = state..shuffle();
  }
}
