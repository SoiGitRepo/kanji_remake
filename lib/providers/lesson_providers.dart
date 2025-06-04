import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/lesson_pre.dart';

/// State notifier for managing lessons
class LessonsNotifier extends StateNotifier<List<LessonPre>> {
  LessonsNotifier() : super([]);

  /// Load lessons from repository
  Future<void> loadLessons() async {
    // TODO: Implement loading from repository
    // This would be replaced with actual repository call
    state = []; // Replace with actual data
  }

  /// Add a new lesson
  void addLesson(LessonPre lesson) {
    state = [...state, lesson];
  }

  /// Update a lesson
  void updateLesson(LessonPre updatedLesson) {
    state = state.map((lesson) => 
      lesson.id == updatedLesson.id ? updatedLesson : lesson
    ).toList();
  }

  /// Update lesson state
  void updateLessonState(int lessonId, LessonState newState) {
    state = state.map((lesson) => 
      lesson.id == lessonId 
        ? lesson.copyWith(state: newState) 
        : lesson
    ).toList();
  }

  /// Mark lesson as completed
  void markAsCompleted(int lessonId) {
    updateLessonState(lessonId, LessonState.completed);
  }

  /// Mark lesson as needing review
  void markAsNeedReview(int lessonId) {
    updateLessonState(lessonId, LessonState.needReview);
  }
}

/// Provider for lessons state notifier
final lessonsProvider = StateNotifierProvider<LessonsNotifier, List<LessonPre>>((ref) {
  return LessonsNotifier();
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
      .where((lesson) => lesson.state == LessonState.completed)
      .toList();
});

/// Provider for the current selected lesson
final selectedLessonProvider = StateProvider<LessonPre?>((ref) => null);
