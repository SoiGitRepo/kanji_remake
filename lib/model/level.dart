import 'package:flutter/material.dart';
import 'package:kanji_remake/colors.dart';

class Level {
  final String title;
  final Color color;
  final int level;

  Level(this.title, this.color, this.level);

  static const List<String> LEVEL = ['N1', 'N2', 'N3', 'N4', 'N5'];

  static List<Level> fetchAll() {
    List<Level> result = [];
    for (var i = 0; i < 5; i++) {
      result.add(Level(LEVEL[i], LEVEL_COLOURS[i], i + 1));
    }
    return result;
  }
}
