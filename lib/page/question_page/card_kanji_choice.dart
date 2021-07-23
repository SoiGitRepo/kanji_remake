import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/model/question_card.dart';
import 'package:kanji_remake/page/question_page/quesition_page.dart';
import 'package:kanji_remake/page/question_page/question_state_provider.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';
import 'package:kanji_remake/theme.dart';
import 'package:kanji_remake/utils/functions.dart';
import 'package:kanji_remake/utils/util.dart';

class ChooseKanjiCard extends QuestionCardBlock {
  ChooseKanjiCard(void Function() onPass, void Function() onTokeWrong)
      : super(onPass, onTokeWrong);

  @override
  Widget build(BuildContext context) {
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
    final currentAnswerIndex = useProvider(_currentAnswerIndex);
    final ifChosen = useProvider(_ifChosen);
    final currentCard = useProvider(currentQuestionCardProvider);

    final S _appLocalizations = S.of(context);
    final allButtonChoices = context.read(allChoicesProvider);
    final currentKanjiWord =
        context.read(currentQuestionCardProvider).kanjiWord;
    final currentAnswerQueue = context.read(currentKanjikataQueue);
    final ifDone = ifChosen
            .take(currentAnswerQueue.length)
            .where((element) => element)
            .length ==
        currentAnswerQueue.length;
    final answerHeight = min(
        (size.width - 2 * kNormalPaddding) /
            (currentKanjiWord.kanjikata!.length),
        choiceHeight);
    final answerPaddingLeft = (size.width -
            2 * kNormalPaddding -
            answerHeight * (currentKanjiWord.kanjikata!.length)) /
        2;

    bool isAnswer(int index) {
      return index < currentAnswerQueue.length;
    }

    bool isChosenAsCorrect(int index) {
      return currentAnswerIndex.state >= index && ifChosen[index];
    }

    double caculateChoiceButtonLeft(int index) {
      return choicePaddingLeft + index % 3 * (choiceHeight + kSmallPaddding);
    }

    double caculateChosenButtonLeft(int index) {
      final position = currentAnswerQueue[index].key;
      return answerPaddingLeft + answerHeight * position;
    }

    caculateChoiceButtonBottom(MapEntry<int, String> e) {
      if (isChosenAsCorrect(e.key)) {
        return size.height * 0.6;
      }
      return kBigPaddding +
          ((8 - allButtonChoices.indexOf(e)) / 3).floorToDouble() *
              (choiceHeight + kSmallPaddding);
    }

    void toggleChosen(int index) {
      context.read(_ifChosen.notifier).toggle(index);
    }

    void cancelOtherChosen() {
      allButtonChoices.forEach((element) {
        if (element.key > currentAnswerIndex.state && ifChosen[element.key]) {
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
                  if (currentAnswerIndex.state >= e.key) {
                    cancelOtherChosen();
                    if (currentAnswerIndex.state <
                        currentAnswerQueue.length - 1) {
                      currentAnswerIndex.state++;
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
              : ifDone
                  ? Container()
                  : Positioned(
                      left:
                          caculateChoiceButtonLeft(allButtonChoices.indexOf(e)),
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
                    );
        },
      ).toList();
    }

    buildAnswerWithoutKanji() {
      return currentKanjiWord.kanjikata!.codeUnits.map(
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
            height: titleHeight,
            child: FittedBox(
              child: Text(
                currentKanjiWord.enMeaning ?? 'no Kanjikata',
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
          ifDone
              ? Positioned(
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
                )
              : Container(),
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
  final codeUnits = currentKanjiWord.kanjikata!.codeUnits;
  final List<MapEntry<int, int>> queue = [];
  for (int i = 0; i < codeUnits.length; i++) {
    queue.add(MapEntry(i, codeUnits[i]));
  }
  return queue.where((value) => isNotHiragana(value.value)).toList();
});
