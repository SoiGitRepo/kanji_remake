import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/level.dart';
import 'package:kanji_remake/page/lesson_page/lesson_provider.dart';
import 'package:kanji_remake/page/level_page/level_entry.dart';
import 'package:kanji_remake/repo/lesso_repo.dart';

class LevelPage extends HookWidget {
  const LevelPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Level> list = Level.fetchAll();
    return Scaffold(
      body: buildBody(context, list),
    );
  }

  Widget buildBody(BuildContext context, List<Level> list) {
    return Center(
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Consumer(builder: (context, watch, child) {
            return GestureDetector(
              onTap: () {
                print('choosing level');
                setCurrentLessonList(watch, index + 1);
                navigateToLesson(context);
              },
              child: WidgetLevelEntry(
                levelEntity: list[list.length - index - 1],
              ),
            );
          });
        },
      ),
    );
  }

  void setCurrentLessonList(watch, int jlpt) async {
    print('getting lesson');
    final lessonList = watch(lessonsListProvider);
    final LessonRepository lessonRepo = watch(lessonRepoProvider);
    lessonList.state = await lessonRepo.getAllLessonWithJlpt(jlpt);
  }

  void navigateToLesson(BuildContext context) {
    Navigator.pushNamed(context, '/lesson');
  }
}
