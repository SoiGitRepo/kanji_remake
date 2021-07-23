import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';
import 'package:kanji_remake/theme.dart';

enum SpeechSpeed { Off, Slow, Medium, Fast }
enum ReviewQuestionOrder { EnglisnFirst, JapaneseFirst, Random }

const reviewQuestionOrderOptions = [
  ReviewQuestionOrder.EnglisnFirst,
  ReviewQuestionOrder.JapaneseFirst,
  ReviewQuestionOrder.Random,
];

const speechSpeedOptions = [
  SpeechSpeed.Off,
  SpeechSpeed.Slow,
  SpeechSpeed.Medium,
  SpeechSpeed.Fast
];

class SettingDialog extends HookWidget {
  const SettingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final speechSpeed = useProvider(speechSpeedProvider);
    final order = useProvider(reviewQuestionOrderProvider);
    final frequency = useProvider(frequencyProvider);

    void onChangeSpeechSpeed(SpeechSpeed speed) {
      context.read(speechSpeedProvider).state = speed;
    }

    void onChangeOrder(ReviewQuestionOrder order) {
      context.read(reviewQuestionOrderProvider).state = order;
    }

    void onChangeFrequency(double percent) {
      context.read(frequencyProvider.notifier).state = percent;
    }

    return MyDialogContainer(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              child: Icon(
                Icons.close_rounded,
                color: kPrymaryColor,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          CustomRadioGroup(
            title: "Speech Speed",
            options: speechSpeedOptions,
            initialIndex: speechSpeedOptions.indexOf(speechSpeed.state),
            wrapContent: false,
            onChangeSelected: onChangeSpeechSpeed,
          ),
          SizedBox(
            height: kSmallPaddding,
          ),
          RadioGroupWithTabBar(
            title: "Review Question Order",
            options: reviewQuestionOrderOptions,
            initialIndex: reviewQuestionOrderOptions.indexOf(order.state),
            onChangeSelected: onChangeOrder,
            wrapContent: false,
          ),
          SizedBox(
            height: kSmallPaddding,
          ),
          Text('Review Frequency:'),
          Row(
            children: [
              Text(
                'Less',
                style: TextStyle(fontSize: kSmallerText),
              ),
              Expanded(
                child: Slider(
                    activeColor: kPrymaryColor,
                    inactiveColor: kRadioGroupColor,
                    max: 100,
                    value: frequency.state,
                    onChanged: (percent) {
                      onChangeFrequency(percent.round().toDouble());
                    }),
              ),
              Text(
                'More',
                style: TextStyle(fontSize: kSmallerText),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.5,
              child: TextButton(
                style: TextButton.styleFrom(
                  side: BorderSide(color: kPrymaryColor, width: 1.2),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return MyDialogContainer();
                      });
                },
                child: FittedBox(
                  child: Text(
                    "Send FeedBack",
                    style: whiteSubTitleText.copyWith(
                        color: kPrymaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: kSmallText),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

final speechSpeedProvider =
    StateProvider<SpeechSpeed>((ref) => SpeechSpeed.Medium);

final reviewQuestionOrderProvider = StateProvider<ReviewQuestionOrder>(
    (ref) => ReviewQuestionOrder.EnglisnFirst);

final frequencyProvider = StateProvider<double>((ref) => 10);
