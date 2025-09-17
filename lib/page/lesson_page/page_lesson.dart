import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/page/lesson_page/lesson_list_tile.dart';
import 'package:kanji_remake/providers/lesson_providers.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';
import 'package:go_router/go_router.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            header(context),
            lessonList(context),
          ],
        ),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            popThisPageOut(context);
          },
          icon: const Icon(Icons.close_rounded),
        ),
        const SizedBox(
          width: kSmallPaddding,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(_appLocalizations.custom_review),
                style: Theme.of(context).elevatedButtonTheme.style,
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
                        style: TextStyle(color: kReviewLableColor),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(
          width: kSmallPaddding,
        ),
        IconButton(
          onPressed: () {
            context.push('/kanji_overview');
          },
          icon: const Icon(Icons.apps_rounded),
        ),
      ],
    );
  }

  Widget lessonList(BuildContext context) {
    return Expanded(
      child: Consumer(
        builder: (context, ref, child) {
          final lessons = ref.watch(lessonsProvider);
          final length = lessons.length;

          if (length == 0) {
            // 尝试加载一次课程（避免重复触发）
            ref.read(lessonsProvider.notifier).loadLessons();
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
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
      ),
    );
  }
}
