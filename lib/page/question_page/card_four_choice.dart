import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/model/kanji_word.dart';
import 'package:kanji_remake/page/question_page/page_question.dart';
import 'package:kanji_remake/page/question_page/question_state_provider.dart';
import 'package:kanji_remake/utils/util.dart';

final _buttonEnableProvider = StateNotifierProvider(
    (ref) => ListBoolNotifier(List.generate(4, (index) => true)));

class FourChoiceCard extends QuestionCardBlock {
  FourChoiceCard(void Function() onPass, void Function() onTokeWrong)
      : super(onPass, onTokeWrong);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kanjiFieldAsking = ref.watch(currentKanjiFieldAsking);
    final ifShowSubTitle = ref.watch(showSubTitle);
    final buttonEnableList = ref.watch(_buttonEnableProvider) as List;
    final allButtonChoices = ref.watch(allChoicesProvider);
    final currentCard = ref.watch(currentQuestionCardProvider);

    final S appLocalizations = S.of(context);
    final Size size = MediaQuery.of(context).size;
    final labelHeight = size.height * kLabelHeightRTSH;
    final titleHeight = size.height * kTitleHeightRTSH;
    final subtitleHeight = size.height * kSubtitleHeightRTSH;

    final ifChoosingHiragana = kanjiFieldAsking == KanjiField.hiragana;
    final currentAnswer = ifChoosingHiragana
        ? currentCard.kanjiWord.hiragana
        : currentCard.kanjiWord.meanings?.toString() ?? "";

    onThisPass() {
      onPass!();
      ref.read(_buttonEnableProvider.notifier).setAllto(true);
    }

    onTakenWrongAnswer(index) {
      onTokeWrong!();
      ref.read(_buttonEnableProvider.notifier).toggle(index);
    }

    return DefaultTextStyle(
      style: TextStyle(color: Colors.white, fontSize: titleHeight),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: labelHeight,
              child: FittedBox(
                child: Text(
                  appLocalizations.which_is,
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: kBigPaddding,
              ),
              Center(
                child: SizedBox(
                  height: titleHeight,
                  child: FittedBox(
                    child: Text(
                      currentCard.kanjiWord.word,
                    ),
                  ),
                ),
              ),
              ifShowSubTitle
                  ? Center(
                      child: SizedBox(
                        height: subtitleHeight,
                        child: FittedBox(
                          child: Text(
                            ifChoosingHiragana
                                ? currentCard.kanjiWord.meanings
                                        ?.take(2)
                                        .toString() ??
                                    'no hiragana'
                                : currentCard.kanjiWord.hiragana ??
                                    'no english Meaning',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: allButtonChoices.map((e) {
              final index = allButtonChoices.indexOf(e);
              return Padding(
                padding: const EdgeInsets.all(kSmallPaddding),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kNormalRadius)),
                        minimumSize: Size.fromHeight(kNormalButtonHeight),
                        primary: kButtonBgColor2),
                    onPressed: buttonEnableList[index]
                        ? () {
                            if (e != currentAnswer) {
                              onTakenWrongAnswer(index);
                            } else {
                              onThisPass();
                            }
                          }
                        : null,
                    child: FittedBox(child: Text(e ?? ''))),
              );
            }).toList(),
          ),
          SizedBox(
            height: kSmallPaddding,
          )
        ],
      ),
    );
  }
}
