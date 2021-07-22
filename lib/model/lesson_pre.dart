import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanji_remake/model/kanji_word.dart';

enum LessonState {
  notReady,
  ready,
  learned,
  needReview,
}

class LessonPre {
  final int lessonID;
  final List<KanjiWord> kanjiList;
  final LessonState state;

  LessonPre(this.lessonID, this.kanjiList, [this.state = LessonState.learned]);
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

  void toggle(String id, LessonState lessonState) {
    state = [
      for (final lesson in state)
        if (lesson.lessonID == id)
          LessonPre(
            lesson.lessonID,
            lesson.kanjiList,
            lessonState,
          )
        else
          lesson,
    ];
  }
}
