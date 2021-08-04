import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kanji_remake/model/kanji.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class KanjiWord {
  int id;
  String word;
  String? hiragana;
  List<String>? meanings;
  DateTime? lastTimePass;
  int jlpt;

  @Backlink()
  final relatedKanjis = ToMany<Kanji>();

  KanjiWord({
    this.id = 0,
    required this.word,
    this.hiragana,
    this.meanings,
    this.lastTimePass,
    this.jlpt = 6,
  });

  KanjiWord copyWith({
    int? id,
    String? word,
    String? hiragana,
    List<String>? meanings,
    DateTime? lastTimePass,
    int? jlpt,
    int? group,
    int? lesson,
  }) {
    return KanjiWord(
      id: id ?? this.id,
      word: word ?? this.word,
      hiragana: hiragana ?? this.hiragana,
      meanings: meanings ?? this.meanings,
      lastTimePass: lastTimePass ?? this.lastTimePass,
      jlpt: jlpt ?? this.jlpt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'hiragana': hiragana,
      'meanings': meanings,
      'lastTimePass': lastTimePass?.millisecondsSinceEpoch,
      'jlpt': jlpt,
    };
  }

  factory KanjiWord.fromMap(Map<String, dynamic> map) {
    return KanjiWord(
      id: map['id'],
      word: map['word'],
      hiragana: map['hiragana'],
      meanings: List<String>.from(map['meanings']),
      lastTimePass: DateTime.fromMillisecondsSinceEpoch(map['lastTimePass']),
      jlpt: map['jlpt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KanjiWord.fromJson(String source) =>
      KanjiWord.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KanjiWord(id: $id, word: $word, hiragana: $hiragana, meanings: $meanings, lastTimePass: $lastTimePass, jlpt: $jlpt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KanjiWord &&
        other.id == id &&
        other.word == word &&
        other.hiragana == hiragana &&
        listEquals(other.meanings, meanings) &&
        other.lastTimePass == lastTimePass &&
        other.jlpt == jlpt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        word.hashCode ^
        hiragana.hashCode ^
        meanings.hashCode ^
        lastTimePass.hashCode ^
        jlpt.hashCode;
  }
}
