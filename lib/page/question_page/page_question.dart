import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/model/kanji_word.dart';
import 'package:kanji_remake/model/kanji_word_1.dart';
import 'package:kanji_remake/page/question_page/card_kanji_choice.dart';
import 'package:kanji_remake/page/question_page/card_overview.dart';
import 'package:kanji_remake/page/question_page/card_four_choice.dart';
import 'package:kanji_remake/page/question_page/question_state_provider.dart';
import 'package:kanji_remake/page/setting_dialog/setting_general.dart';
import 'package:kanji_remake/repo/lesso_repo.dart';
import 'package:kanji_remake/theme.dart';
import 'package:kanji_remake/utils/objectbox_hook.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({
    Key? key,
  }) : super(key: key);

  showSettingMenuDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return SettingDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    ///用于更新kanji词语最新学习通过时间的函数
    ///
    ///接收一个[KanjiWord]参数并更新其属性[lastTimePass]
    ///然后更新数据库
    updateKanjiWordLatestPassTime(KanjiWord kanjiWord) {
      kanjiWord.lastTimePass = DateTime.now();
    }

    ///当pass了一个卡片的时候会被触发的函数
    ///
    ///pass一个卡片的时候需要更新的状态有
    ///选错答案的标记 [ifTokeWrongProvider]
    ///当前问题的卡片进度 [currentFieldProgressProvider]
    ///当前课程的问题进度 [currentQuestionCardProvider]
    ///当前kanji词语的最新学习通过时间 [currentQuestionCardProvider]
    void onPass() {
      final fieldProgress = context.read(currentFieldProgressProvider);
      final currentCard = context.read(currentQuestionCardProvider);
      final progress = context.read(currentProgressProvider);
      final tokeWrong = context.read(ifTokeWrongProvider);

      if (fieldProgress.state < currentCard.kanjiFieldAskingFor.length - 1) {
        fieldProgress.state++;
      } else {
        if (tokeWrong.state) {
          print("adding last card ");
          context
              .read(currentQuestionOrderProvider.notifier)
              .removeAt(progress.state);
          context.read(currentQuestionOrderProvider.notifier).add(currentCard);
          tokeWrong.state = false;
        } else {
          progress.state++;
        }
        fieldProgress.state = 0;
        updateKanjiWordLatestPassTime(currentCard.kanjiWord);
      }
    }

    void onTokeWrong() {
      print("u toke wrong one ");
      context.read(ifTokeWrongProvider).state = true;
    }

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
                    child: Consumer(builder: (context, watch, child) {
                      final currentKanjiField = watch(currentKanjiFieldAsking);
                      switch (currentKanjiField) {
                        case KanjiField.all:
                          return KanjiOverviewCard(onPass, onTokeWrong);
                        case KanjiField.kanjikata:
                          return ChooseKanjiCard(onPass, onTokeWrong);
                        case KanjiField.hiragana:
                          return FourChoiceCard(onPass, onTokeWrong);
                        case KanjiField.meaning:
                          return FourChoiceCard(onPass, onTokeWrong);
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
        final currentProgress = watch(currentProgressProvider).state;
        final currentOrder = watch(currentQuestionOrderProvider);
        final percentage = currentProgress / currentOrder.length;
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
        onPressed: () async {
          // popThisPageOut(context);
          await showSettingMenuDialog(context);
        },
        icon: const Icon(Icons.settings_rounded),
      ),
    ]);
  }
}

abstract class QuestionCardBlock extends HookWidget {
  final void Function()? onPass;
  final void Function()? onTokeWrong;

  const QuestionCardBlock(this.onPass, this.onTokeWrong, {Key? key});
}
