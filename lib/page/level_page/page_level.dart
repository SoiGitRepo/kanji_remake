import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/model/level.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/providers/lesson_providers.dart';
import 'package:kanji_remake/providers/app_providers.dart';
import 'package:kanji_remake/page/level_page/level_entry.dart';

class LevelPage extends HookConsumerWidget {
  const LevelPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 根据当前主题选择首页 Level 的底色（Light 使用粉彩，Dark 使用原深色）
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? kLevelColorsDark : kLevelColorsLight;
    final List<Level> list = List.generate(
      Level.levels.length,
      (i) => Level(Level.levels[i], colors[i], i + 1),
    );
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
