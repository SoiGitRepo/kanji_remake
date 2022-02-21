import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/page/question_page/question_state_provider.dart';
import 'package:kanji_remake/page/lesson_page/lesson_list_tile.dart';
import 'package:kanji_remake/page/lesson_page/lesson_provider.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';

class LessonPage extends StatelessWidget {
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
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
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
                final lessonsToReview = ref.watch(lessonNeedReview);
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
            Navigator.pushNamed(context, '/kanji_overview');
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
          final lessons = ref.watch(lessonsListProvider);
          final length = lessons.length;

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: length - 1,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    ref.read(currentLessonKanjiWordsProvider.state).state =
                        lessons[index].wordList;
                    Navigator.pushNamed(context, '/learning');
                  },
                  child: LessonEntry(lessonPre: lessons[index]));
            },
          );
        },
      ),
    );
  }
}
