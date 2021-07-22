import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/page/lesson_page/lesson_page.dart';
import 'package:kanji_remake/page/question_page/quesition_page.dart';
import 'package:kanji_remake/page/start_page/page.dart';
import 'package:kanji_remake/theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Kanji Remake',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('zh', ''),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blueGrey[900],
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: kNormalButtonStyle,
        ),
      ),
      // home: MyHomePage(title: 'Home Page'),
      routes: {
        '/': (context) => StartPage(),
        '/lesson': (context) => LessonPage(),
        '/learning': (context) => QuestionPage(),
      },
    );
  }
}
