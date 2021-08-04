//跨平台屏幕宽度临界点
import 'package:kanji_remake/generated/l10n.dart';

const kTabletBreakPoint = 768.0;
const kDesktopBreakPoint = 1440.0;

const kSideMenuWidth = 300.0;
const kNavigationRailWidth = 72.0;

const kNormalPaddding = 16.0;
const kSmallPaddding = 8.0;
const kBigPaddding = 20.0;
const kDefaultInsetPadding = 40;

const kSmallRadius = 8.0;
const kNormalRadius = 12.0;
const kBigRadius = 14.0;

const kSmallerText = 12.0;
const kSmallText = 14.0;
const kNormalText = 18.0;
const kBigText = 24.0;
const kBiggerText = 30.0;

const kSmallButtonHeight = 35.0;
const kNormalButtonHeight = 50.0;
const kBigButtonHeight = 65.0;

const kDuration = Duration(milliseconds: 400);
const kFastDuration = Duration(milliseconds: 200);
const kSlowDuration = Duration(milliseconds: 600);

const kHiraganaStartUnicode = 0x3041;
const kHiraganaEndUnicode = 0x309F;

const kKatakanaStartUnicode = 0x30A1;
const kKatakanaEndUnicode = 0x30FF;

final kLabelHeightRTSH = 0.03;
final kTitleHeightRTSH = 0.07;
final kSubtitleHeightRTSH = 0.06;
final kChoiceCardHeightRTSH = 0.1;

enum SpeechSpeed { Off, Slow, Medium, Fast }
enum ReviewQuestionOrder { EnglisnFirst, JapaneseFirst, Random }

const reviewQuestionOrderOptions = [
  ReviewQuestionOrder.EnglisnFirst,
  ReviewQuestionOrder.JapaneseFirst,
  ReviewQuestionOrder.Random,
];

const speechSpeedOptions = [
  SpeechSpeed.Off,
  SpeechSpeed.Slow,
  SpeechSpeed.Medium,
  SpeechSpeed.Fast
];

extension SpeechSpeedMapper on SpeechSpeed {
  String toLocaleString(S locale) {
    switch (this) {
      case SpeechSpeed.Off:
        return locale.off;
      case SpeechSpeed.Slow:
        return locale.slow;
      case SpeechSpeed.Medium:
        return locale.medium;
      case SpeechSpeed.Fast:
        return locale.fast;
      default:
        return "";
    }
  }
}

extension ReviewQuestionOrderMapper on ReviewQuestionOrder {
  String toLocaleString(S locale) {
    switch (this) {
      case ReviewQuestionOrder.EnglisnFirst:
        return locale.eng_first;
      case ReviewQuestionOrder.JapaneseFirst:
        return locale.jp_first;
      case ReviewQuestionOrder.Random:
        return locale.random;
      default:
        return "";
    }
  }
}
