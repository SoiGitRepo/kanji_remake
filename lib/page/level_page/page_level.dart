import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/level.dart';
import 'package:kanji_remake/page/lesson_page/lesson_provider.dart';
import 'package:kanji_remake/page/level_page/level_entry.dart';
import 'package:kanji_remake/repo/lesso_repo.dart';

class LevelPage extends HookConsumerWidget {
  const LevelPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Level> list = Level.fetchAll();
    return Scaffold(
      body: buildBody(context, list),
    );
  }

  Widget buildBody(BuildContext context, List<Level> list) {
    final size = MediaQuery.of(context).size;
    final horiOrVerti = size.width > size.height;
    return Center(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: horiOrVerti ? Axis.horizontal : Axis.vertical,
        addAutomaticKeepAlives: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Consumer(builder: (context, ref, child) {
            return GestureDetector(
              onTap: () {
                print('choosing level');
                setCurrentLessonList(ref, index);
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

  void setCurrentLessonList(ref, int jlpt) async {
    print('getting lesson');
    final lessonList = ref.read(lessonsListProvider.notifier);
    final LessonRepository lessonRepo = ref.watch(lessonRepoProvider);
    lessonList.state = await lessonRepo.getAllLessonWithJlpt(5 - jlpt);
  }

  void navigateToLesson(BuildContext context) {
    Navigator.pushNamed(context, '/lesson');
  }
}
