import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/level.dart';
import 'package:kanji_remake/providers/lesson_providers.dart';
import 'package:kanji_remake/providers/app_providers.dart';
import 'package:kanji_remake/page/level_page/level_entry.dart';

class LevelPage extends HookConsumerWidget {
  const LevelPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Level> list = Level.fetchAll();
    final size = MediaQuery.of(context).size;
    final horiOrVerti = size.width > size.height;
    return Scaffold(
      body: Center(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: horiOrVerti ? Axis.horizontal : Axis.vertical,
          addAutomaticKeepAlives: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                await setCurrentLessonList(ref, index);
                context.push('/lesson');
              },
              child: WidgetLevelEntry(
                levelEntity: list[list.length - index - 1],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> setCurrentLessonList(WidgetRef ref, int jlpt) async {
    // 设置 JLPT 级别并触发加载
    ref.read(setJlptLevelProvider)(5 - jlpt);
    await ref.read(lessonsProvider.notifier).loadLessons();
  }
}
