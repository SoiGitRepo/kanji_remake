import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/lesson_pre.dart';
import 'package:kanji_remake/providers/app_providers.dart';
import 'package:kanji_remake/repo/lesson_repository.dart';

/// State notifier for managing lessons
class LessonsNotifier extends StateNotifier<List<LessonPre>> {
  final Ref ref;
  LessonsNotifier(this.ref) : super([]);

  /// Load lessons from repository using current JLPT setting
  Future<void> loadLessons() async {
    final jlpt = ref.read(lessonJlptLevelProvider);
    final repo = ref.read(lessonRepoProvider);
    final lessons = await repo.getAllLessonWithJlpt(jlpt);
    state = lessons;
  }

  /// Add a new lesson（如需本地拼接）
  void addLesson(LessonPre lesson) => state = [...state, lesson];
}

/// Provider for lessons state notifier
final lessonsProvider = StateNotifierProvider<LessonsNotifier, List<LessonPre>>((ref) {
  final notifier = LessonsNotifier(ref);
  // 可在需要时主动触发加载：
  // unawaited(notifier.loadLessons());
  return notifier;
});

/// Provider for lessons that need review
final lessonsNeedReviewProvider = Provider<List<LessonPre>>((ref) {
  final lessons = ref.watch(lessonsProvider);
  return lessons
      .where((lesson) => lesson.state == LessonState.needReview)
      .toList();
});

/// Provider for completed lessons
final completedLessonsProvider = Provider<List<LessonPre>>((ref) {
  final lessons = ref.watch(lessonsProvider);
  return lessons
      .where((lesson) => lesson.state == LessonState.learned)
      .toList();
});

/// Provider for the current selected lesson
final selectedLessonProvider = StateProvider<LessonPre?>((ref) => null);
