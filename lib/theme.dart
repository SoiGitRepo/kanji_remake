import 'package:flutter/material.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';

//textstyle
const TextStyle whiteBigIconText =
    TextStyle(fontSize: 45.0, color: Colors.white);
const TextStyle whiteTitleText =
    TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold);
const TextStyle whiteSubTitleText =
    TextStyle(fontSize: 20.0, color: Colors.white);
const TextStyle whiteLableText =
    TextStyle(fontSize: kNormalText, color: Colors.white);
final TextStyle whiteLable2Text = TextStyle(
    fontSize: kSmallText, color: Colors.grey[850], fontWeight: FontWeight.w300);
const TextStyle whiteBody1Text =
    TextStyle(fontSize: kSmallText, color: Colors.white);
const TextStyle whiteBody2Text =
    TextStyle(fontSize: kSmallerText, color: Colors.white);
const TextStyle blueBody1Text =
    TextStyle(fontSize: kSmallText, color: kButtonBgColor2);

final ButtonStyle kNormalButtonStyle = ElevatedButton.styleFrom(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
  primary: kButtonBgColor2,
  textStyle: whiteLableText,
  minimumSize: Size.fromHeight(35),
);

final ButtonStyle kOkButtonStyle = ElevatedButton.styleFrom(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  ),
  primary: kButtonBgColor,
  textStyle: const TextStyle(
    color: Colors.white,
    fontSize: kBigText,
  ),
  minimumSize: Size.fromHeight(48),
);
