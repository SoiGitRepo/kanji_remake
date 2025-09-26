import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/providers/app_providers.dart';
import 'package:kanji_remake/page/kanji_overview_page/page_kanji_overview.dart';
import 'package:kanji_remake/page/lesson_page/page_lesson.dart';
import 'package:kanji_remake/page/question_page/page_question.dart';
import 'package:kanji_remake/page/splash_page/page_splash.dart';
// import 'package:kanji_remake/theme.dart'; // 已迁移到 colors.dart 的 M3 主题构建
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kanji_remake/widgets/system_ui_overlay.dart';

// Router provider for navigation
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/lesson',
        builder: (context, state) => const LessonPage(),
      ),
      GoRoute(
        path: '/learning',
        builder: (context, state) => const QuestionPage(),
      ),
      GoRoute(
        path: '/kanji_overview',
        builder: (context, state) => const KanjiOverviewPage(),
      ),
    ],
  );
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPre = await SharedPreferences.getInstance();
  // 开启沉浸式边到边，配合 AnnotatedRegion 与 AppBarTheme 统一控制状态栏/导航栏样式
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPre),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
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
      // Material 3 主题：根据系统浅色/深色自动切换
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.system,
      routerConfig: router,
      // 用带有 WidgetsBindingObserver 的 SystemUIOverlay 组件全局包裹，
      // 监听系统浅/深色切换并动态更新状态栏/导航栏样式（更可靠）
      builder: (context, child) => SystemUIOverlay(child: child ?? const SizedBox.shrink()),
    );
  }
}
