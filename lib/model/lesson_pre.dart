import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'kanji_word_1.dart';

enum LessonState {
  notReady,
  ready,
  learned,
  needReview,
}

class LessonPre {
  final int lessonID;
  final List<KanjiWord> wordList;
  late final LessonState state;

  LessonPre(this.lessonID, this.wordList) {
    for (var i = 0; i < wordList.length; i++) {
      if (wordList[i].lastTimePass == null) {
        if (lessonID == 0 || i != 0) {
          state = LessonState.ready;
          return;
        } else {
          state = LessonState.notReady;
        }
        return;
      }
    }
    state = LessonState.learned;
  }
}

class LessonList extends StateNotifier<List<LessonPre>> {
  LessonList([List<LessonPre>? initialLessonList])
      : super(initialLessonList ?? []);

  void add(LessonPre lessonPre) {
    state = [...state, lessonPre];
  }

  void remove(LessonPre target) {
    state = state.where((todo) => todo.lessonID != target.lessonID).toList();
  }

  void update(String id, LessonPre taget) {
    state = [
      for (final lesson in state)
        if (lesson.lessonID == id) taget else lesson,
    ];
  }
}
