import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/page/lesson_page/lesson_page.dart';
import 'package:kanji_remake/page/start_page/page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Kanji Remake',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('zh', ''),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blueGrey[900],
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 30,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: buttonColor2,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
      // home: MyHomePage(title: 'Home Page'),
      routes: {
        '/': (context) => StartPage(),
        '/lesson': (context) => LessonPage(),
      },
    );
  }
}
