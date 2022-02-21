import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/model/question_card.dart';
import 'package:kanji_remake/page/question_page/page_question.dart';
import 'package:kanji_remake/page/question_page/question_state_provider.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';
import 'package:kanji_remake/theme.dart';
import 'package:kanji_remake/utils/functions.dart';
import 'package:kanji_remake/utils/util.dart';

class ChooseKanjiCard extends QuestionCardBlock {
  ChooseKanjiCard(void Function() onPass, void Function() onTokeWrong)
      : super(onPass, onTokeWrong);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final labelHeight = size.height * kLabelHeightRTSH;
    final titleHeight = size.height * kTitleHeightRTSH;
    final subtitleHeight = size.height * kSubtitleHeightRTSH;
    final choiceHeight = size.height * kChoiceCardHeightRTSH;
    final choicePaddingLeft = (size.width -
            kNormalPaddding * 2 -
            choiceHeight * 3 -
            kSmallPaddding * 2) /
        2;
    final currentAnswerIndex = ref.read(_currentAnswerIndex);
    final ifChosen = ref.watch(_ifChosen);
    final currentCard = ref.watch(currentQuestionCardProvider);

    final S _appLocalizations = S.of(context);
    final allButtonChoices = ref.read(allChoicesProvider);
    final currentKanjiWord = ref.read(currentQuestionCardProvider).kanjiWord;
    final currentAnswerQueue = ref.read(currentKanjikataQueue);
    final ifDone = ifChosen
            .take(currentAnswerQueue.length)
            .where((element) => element)
            .length ==
        currentAnswerQueue.length;
    final answerHeight = min(
        (size.width - 2 * kNormalPaddding) / (currentKanjiWord.word.length),
        choiceHeight);
    final answerPaddingLeft = (size.width -
            2 * kNormalPaddding -
            answerHeight * (currentKanjiWord.word.length)) /
        2;

    bool isAnswer(int index) {
      return index < currentAnswerQueue.length;
    }

    bool isChosenAsCorrect(int index) {
      return currentAnswerIndex >= index && ifChosen[index];
    }

    double caculateChoiceButtonLeft(int index) {
      return choicePaddingLeft + index % 3 * (choiceHeight + kSmallPaddding);
    }

    double caculateChosenButtonLeft(int index) {
      final position = currentAnswerQueue[index].key;
      return answerPaddingLeft + answerHeight * position;
    }

    double caculateChoiceButtonBottom(MapEntry<int, String> e) {
      if (isChosenAsCorrect(e.key)) {
        return size.height * 0.6;
      }
      return kBigPaddding +
          ((8 - allButtonChoices.indexOf(e)) / 3).floorToDouble() *
              (choiceHeight + kSmallPaddding);
    }

    void toggleChosen(int index) {
      ref.read(_ifChosen.notifier).toggle(index);
    }

    void cancelOtherChosen() {
      allButtonChoices.forEach((element) {
        if (element.key > currentAnswerIndex && ifChosen[element.key]) {
          toggleChosen(element.key);
        }
      });
    }

    Function? onButtonPressed(e) {
      return isChosenAsCorrect(e.key)
          ? () {}
          : ifChosen[e.key]
              ? null
              : () {
                  toggleChosen(e.key);
                  if (currentAnswerIndex >= e.key) {
                    cancelOtherChosen();
                    if (currentAnswerIndex < currentAnswerQueue.length - 1) {
                      ref.read(_currentAnswerIndex.notifier).state++;
                    }
                  } else {
                    onTokeWrong!();
                  }
                };
    }

