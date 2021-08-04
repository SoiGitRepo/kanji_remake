import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/model/level.dart';

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
      padding: const EdgeInsets.all(kNormalPaddding),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: levelEntity.color,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(1.0, 1.0), //(x,y)
                    blurRadius: 5.0,
                  )
                ]),
            child: SizedBox(
              width: width,
              height: width,
              child: Center(
                  child: FittedBox(
                child: Text(
                  levelEntity.title,
                  style: _theme.textTheme.headline1?.copyWith(
                    color: Colors.white,
                  ),
                ),
              )),
            ),
          ),
          const SizedBox(
            height: kSmallPaddding,
          ),
          Text(
            "${_appLocalizations.level} ${levelEntity.level}",
            style: _theme.textTheme.headline6?.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: kSmallPaddding,
          ),
          Text(
            "(${_appLocalizations.jlpt} ${levelEntity.title})",
            style: _theme.textTheme.bodyText2?.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
