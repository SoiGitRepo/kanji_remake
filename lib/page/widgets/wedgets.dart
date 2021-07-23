import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';

class MyAnimatedSized extends StatefulWidget {
  const MyAnimatedSized({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  _MyAnimatedSizedState createState() => _MyAnimatedSizedState();
}

class _MyAnimatedSizedState extends State<MyAnimatedSized>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: kDuration,
      vsync: this,
      child: widget.child,
    );
  }
}

class AnimationHook extends HookWidget {
  const AnimationHook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ChooseKanjiButton extends StatelessWidget {
  const ChooseKanjiButton({
    Key? key,
    required this.e,
    required this.height,
    required this.ifChosen,
    required this.isChosenAsCorrect,
    required this.onPressed,
  }) : super(key: key);

  final double height;
  final MapEntry<int, String> e;
  final bool isChosenAsCorrect, ifChosen;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kSmallPaddding / 2,
      ),
      child: SizedBox(
        height: height,
        width: height,
        child: ElevatedButton(
          onPressed: onPressed(e),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(0),
            primary: isChosenAsCorrect ? kButtonBgColor : kButtonBgColor2,
            textStyle: TextStyle(
              fontSize: height,
            ),
          ),
          child: FittedBox(
            child: Text(
              e.value,
            ),
          ),
        ),
      ),
    );
  }
}

class RadioGroupWithTabBar extends StatelessWidget {
  const RadioGroupWithTabBar({
    Key? key,
    required this.title,
    required this.options,
    required this.initialIndex,
    required this.onChangeSelected,
    this.wrapContent,
  }) : super(key: key);

  final String title;
  final List options;
  final int initialIndex;
  final Function onChangeSelected;
  final bool? wrapContent;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title:",
        ),
        Container(
          width: size.width,
          decoration: BoxDecoration(
            color: kRadioGroupColor,
            borderRadius: BorderRadius.circular(
              kSmallRadius,
            ),
          ),
          child: DefaultTabController(
              initialIndex: initialIndex,
              length: options.length,
              child: TabBar(
                isScrollable: wrapContent ?? true,
                automaticIndicatorColorAdjustment: false,
                indicatorPadding: EdgeInsets.all(2.0),
                labelPadding: EdgeInsets.symmetric(vertical: kSmallPaddding),
                labelColor: Colors.white,
                unselectedLabelColor: kPrymaryColor,
                indicator: BoxDecoration(
                    color: kPrymaryColor,
                    borderRadius: BorderRadius.circular(kSmallRadius - 2)),
                tabs: [
                  for (var item in options)
                    FittedBox(
                      child: Text(
                        item.toString().split('.').last,
                        style: TextStyle(fontSize: kSmallerText),
                      ),
                    )
                ],
                onTap: (index) {
                  onChangeSelected(options[index]);
                },
              )),
        ),
      ],
    );
  }
}

class CustomRadioGroup extends StatelessWidget {
  const CustomRadioGroup({
    Key? key,
    required this.title,
    required this.options,
    required this.initialIndex,
    required this.onChangeSelected,
    this.wrapContent,
  }) : super(key: key);

  final String title;
  final List options;
  final int initialIndex;
  final Function onChangeSelected;
  final bool? wrapContent;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).viewInsets;
    print(padding.left);
    final width = MediaQuery.of(context).size.width -
        2 * kDefaultInsetPadding -
        2 * kNormalPaddding -
        2 * 2;

    final fixedOptions = [];
    for (var i = 0; i < options.length; i++) {
      fixedOptions.add(options[i]);
      if (i == options.length - 1) {
        continue;
      }
      fixedOptions.add(0);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title:",
        ),
        Container(
          decoration: BoxDecoration(
            color: kRadioGroupColor,
            borderRadius: BorderRadius.circular(kSmallRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var item in fixedOptions)
                item == 0
                    ? Container(
                        color: kDividerColor,
                        width: 1,
                        height: 15,
                      )
                    : GestureDetector(
                        onTap: () {
                          onChangeSelected(item);
                        },
                        child: SizedBox(
                          width: width / options.length,
                          child: AnimatedContainer(
                            margin: EdgeInsets.symmetric(
                                vertical: 2.0,
                                horizontal:
                                    initialIndex == options.indexOf(item)
                                        ? 2.0
                                        : 8.0),
                            decoration: BoxDecoration(
                                color: initialIndex == options.indexOf(item)
                                    ? kPrymaryColor
                                    : kRadioGroupColor,
                                borderRadius:
                                    BorderRadius.circular(kSmallRadius - 2)),
                            duration: kFastDuration,
                            curve: Curves.easeOutCubic,
                            padding: const EdgeInsets.symmetric(
                                vertical: kSmallPaddding),
                            child: Center(
                              child: Text(
                                item.toString().split('.').last,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontSize: kSmallerText,
                                    color: initialIndex == options.indexOf(item)
                                        ? Colors.white
                                        : kPrymaryColor),
                              ),
                            ),
                          ),
                        ),
                      )
            ],
          ),
        )
      ],
    );
  }
}

class MyDialogContainer extends StatelessWidget {
  const MyDialogContainer(
      {Key? key, this.content, this.actions, this.defaultTextStyle})
      : super(key: key);

  final Widget? content;
  final List<Widget>? actions;
  final TextStyle? defaultTextStyle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kNormalRadius),
      ),
      contentPadding: const EdgeInsets.all(kNormalPaddding),
      content: DefaultTextStyle(
          style: defaultTextStyle ??
              TextStyle(
                  color: kPrymaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: kNormalText),
          child: content ?? Container()),
      actions: actions,
    );
  }
}
