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
