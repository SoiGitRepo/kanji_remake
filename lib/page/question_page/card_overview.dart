import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/page/question_page/page_question.dart';
import 'package:kanji_remake/providers/question_providers.dart';
import 'package:kanji_remake/theme.dart';
import 'package:kanji_remake/widgets/glassy/glassy.dart';

class KanjiOverviewCard extends QuestionCardBlock {
  KanjiOverviewCard(void Function() onPass, void Function() onTokeWrong)
      : super(onPass, onTokeWrong);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S _appLocalizations = S.of(context);
    final Size size = MediaQuery.of(context).size;
    final labelHeight = size.height * kLabelHeightRTSH;
    final titleHeight = size.height * kTitleHeightRTSH;
    final subtitleHeight = size.height * kSubtitleHeightRTSH;
    final currentKanjiWord = ref.watch(currentQuestionCardProvider).kanjiWord;
    final cs = Theme.of(context).colorScheme;

    return DefaultTextStyle(
      style: TextStyle(color: cs.onSurface, fontSize: titleHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: labelHeight,
              child: FittedBox(
                child: Text(
                  _appLocalizations.memorize_this_word,
                  style: TextStyle(color: cs.onSurfaceVariant),
                ),
              ),
            ),
          ),
          FittedBox(
            child: Text(
              currentKanjiWord.word,
            ),
          ),
          SizedBox(
            height: subtitleHeight,
            child: FittedBox(
              child: Text(
                currentKanjiWord.hiragana ?? 'no Kanjikata',
              ),
            ),
          ),
          SizedBox(
            height: subtitleHeight,
            child: FittedBox(
              child: Text(
                currentKanjiWord.meanings?.take(2).toString() ?? 'no Kanjikata',
                style: Theme.of(context).textTheme.displaySmall!.apply(color: cs.onSurface),
              ),
            ),
          ),
          Column(
            children: [
              GestureDetector(
                // padding: EdgeInsets.zero,
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cs.primaryContainer,
                  ),
                  child: Icon(
                    Icons.play_circle_fill_rounded,
                    size: 50.0,
                    color: cs.primary,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(kNormalPaddding),
                child: ElevatedButton(
                  onPressed: super.onPass,
                  child: Text(
                    'OK',
                  ),
                  style: AppButtonStyles.primary(context),
                ).glassy(borderRadius: kSmallRadius),
              )
            ],
          ),
        ],
      ),
    );
  }
}
