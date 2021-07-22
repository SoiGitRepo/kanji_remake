import 'dart:convert';
import 'package:kanji_remake/model/question_card.dart';

enum KanjiField {
  all,
  englishMeaning,
  hiragana,
  kanjikata,
  none,
}
const cardTypeToFieldMap = {
  QuestionCardType.overview: [
    KanjiField.all,
  ],
  QuestionCardType.kanjiOnly: [
    KanjiField.hiragana,
    KanjiField.englishMeaning,
  ],
  QuestionCardType.meaningOnly: [
    KanjiField.kanjikata,
    KanjiField.hiragana,
  ],
  QuestionCardType.chooseKanji: [
    KanjiField.kanjikata,
  ],
  QuestionCardType.allDone: [
    KanjiField.none,
  ],
};

class KanjiWord {
  final int? _wordID;
  final int? _lessonID;
  final String? _enMeaning;
  final String? _hiragana;
  final String? _kanjikata;
  // final bool? _learned;

  int? get wordID => _wordID;
  int? get lessonID => _lessonID;
  String? get enMeaning => _enMeaning;
  String? get hiragana => _hiragana;
  String? get kanjikata => _kanjikata;
  // bool? get learned => _learned;

  KanjiWord(
    // this._learned,
    this._wordID,
    this._lessonID,
    this._enMeaning,
    this._hiragana,
    this._kanjikata,
  );

  KanjiWord copyWith(
    int? _wordID,
    int? _lessonID,
    String? _enMeaning,
    String? _hirakata,
    String? _kanjikata,
  ) {
    return KanjiWord(
      _wordID ?? this._wordID,
      _lessonID ?? this._lessonID,
      _enMeaning ?? this._enMeaning,
      _hirakata ?? this._hiragana,
      _kanjikata ?? this._kanjikata,
    );
  }

  factory KanjiWord.sample() {
    return KanjiWord(0, 0, '', '', '');
  }

  Map<String, dynamic> toMap() {
    return {
      '_wordID': _wordID,
      '_lessonID': _lessonID,
      '_enMeaning': _enMeaning,
      '_hirakata': _hiragana,
      '_kanjikata': _kanjikata,
    };
  }

  factory KanjiWord.fromMap(Map<String, dynamic> map) {
    return KanjiWord(
      map['_wordID'],
      map['_lessonID'],
      map['_enMeaning'],
      map['_hirakata'],
      map['_kanjikata'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KanjiWord.fromJson(String source) =>
      KanjiWord.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KanjiWord(_wordID: $_wordID, _lessonID: $_lessonID, _enMeaning: $_enMeaning, _hirakata: $_hiragana, _kanjikata: $_kanjikata)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KanjiWord &&
        other._wordID == _wordID &&
        other._lessonID == _lessonID &&
        other._enMeaning == _enMeaning &&
        other._hiragana == _hiragana &&
        other._kanjikata == _kanjikata;
  }

  @override
  int get hashCode {
    return _wordID.hashCode ^
        _lessonID.hashCode ^
        _enMeaning.hashCode ^
        _hiragana.hashCode ^
        _kanjikata.hashCode;
  }
}
