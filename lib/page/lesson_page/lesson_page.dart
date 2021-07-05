import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/model/lesson_pre.dart';
import 'package:kanji_remake/page/wedgets.dart';
import 'package:kanji_remake/theme.dart';

class LessonPage extends StatelessWidget {
  late final List<LessonPre> lessons;
  late final Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    lessons = LessonPre.fetchAll();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            header(context),
            lessonList(),
          ],
        ),
      ),
    );
  }

  popThisPageOut(context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  Widget header(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            popThisPageOut(context);
          },
          icon: Icon(Icons.close_rounded),
        ),
        SizedBox(
          width: kSmallPaddding,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('data'),
              ),
              MyAnimatedSized(
                child: Visibility(
                  visible: true,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('data'),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: kSmallPaddding,
        ),
        IconButton(
          onPressed: () {
            popThisPageOut(context);
          },
          icon: Icon(Icons.apps_rounded),
        ),
      ],
    );
  }

  Widget lessonList() {
    return Expanded(
      child: ListView.builder(
          itemCount: lessons.length * 3,
          itemBuilder: (context, index) {
            return buildLessonEntry(context, lessons[index % lessons.length]);
          }),
    );
  }

  Widget buildLessonEntry(BuildContext context, LessonPre lessonPre) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kBigPaddding, vertical: kSmallPaddding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Theme.of(context).primaryColor),
            child: Center(
              //TODO: state Big Icon
              child: Text(
                lessonPre.kanjiList.first.kanjikata.toString().characters.first,
                style: whiteBigIcon,
              ),
            ),
          ),
          SizedBox(
            width: kSmallPaddding,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TODO: state lesson title
                Text(
                  "data",
                  style: whiteTitle,
                ),
                Text(
                  lessonPre.kanjiList
                      .map((e) => e.kanjikata)
                      .toString()
                      .substring(1)
                      .replaceAll(')', ''),
                  maxLines: 2,
                  style: whiteBody1,
                ),
                Visibility(
                  //TODO: state label visibility
                  visible: true,
                  child: Text(
                    "data",
                    style: whiteLable.apply(color: Colors.green[400]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
