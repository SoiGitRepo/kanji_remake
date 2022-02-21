import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/page/setting_dialog/feedback/setting_send_feedback.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';

class SettingDialog extends HookConsumerWidget {
  const SettingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final locale = S.of(context);
    final speechSpeed = ref.watch(speechSpeedProvider);
    final order = ref.watch(reviewQuestionOrderProvider);
    final frequency = ref.watch(frequencyProvider);

    void onChangeSpeechSpeed(SpeechSpeed speed) {
      ref.read(speechSpeedProvider.notifier).state = speed;
    }

    void onChangeOrder(ReviewQuestionOrder order) {
      ref.read(reviewQuestionOrderProvider.notifier).state = order;
    }

    void onChangeFrequency(double percent) {
      ref.read(frequencyProvider.notifier).state = percent;
    }

    jumpToSendFeedBack() async {
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return SendFeedBackPage();
          });
    }

    return MyDialogContainer(
      child: Column(
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
            title: locale.speech_speed,
            options: speechSpeedOptions,
            initialIndex: speechSpeedOptions.indexOf(speechSpeed),
            wrapContent: false,
            onChangeSelected: onChangeSpeechSpeed,
          ),
          SizedBox(
            height: kSmallPaddding,
          ),
          RadioGroupWithTabBar(
            title: locale.review_order,
            options: reviewQuestionOrderOptions,
            initialIndex: reviewQuestionOrderOptions.indexOf(order),
            onChangeSelected: onChangeOrder,
            wrapContent: false,
          ),
          SizedBox(
            height: kSmallPaddding,
          ),
          Text('${locale.review_fre}:'),
          Row(
            children: [
              Text(
                locale.less,
                style: TextStyle(fontSize: kSmallerText),
              ),
              Expanded(
                child: Slider(
                    activeColor: kPrymaryColor,
                    inactiveColor: kRadioGroupColor,
                    max: 100,
                    value: frequency,
                    onChanged: (percent) {
                      onChangeFrequency(percent.round().toDouble());
                    }),
              ),
              Text(
                locale.more,
                style: TextStyle(fontSize: kSmallerText),
              ),
            ],
          ),
        ],
      ),
      actions: [
        MyOutlineTextButton(
          text: locale.send_feedback,
          onTap: jumpToSendFeedBack,
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
