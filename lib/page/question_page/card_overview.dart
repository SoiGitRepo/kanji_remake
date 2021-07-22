import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/page/question_page/question_state_provider.dart';
import 'package:kanji_remake/theme.dart';

class KanjiOverviewCard extends HookWidget {
  const KanjiOverviewCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S _appLocalizations = S.of(context);
    final Size size = MediaQuery.of(context).size;
    final labelHeight = size.height * kLabelHeightRTSH;
    final titleHeight = size.height * kTitleHeightRTSH;
    final subtitleHeight = size.height * kSubtitleHeightRTSH;
    final currentKanjiWord = useProvider(currentLearningCardProvider).kanjiWord;
    final currentOrderIndex = useProvider(currentLearningOrderIndexProvider);

    return DefaultTextStyle(
      style: TextStyle(color: Colors.white, fontSize: titleHeight),
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
                  style: TextStyle(color: kBody2Color),
                ),
              ),
            ),
          ),
          FittedBox(
            child: Text(
              currentKanjiWord.kanjikata ?? 'no Kanjikata',
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
                currentKanjiWord.enMeaning ?? 'no Kanjikata',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .apply(color: Colors.white),
              ),
            ),
          ),
          Column(
            children: [
              IconButton(
                // padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.play_circle_fill_rounded,
                    color: Colors.blue[700],
                  ),
                ),
                iconSize: 50.0,
              ),
              Padding(
                padding: EdgeInsets.all(kNormalPaddding),
                child: ElevatedButton(
                  onPressed: () {
                    currentOrderIndex.state++;
                  },
                  child: Text(
                    'OK',
                  ),
                  style: kOkButtonStyle,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
