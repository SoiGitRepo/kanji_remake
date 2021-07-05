import 'dart:convert';

import 'package:flutter/foundation.dart';

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
  final LessonState _state = LessonState.notReady;

  LessonPre(
    this.lessonID,
    this.kanjiList,
  );

  LessonPre copyWith({
    int? lessonID,
    List<KanjiWord>? kanjiList,
  }) {
    return LessonPre(
      lessonID ?? this.lessonID,
      kanjiList ?? this.kanjiList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lessonID': lessonID,
      'kanjiList': kanjiList.map((x) => x.toMap()).toList(),
    };
  }

  factory LessonPre.fromMap(Map<String, dynamic> map) {
    return LessonPre(
      map['lessonID'],
      List<KanjiWord>.from(map['kanjiList']?.map((x) => KanjiWord.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory LessonPre.fromJson(String source) =>
      LessonPre.fromMap(json.decode(source));

  @override
  String toString() => 'LessonPre(lessonID: $lessonID, kanjiList: $kanjiList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LessonPre &&
        other.lessonID == lessonID &&
        listEquals(other.kanjiList, kanjiList);
  }

  @override
  int get hashCode => lessonID.hashCode ^ kanjiList.hashCode;

  static List<LessonPre> fetchAll() {
    return [
      LessonPre(
        00001,
        [
          KanjiWord(10001, 00001, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00001, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00001, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00001, 'enMeaning', 'ひらかた', '漢字かた'),
        ],
      ),
      LessonPre(
        00002,
        [
          KanjiWord(10001, 00002, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00002, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00002, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00002, 'enMeaning', 'ひらかた', '漢字かた'),
        ],
      ),
      LessonPre(
        00003,
        [
          KanjiWord(10001, 00003, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00003, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00003, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00003, 'enMeaning', 'ひらかた', '漢字かた'),
        ],
      ),
      LessonPre(
        00004,
        [
          KanjiWord(10001, 00004, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00004, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00004, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00004, 'enMeaning', 'ひらかた', '漢字かた'),
        ],
      ),
      LessonPre(
        00005,
        [
          KanjiWord(10001, 00005, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00005, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00005, 'enMeaning', 'ひらかた', '漢字かた'),
          KanjiWord(10001, 00005, 'enMeaning', 'ひらかた', '漢字かた'),
        ],
      )
    ];
  }
}
