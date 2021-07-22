import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/model/question_card.dart';
import 'package:kanji_remake/page/question_page/card_kanji_choice.dart';
import 'package:kanji_remake/page/question_page/card_overview.dart';
import 'package:kanji_remake/page/question_page/card_four_choice.dart';
import 'package:kanji_remake/page/question_page/question_state_provider.dart';
import 'package:kanji_remake/theme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuestionPage extends HookWidget {
  const QuestionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentCard = useProvider(currentLearningCardProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(context),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kNormalPaddding),
                    child: Builder(builder: (context) {
                      switch (currentCard.questionCardType) {
                        case QuestionCardType.overview:
                          return KanjiOverviewCard();
                        case QuestionCardType.chooseKanji:
                          return ChooseKanjiCard();
                        case QuestionCardType.kanjiOnly:
                          return ChooseFromKanjiKataCard();
                        case QuestionCardType.meaningOnly:
                          return ChooseFromKanjiKataCard();
                        default:
                          return Container(
                              child: Center(
                                  child: FittedBox(
                            child: Text(
                              "All Done",
                              style: whiteBigIconText,
                            ),
                          )));
                      }
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }

  void popThisPageOut(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  Widget header(context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      IconButton(
        onPressed: () {
          popThisPageOut(context);
        },
        icon: const Icon(Icons.close_rounded),
      ),
      const SizedBox(
        width: kSmallPaddding,
      ),
      Consumer(builder: (context, watch, child) {
        final currentIndex = watch(currentLearningOrderIndexProvider).state;
        final currentOrder = watch(currentLearningOrderProvider);
        final percentage = currentIndex / currentOrder.length;
        return Expanded(
          child: LinearPercentIndicator(
            backgroundColor: kButtonBgColor2,
            lineHeight: 20.0,
            animationDuration: 2500,
            percent: percentage,
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: kProgressIndicatorColor,
          ),
        );
      }),
      const SizedBox(
        width: kSmallPaddding,
      ),
      IconButton(
        onPressed: () {
          popThisPageOut(context);
        },
        icon: const Icon(Icons.settings_rounded),
      ),
    ]);
  }
}
