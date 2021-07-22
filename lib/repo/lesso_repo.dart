import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/kanji_word.dart';
import 'package:kanji_remake/model/lesson_pre.dart';

final lessonRepoProvider = Provider((ref) => LessonRepository());

class LessonRepository {
  // TODO: make it a real repo
  LessonList fetchLessons() {
    return LessonList([
      LessonPre(
        00001,
        [
          KanjiWord(10001, 00001, 'enMean', 'ひらかな', 'か漢観艦漢た字'),
          KanjiWord(10002, 00001, 'enMeani', 'ひら', '漢字'),
          KanjiWord(10003, 00001, 'enMeanin', 'ひらか', '漢字か'),
          KanjiWord(10004, 00001, 'enMeaning', 'ひ', '漢'),
        ],
      ),
      LessonPre(
        00002,
        [
          KanjiWord(10001, 00002, 'enMean', 'ひ', '漢'),
          KanjiWord(10002, 00002, 'enMeani', 'ひら', '漢字'),
          KanjiWord(10003, 00002, 'enMeanin', 'ひらか', '漢字か'),
          KanjiWord(10004, 00002, 'enMeaning', 'ひらかな', '漢字かた'),
        ],
      ),
      LessonPre(
        00003,
        [
          KanjiWord(10001, 00003, 'enMean', 'ひ', '漢'),
          KanjiWord(10002, 00003, 'enMeani', 'ひら', '漢字'),
          KanjiWord(10003, 00003, 'enMeanin', 'ひらか', '漢字か'),
          KanjiWord(10004, 00003, 'enMeaning', 'ひらかな', '漢字かた'),
        ],
      ),
      LessonPre(
        00004,
        [
          KanjiWord(10001, 00004, 'enMean', 'ひ', '漢'),
          KanjiWord(10002, 00004, 'enMeani', 'ひら', '漢字'),
          KanjiWord(10003, 00004, 'enMeanin', 'ひらか', '漢字か'),
          KanjiWord(10004, 00004, 'enMeaning', 'ひらかな', '漢字かた'),
        ],
      ),
      LessonPre(
        00005,
        [
          KanjiWord(10001, 00005, 'enMean', 'ひ', '漢'),
          KanjiWord(10002, 00005, 'enMeani', 'ひら', '漢字'),
          KanjiWord(10003, 00005, 'enMeanin', 'ひらか', '漢字か'),
          KanjiWord(10004, 00005, 'enMeaning', 'ひらかな', '漢字かた'),
        ],
      )
    ]);
  }
}
