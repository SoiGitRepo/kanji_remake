import 'package:kanji_remake/model/kanji.dart';
import 'package:kanji_remake/model/kanji_word_1.dart';
import 'package:kanji_remake/model/lesson_pre.dart';
import 'package:kanji_remake/objectbox.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lesso_repo.g.dart';

@Riverpod(keepAlive: true)
LessonRepository lessonRepo(LessonRepoRef ref) => LessonRepository._instance;

class LessonRepository {
  static final LessonRepository _instance = LessonRepository._internal();
  Store? _store;
  bool _initialized = false;

  LessonRepository._internal();

  Future<void> _init() async {
    if (!_initialized) {
      _store = await openStore();
      _initialized = true;
    }
  }

  Future<List<LessonPre>> getAllLessonWithJlpt(int jlpt) async {
    await _init();
    final wordsList = await getKanjiWordOrderByKanjiWithJlpt(jlpt);
    return List.generate(
      (wordsList.length / 4).ceil(),
      (index) => LessonPre(index, wordsList.skip(index * 4).take(4).toList()),
    );
  }

  Future<List<Kanji>> getAllKanjiWithJlpt(int jlpt) async {
    await _init();
    return _store!.box<Kanji>().query(Kanji_.jlpt.equals(jlpt)).build().find();
  }

  Future<List<KanjiWord>> getKanjiWordOrderByKanjiWithJlpt(int jlpt) async {
    await _init();
    final kanji = await getAllKanjiWithJlpt(jlpt);
    final List<KanjiWord> wordsList = [];
    for (final e in kanji) {
      wordsList.addAll(e.relatedWords);
    }
    return wordsList;
  }
}
