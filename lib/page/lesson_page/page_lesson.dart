import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/page/lesson_page/lesson_list_tile.dart';
import 'package:kanji_remake/providers/lesson_providers.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kanji_remake/widgets/glassy/glassy.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentGeometry.topCenter,
        children: [
          lessonList(context),
          header(context),
        ],
      ),
    );
  }

  void popThisPageOut(BuildContext context) {
    try {
      final canPopGo = GoRouter.of(context).canPop();
      final canPopNav = Navigator.of(context).canPop();
      if (canPopGo || canPopNav) {
        Navigator.of(context).maybePop();
      } else {
        context.go('/lesson');
      }
    } catch (_) {
      context.go('/lesson');
    }
  }

  void navigateToKanjiOverview() {}

  Widget header(BuildContext context) {
    final S _appLocalizations = S.of(context);
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: kSmallPaddding),
          IconButton(
            onPressed: () {
              popThisPageOut(context);
            },
            icon: const Icon(Icons.close_rounded),
          ).glassyOval(
            glassContainsChild: false,
            settings: LiquidGlassSettings(blur: 1),
          ),
          const SizedBox(width: kSmallPaddding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(_appLocalizations.custom_review,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      )),
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                        shadowColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                      ),
                ).glassy(
                  borderRadius: kSmallRadius,
                  settings: LiquidGlassSettings(
                    blur: 1,
                  ),
                ),
                Consumer(builder: (context, ref, child) {
                  final lessonsToReview = ref.watch(lessonsNeedReviewProvider);
                  return MyAnimatedSized(
                    child: SizedBox(
                      height: lessonsToReview.isNotEmpty ? null : 0,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          _appLocalizations.review,
                          style: TextStyle(
                            color: Theme.of(context)
                                    .extension<AppColors>()
                                    ?.warning ??
                                Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(width: kSmallPaddding),
          IconButton(
            onPressed: () {
              context.push('/kanji_overview');
            },
            icon: const Icon(Icons.apps_rounded),
          ).glassyOval(
            glassContainsChild: false,
            settings: LiquidGlassSettings(blur: 1),
          ),
          const SizedBox(width: kSmallPaddding),
        ],
      ),
    );
  }

  Widget lessonList(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final lessons = ref.watch(lessonsProvider);
        final length = lessons.length;

        if (length == 0) {
          // 尝试加载一次课程（避免重复触发）
          ref.read(lessonsProvider.notifier).loadLessons();
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 110.0),
          physics: const BouncingScrollPhysics(),
          itemCount: length - 1,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  ref.read(selectedLessonProvider.notifier).state =
                      lessons[index];
                  context.push('/learning');
                },
                child: LessonEntry(lessonPre: lessons[index]));
          },
        );
      },
    );
  }
}
