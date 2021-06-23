import 'package:flutter/material.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/model/level.dart';

class StartPage extends StatelessWidget {
  late final Size size;
  late final ThemeData _theme;
  late final S _appLocalizations;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    _theme = Theme.of(context);
    _appLocalizations = S.of(context);

    return Scaffold(
      // appBar: null,
      backgroundColor: Colors.blueGrey[900],
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: ListView(
        addAutomaticKeepAlives: false,
        children: buildNavi(),
      ),
    );
  }

  List<Widget> buildNavi() {
    return Level.fetchAll().reversed.map((e) => levelEntry(e)).toList();
  }

  Widget levelEntry(Level levelEntity) {
    var width = size.width * 0.6;
    return Padding(
      padding: const EdgeInsets.all(kNormalPaddding),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: levelEntity.color,
                shape: BoxShape.circle,
                boxShadow: [
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
                  child: Text(
                levelEntity.title,
                style: _theme.textTheme.headline1?.copyWith(
                  color: Colors.white,
                ),
              )),
            ),
          ),
          SizedBox(
            height: kSmallPaddding,
          ),
          Text(
            "${_appLocalizations.level} ${levelEntity.level}",
            style: _theme.textTheme.headline6?.copyWith(color: Colors.white),
          ),
          SizedBox(
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
