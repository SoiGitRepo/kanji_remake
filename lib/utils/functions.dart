import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/constant.dart';

bool isNotHiragana(int unitcode) {
  return unitcode <= kHiraganaStartUnicode || unitcode >= kHiraganaEndUnicode;
}

final utf8CodecProvider = Provider((ref) => Utf8Codec());
