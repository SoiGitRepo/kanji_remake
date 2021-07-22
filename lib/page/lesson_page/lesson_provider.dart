import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/lesson_pre.dart';
import 'package:kanji_remake/repo/lesso_repo.dart';

final lessonsListProvider = StateNotifierProvider<LessonList, List<LessonPre>>(
  (ref) {
    final lessonRepository = ref.watch(lessonRepoProvider);
    return lessonRepository.fetchLessons();
  },
);

final lessonNeedReview = StateProvider<List<LessonPre>>(
  (ref) {
    final lessonsList = ref.watch(lessonsListProvider);
    return lessonsList
        .where((element) => element.state == LessonState.needReview)
        .toList();
  },
);
