// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/page/lesson_page/page_lesson.dart';
import 'package:kanji_remake/page/level_page/page_level.dart';
import 'package:kanji_remake/page/question_page/page_question.dart';
import 'package:kanji_remake/page/splash_page/page_splash.dart';
import 'package:kanji_remake/theme.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
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
        '/': (context) => SplashPage(),
        '/lesson': (context) => LessonPage(),
        '/learning': (context) => QuestionPage(),
      },
    );
  }
}
