import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/kanji.dart';
import 'package:kanji_remake/model/kanji_word_1.dart';
import 'package:kanji_remake/model/lesson_pre.dart';
import 'package:kanji_remake/objectbox.g.dart';

final lessonRepoProvider = Provider((ref) => LessonRepository());

class LessonRepository {
  Store? _store;

  init() async {
    if (_store == null) _store = await openStore();
  }

  factory LessonRepository() {
    return LessonRepository._internal();
  }

  LessonRepository._internal();

  Future<List<LessonPre>> getAllLessonWithJlpt(int jlpt) async {
    await init();
    final List<KanjiWord> wordsList =
        await getKanjiWordOrderByKanjiWithJlpt(jlpt);
    return List.generate(
        (wordsList.length / 4).ceilToDouble().toInt(),
        (index) =>
            LessonPre(index, wordsList.skip((index + 1) * 4).take(4).toList()));
  }

  Future<List<Kanji>> getAllKanjiWithJlpt(int jlpt) async {
    await init();
    return _store!.box<Kanji>().query(Kanji_.jlpt.equals(jlpt)).build().find();
  }

  Future<List<KanjiWord>> getKanjiWordOrderByKanjiWithJlpt(int jlpt) async {
    await init();
    final kanji = await getAllKanjiWithJlpt(jlpt);
    final List<KanjiWord> wordsList = [];
    kanji.forEach(((e) => wordsList.addAll(e.relatedWords)));
    return wordsList;
  }
}
