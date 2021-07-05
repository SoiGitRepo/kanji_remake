import 'package:flutter/material.dart';
import 'package:kanji_remake/model/level.dart';
import 'package:kanji_remake/page/wedgets.dart';

class StartPage extends StatelessWidget {
  final List<Level> list = Level.fetchAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              navigateToLesson(context);
            },
            child: WidgetLevelEntry(
              levelEntity: list[list.length - index - 1],
            ),
          );
        },
      ),
    );
  }

  navigateToLesson(context) {
    Navigator.pushNamed(context, '/lesson');
  }
}
