import 'package:flutter/material.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/model/lesson_pre.dart';
import 'package:kanji_remake/theme.dart';

class LessonEntry extends StatelessWidget {
  const LessonEntry({
    Key? key,
    required this.lessonPre,
  }) : super(key: key);
  final LessonPre lessonPre;

  @override
  Widget build(BuildContext context) {
    final S _appLocalizations = S.of(context);

    final ifEnable = lessonPre.state != LessonState.notReady;
    final ifShowLable = lessonPre.state != LessonState.notReady;

    late final lableColor;
    late final labelText;
    switch (lessonPre.state) {
      case LessonState.ready:
        labelText = _appLocalizations.ready_to_learn;
        lableColor = kReadyLableColor;
        break;
      case LessonState.needReview:
        labelText = _appLocalizations.need_review;
        lableColor = kReviewLableColor;
        break;
      case LessonState.learned:
        labelText = _appLocalizations.learned;
        lableColor = Colors.grey;
        break;
      default:
        labelText = '';
    }
    final iconText =
        lessonPre.kanjiList.first.kanjikata.toString().characters.first;
    final title = 'data';
    final kanjiPre = lessonPre.kanjiList
        .map((e) => e.kanjikata)
        .toString()
        .substring(1)
        .replaceAll(')', '');

    return IgnorePointer(
      ignoring: !ifEnable,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kBigPaddding,
          vertical: kSmallPaddding,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ifEnable ? Theme.of(context).primaryColor : Colors.grey,
              ),
              child: Center(
                child: Text(
                  iconText,
                  style: whiteBigIconText,
                ),
              ),
            ),
            const SizedBox(
              width: kSmallPaddding,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: whiteTitleText,
                  ),
                  Text(
                    kanjiPre,
                    maxLines: 2,
                    style: whiteBody1Text,
                  ),
                  Visibility(
                    visible: ifShowLable,
                    child: Text(labelText,
                        style: whiteLableText.apply(
                          color: lableColor,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
