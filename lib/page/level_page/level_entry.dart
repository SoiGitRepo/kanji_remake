import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/model/level.dart';
import 'package:kanji_remake/widgets/glassy/glassy.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class WidgetLevelEntry extends StatelessWidget {
  const WidgetLevelEntry({
    Key? key,
    required this.levelEntity,
  }) : super(key: key);

  final Level levelEntity;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = min(size.width, size.height) * 0.6;
    final ThemeData _theme = Theme.of(context);
    final S _appLocalizations = S.of(context);

    return Padding(
      padding: const EdgeInsets.all(kBigPaddding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Container(
                width: width,
                height: width,
                decoration: BoxDecoration(
                  // color: levelEntity.color,
                  shape: BoxShape.circle,
                  // boxShadow: const [
                  //   BoxShadow(
                  //     color: Color.fromARGB(255, 171, 150, 150),
                  //     offset: Offset(1.0, 1.0), //(x,y)
                  //     blurRadius: 5.0,
                  //   )
                  // ],
                ),
                // child: Center(child: Text("xxxxxxxxxxxxxxxxxxxxxxxxx")),
              ),
              Container(
                width: width / 4 * 3,
                height: width / 4 * 3,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  shape: BoxShape.circle,
                  // boxShadow: const [
                  //   BoxShadow(
                  //     color: Color.fromARGB(255, 171, 150, 150),
                  //     offset: Offset(1.0, 1.0), //(x,y)
                  //     blurRadius: 5.0,
                  //   )
                  // ],
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      levelEntity.title,
                      style: _theme.textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ).glassyOval(
                settings: LiquidGlassSettings(
                  glassColor: levelEntity.color.withAlpha(123),
                  thickness: 10,
                  blur: 5,
                  blend: 40,
                  lightIntensity: 0.5,
                  lightAngle: 0.7 * pi,
                  ambientStrength: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: kSmallPaddding,
          ),
          Text(
            "${_appLocalizations.level} ${levelEntity.level}",
            style: _theme.textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: kSmallPaddding,
          ),
          Text(
            "(${_appLocalizations.jlpt} ${levelEntity.title})",
            style: _theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