    List<Widget> choiceCard() {
      return allButtonChoices.map(
        (e) {
          return isAnswer(e.key)
              ? AnimatedPositioned(
                  left: isChosenAsCorrect(e.key)
                      ? caculateChosenButtonLeft(e.key)
                      : caculateChoiceButtonLeft(allButtonChoices.indexOf(e)),
                  bottom: caculateChoiceButtonBottom(e),
                  child: ChooseKanjiButton(
                    e: e,
                    height: isChosenAsCorrect(e.key)
                        ? answerHeight - kSmallPaddding
                        : choiceHeight,
                    ifChosen: ifChosen[e.key],
                    isChosenAsCorrect: isChosenAsCorrect(e.key),
                    onPressed: onButtonPressed,
                  ),
                  duration: kDuration)
              :
              //  ifDone
              //     ? Container()
              //     :
              Positioned(
                  left: caculateChoiceButtonLeft(allButtonChoices.indexOf(e)),
                  bottom: caculateChoiceButtonBottom(e),
                  child: Visibility(
                    visible: !ifDone,
                    child: ChooseKanjiButton(
                      e: e,
                      height: isChosenAsCorrect(e.key)
                          ? answerHeight - kSmallPaddding
                          : choiceHeight,
                      ifChosen: ifChosen[e.key],
                      isChosenAsCorrect: isChosenAsCorrect(e.key),
                      onPressed: onButtonPressed,
                    ),
                  ),
                );
        },
      ).toList();
    }

    buildAnswerWithoutKanji() {
      return currentKanjiWord.word.codeUnits.map(
        (e) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSmallPaddding / 2),
            child: isNotHiragana(e)
                ? SizedBox(
                    width: answerHeight - kSmallPaddding,
                  )
                : SizedBox(
                    height: answerHeight - kSmallPaddding,
                    width: answerHeight - kSmallPaddding,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        primary: kButtonBgColor2,
                        textStyle: TextStyle(fontSize: choiceHeight),
                      ),
                      child: FittedBox(
                        child: Text(
                          String.fromCharCode(e),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ).toList();
    }

    return DefaultTextStyle(
      style: TextStyle(color: Colors.white, fontSize: answerHeight),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
            left: 0,
            height: labelHeight,
            child: FittedBox(
              child: Text(
                _appLocalizations.select_kanji,
                style: TextStyle(color: kBody2Color),
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.6 + choiceHeight + subtitleHeight,
            width: size.width - 2 * kNormalPaddding,
            height: titleHeight,
            child: FittedBox(
              child: Text(
                currentKanjiWord.meanings?.toString() ?? 'no meanings',
              ),
            ),
          ),
          currentCard.questionCardType == QuestionCardType.meaningOnly
              ? Container()
              : Positioned(
                  bottom: size.height * 0.6 + choiceHeight,
                  height: subtitleHeight,
                  child: FittedBox(
                    child: Text(
                      currentKanjiWord.hiragana ?? 'no hiragana',
                    ),
                  ),
                ),
          Positioned(
            left: answerPaddingLeft,
            bottom: size.height * 0.6,
            child: Row(
              children: buildAnswerWithoutKanji(),
            ),
          ),
          ...choiceCard(),
          Visibility(
            visible: ifDone,
            child: Positioned(
              left: 0,
              bottom: 0,
              width: size.width - 2 * kNormalPaddding,
              child: Column(
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
                        onPass!();
                      },
                      child: Text(
                        'OK',
                      ),
                      style: kOkButtonStyle,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final _currentAnswerIndex = StateProvider<int>((ref) {
  ref.watch(currentQuestionCardProvider);
  return 0;
});

final _ifChosen = StateNotifierProvider<ListBoolNotifier, List<bool>>((ref) {
  ref.watch(currentQuestionCardProvider);
  return ListBoolNotifier(List.generate(9, (index) => false));
});

final currentKanjikataQueue = Provider<List<MapEntry<int, int>>>((ref) {
  final currentKanjiWord = ref.watch(currentQuestionCardProvider).kanjiWord;
  final codeUnits = currentKanjiWord.word.codeUnits;
  final List<MapEntry<int, int>> queue = [];
  for (int i = 0; i < codeUnits.length; i++) {
    queue.add(MapEntry(i, codeUnits[i]));
  }
  return queue.where((value) => isNotHiragana(value.value)).toList();
});
