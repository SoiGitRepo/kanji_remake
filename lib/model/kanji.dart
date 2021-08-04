import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:objectbox/objectbox.dart';

import 'kanji_word_1.dart';

const SQL_KANJI_TABLE = "kanjis";
const SQL_KANJI_ID = "kanji_id";
const SQL_KANJI_LITERAL = "literal";
const SQL_KANJI_JAON = "ja_on";
const SQL_KANJI_UCS = "ucs";
const SQL_KANJI_JLPT = "jlpt";
const SQL_KANJI_STROKE_COUNT = "stroke_count";
const SQL_KANJI_MEANINGS = "meanings";
const SQL_KANJI_CORRECT_OF_TEN = "correct_of_ten";

@Entity()
class Kanji {
  int id;
  String literal;
  String? jaOn;
  int? ucs;
  int? jlpt;
  int? strokeCount;
  List<String>? meanings;
  int? correctOfTen;

  final relatedWords = ToMany<KanjiWord>();

  Kanji({
    this.id = 0,
    required this.literal,
    this.jaOn,
    this.ucs,
    this.jlpt,
    this.strokeCount,
    this.meanings,
    this.correctOfTen = 0,
  });

  int get kanjiId => id;

  Kanji copyWith({
    int? id,
    String? literal,
    String? jaOn,
    int? ucs,
    int? jlpt,
    int? strokeCount,
    List<String>? meanings,
    int? correctOfTen,
  }) {
    return Kanji(
      id: id ?? this.id,
      literal: literal ?? this.literal,
      jaOn: jaOn ?? this.jaOn,
      ucs: ucs ?? this.ucs,
      jlpt: jlpt ?? this.jlpt,
      strokeCount: strokeCount ?? this.strokeCount,
      meanings: meanings ?? this.meanings,
      correctOfTen: correctOfTen ?? this.correctOfTen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'literal': literal,
      'jaOn': jaOn,
      'ucs': ucs,
      'jlpt': jlpt,
      'strokeCount': strokeCount,
      'meanings': meanings,
      'correctOfTen': correctOfTen,
    };
  }

  factory Kanji.fromMap(Map<String, dynamic> map) {
    return Kanji(
      id: map['id'],
      literal: map['literal'],
      jaOn: map['jaOn'],
      ucs: map['ucs'],
      jlpt: map['jlpt'],
      strokeCount: map['strokeCount'],
      meanings: List<String>.from(map['meanings']),
      correctOfTen: map['correctOfTen'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Kanji.fromJson(String source) => Kanji.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Kanji(id: $id, literal: $literal, jaOn: $jaOn, ucs: $ucs, jlpt: $jlpt, strokeCount: $strokeCount, meanings: $meanings, correctOfTen: $correctOfTen)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Kanji &&
        other.id == id &&
        other.literal == literal &&
        other.jaOn == jaOn &&
        other.ucs == ucs &&
        other.jlpt == jlpt &&
        other.strokeCount == strokeCount &&
        listEquals(other.meanings, meanings) &&
        other.correctOfTen == correctOfTen;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        literal.hashCode ^
        jaOn.hashCode ^
        ucs.hashCode ^
        jlpt.hashCode ^
        strokeCount.hashCode ^
        meanings.hashCode ^
        correctOfTen.hashCode;
  }
}
