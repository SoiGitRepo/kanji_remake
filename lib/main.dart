// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/global_providers.dart';
import 'package:kanji_remake/page/kanji_overview_page/page_kanji_overview.dart';
import 'package:kanji_remake/page/lesson_page/page_lesson.dart';
import 'package:kanji_remake/page/question_page/page_question.dart';
import 'package:kanji_remake/page/setting_dialog/auth/setting_auth_route.dart';
import 'package:kanji_remake/page/splash_page/page_splash.dart';
import 'package:kanji_remake/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPre = await SharedPreferences.getInstance();
  runApp(ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(sharedPre)],
      child: MyApp()));
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
        scaffoldBackgroundColor: kScaffoldBgColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: kNormalButtonStyle,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(), // iOS風
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      // home: MyHomePage(title: 'Home Page'),
      routes: {
        '/': (context) => SplashPage(),
        '/lesson': (context) => LessonPage(),
        '/learning': (context) => QuestionPage(),
        '/kanji_overview': (context) => KanjiOverviewPage(),
      },
    );
  }
}
