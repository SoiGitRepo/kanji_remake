import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/model/question_card.dart';
import 'package:kanji_remake/page/question_page/question_state_provider.dart';
import 'package:kanji_remake/utils/util.dart';

final _buttonEnableProvider = StateNotifierProvider(
    (ref) => ListBoolNotifier(List.generate(4, (index) => true)));

class ChooseFromKanjiKataCard extends HookWidget {
  const ChooseFromKanjiKataCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S appLocalizations = S.of(context);
    final Size size = MediaQuery.of(context).size;
    final labelHeight = size.height * kLabelHeightRTSH;
    final titleHeight = size.height * kTitleHeightRTSH;
    final subtitleHeight = size.height * kSubtitleHeightRTSH;

    final currentCard = useProvider(currentLearningCardProvider);
    // final kanjiFieldAsking = currentCard.kanjiFieldAskingFor.first;

    final currentOrderIndex = useProvider(currentLearningOrderIndexProvider);
    final haveTakenWrongOne = useProvider(currentCardTokeWrongProvider);
    final currentKanjiWords =
        useProvider(currentLessonKanjiWordsProvider).state.toSet();
    final ifChoosingHirakata =
        currentCard.questionCardType == QuestionCardType.kanjiOnly;
    final showSubTitle = useState(false);
    final hiratakaOrMeaning = !showSubTitle.value == ifChoosingHirakata;
    final currentAnswer = hiratakaOrMeaning
        ? currentCard.kanjiWord.hiragana
        : currentCard.kanjiWord.enMeaning;
    final buttonEnableList = useProvider(_buttonEnableProvider);
    final allChoices = currentKanjiWords
        .skipWhile((value) => hiratakaOrMeaning
            ? value.hiragana == currentAnswer
            : value.enMeaning == currentAnswer)
        .take(3)
        .map(
          (e) => hiratakaOrMeaning ? e.hiragana : e.enMeaning,
        )
        .toList()
          ..add(hiratakaOrMeaning
              ? currentCard.kanjiWord.hiragana
              : currentCard.kanjiWord.enMeaning);

    onFistPass() {
      showSubTitle.value = !showSubTitle.value;
      context.read(_buttonEnableProvider.notifier).setAllto(true);
    }

    onSecPass() {
      if (haveTakenWrongOne.state) {
        context
            .read(currentLearningOrderProvider.notifier)
            .removeAt(currentOrderIndex.state);
        context.read(currentLearningOrderProvider.notifier).add(currentCard);
      } else {
        currentOrderIndex.state++;
      }
      haveTakenWrongOne.state = false;
      onFistPass();
    }

    onTakenWrongAnswer(index) {
      haveTakenWrongOne.state = true;
      context.read(_buttonEnableProvider.notifier).toggle(index);
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
                      currentCard.kanjiWord.kanjikata ?? 'no Kanjikata',
                    ),
                  ),
                ),
              ),
              showSubTitle.value
                  ? Center(
                      child: SizedBox(
                        height: subtitleHeight,
                        child: FittedBox(
                          child: Text(
                            ifChoosingHirakata
                                ? currentCard.kanjiWord.hiragana ??
                                    'no Kanjikata'
                                : currentCard.kanjiWord.enMeaning ??
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
            children: allChoices.map((e) {
              final index = allChoices.indexOf(e);
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
                              if (showSubTitle.value) {
                                onSecPass();
                              } else {
                                onFistPass();
                              }
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

// final currentChoosingType = Provider<KanjiField>((ref) {
//   final currentLearningCard = ref.watch(currentLearningCardProvider);
//   currentLearningCard.learningCardEvent
// });

// final _allChoices = Provider<List<String>>((ref) {
//   final currentKanjiWords = ref.watch(currentLessonKanjiWords);

//   return currentKanjiWords
//       .skipWhile((value) => hiratakaOrMeaning
//           ? value.hiragana == currentAnswer
//           : value.enMeaning == currentAnswer)
//       .take(3)
//       .map(
//         (e) => hiratakaOrMeaning ? e.hiragana : e.enMeaning,
//       )
//       .toList()
//         ..add(hiratakaOrMeaning
//             ? currentCard.kanjiWord.hiragana
//             : currentCard.kanjiWord.enMeaning);
// });
