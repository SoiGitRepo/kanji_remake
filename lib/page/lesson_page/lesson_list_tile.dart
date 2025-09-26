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
    final S _s = S.of(context);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final appColors = theme.extension<AppColors>();

    final ifEnable = lessonPre.state != LessonState.notReady;
    final ifShowLable = ifEnable;

    late final lableColor;
    late final labelText;
    switch (lessonPre.state) {
      case LessonState.ready:
        labelText = _s.ready_to_learn;
        lableColor = appColors?.success ?? cs.tertiary;
        break;
      case LessonState.learned:
        labelText = _s.learned;
        lableColor = cs.outlineVariant;
        break;
      case LessonState.needReview:
        labelText = _s.need_review;
        lableColor = appColors?.warning ?? Colors.orange;
        break;
      default:
        lableColor = cs.outlineVariant;
        labelText = '';
    }
    final iconText = lessonPre.wordList.first.word.toString().characters.first;
    final title = '${_s.lesson} ${lessonPre.lessonID + 1}';
    final kanjiPre = lessonPre.wordList
        .map((e) => e.word)
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
                color: ifEnable
                    ? (appColors?.success ?? cs.tertiary)
                    : cs.surfaceVariant,
              ),
              child: Center(
                child: Text(
                  iconText,
                  // 根据主题切换前景色，浅色/深色均可读
                  style: ifEnable
                      ? AppTextStyles.bigIconOnTertiary(context)
                      : AppTextStyles.body1(context),
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
                  Text(title, style: AppTextStyles.title(context)),
                  Text(kanjiPre, maxLines: 2, style: AppTextStyles.body1(context)),
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
