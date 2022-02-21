import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/lesson_pre.dart';

final lessonsListProvider = StateProvider<List<LessonPre>>(
  (ref) {
    return [];
  },
);

final lessonNeedReview = Provider<List<LessonPre>>(
  (ref) {
    final lessonsList = ref.watch(lessonsListProvider);
    return lessonsList
        .where((element) => element.state == LessonState.needReview)
        .toList();
  },
);
