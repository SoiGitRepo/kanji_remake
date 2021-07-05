import 'dart:convert';

class KanjiWord {
  final int? wordID;
  final int? lessonID;
  final String? enMeaning;
  final String? hirakata;
  final String? kanjikata;

  KanjiWord(
    this.wordID,
    this.lessonID,
    this.enMeaning,
    this.hirakata,
    this.kanjikata,
  );

  KanjiWord copyWith({
    int? wordID,
    int? lessonID,
    String? enMeaning,
    String? hirakata,
    String? kanjikata,
  }) {
    return KanjiWord(
      wordID ?? this.wordID,
      lessonID ?? this.lessonID,
      enMeaning ?? this.enMeaning,
      hirakata ?? this.hirakata,
      kanjikata ?? this.kanjikata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'wordID': wordID,
      'lessonID': lessonID,
      'enMeaning': enMeaning,
      'hirakata': hirakata,
      'kanjikata': kanjikata,
    };
  }

  factory KanjiWord.fromMap(Map<String, dynamic> map) {
    return KanjiWord(
      map['wordID'],
      map['lessonID'],
      map['enMeaning'],
      map['hirakata'],
      map['kanjikata'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KanjiWord.fromJson(String source) =>
      KanjiWord.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KanjiWord(wordID: $wordID, lessonID: $lessonID, enMeaning: $enMeaning, hirakata: $hirakata, kanjikata: $kanjikata)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KanjiWord &&
        other.wordID == wordID &&
        other.lessonID == lessonID &&
        other.enMeaning == enMeaning &&
        other.hirakata == hirakata &&
        other.kanjikata == kanjikata;
  }

  @override
  int get hashCode {
    return wordID.hashCode ^
        lessonID.hashCode ^
        enMeaning.hashCode ^
        hirakata.hashCode ^
        kanjikata.hashCode;
  }
}
