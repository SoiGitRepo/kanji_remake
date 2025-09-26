import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Level 颜色（首页圆形卡片底色）
// 为兼顾浅色/深色主题可读性：
// - Light 使用更浅、更柔和的粉彩色
// - Dark 使用原先更饱和的颜色，保证在深底上也有足够亮度
const List<Color> kLevelColorsLight = [
  Color(0xFFB2F0E6), // 柔和青绿（N1）
  Color(0xFFFFC9C9), // 柔和粉红（N2）
  Color(0xFFC8F7C5), // 柔和薄荷（N3）
  Color(0xFFFFE0B2), // 柔和橙杏（N4）
  Color(0xFFBBD7FF), // 柔和天空蓝（N5）
];

const List<Color> kLevelColorsDark = [
  Color.fromARGB(255, 77, 180, 185),
  Color.fromARGB(255, 254, 68, 82),
  Color.fromARGB(255, 49, 204, 112),
  Color.fromARGB(255, 254, 164, 18),
  Color.fromARGB(255, 74, 136, 219),
];

// 兼容旧代码：默认沿用深色方案（与之前一致）
const List<Color> kLevelColors = kLevelColorsDark;

const kPrymaryColor = Color(0xff243141);
const kButtonBgColor = Color(0xff2FCC71);
const kButtonBgColor2 = Color(0xff313E4E);
const kButtonBgColorDisable = Color(0x10151B);
const kScaffoldBgColor = Color(0xff243141);
const kReviewLableColor = Color(0xffFFA70F);
const kReadyLableColor = Color(0xff69CB5C);
const kProgressIndicatorColor = Color(0xffFE4253);
const kBody2Color = Color(0xffD3D4D9);
const kRadioGroupColor = Color(0xffD4D4D6);
const kDividerColor = Color(0xffB5B5B7);
const kCursorColor = Color(0xff446BF2);
const kDialogBgColor = Color(0xffF2F2F2);

// ========================= Material 3 ColorScheme 封装 =========================

// 语义色扩展：便于在业务中使用“成功/警告”等颜色，而不是直接硬编码具体值
@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color success; // 成功/可用
  final Color warning; // 警告/提醒（例如复习）

  const AppColors({required this.success, required this.warning});

  @override
  AppColors copyWith({Color? success, Color? warning}) => AppColors(
        success: success ?? this.success,
        warning: warning ?? this.warning,
      );

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      success: Color.lerp(success, other.success, t) ?? success,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
    );
  }
}

// 品牌色（用于 M3 的种子色或主色）
const Color kBrandSeed = kPrymaryColor; // 深蓝灰，项目主色

// Light 配色方案（全显式定义：白底黑字）
final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  // 品牌主色：深蓝灰
  primary: kPrymaryColor,
  onPrimary: Colors.white,
  primaryContainer: const Color(0xFFDCE3EC),
  onPrimaryContainer: Colors.black,
  // 次级色：中性蓝灰
  secondary: const Color(0xFF536273),
  onSecondary: Colors.white,
  secondaryContainer: const Color(0xFFE7EBF0),
  onSecondaryContainer: Colors.black,
  // 第三级：确认/强调绿色
  tertiary: kButtonBgColor,
  onTertiary: Colors.white,
  tertiaryContainer: const Color(0xFFCFF5E0),
  onTertiaryContainer: Colors.black,
  // 错误色
  error: Colors.redAccent.shade400,
  onError: Colors.white,
  errorContainer: Colors.red.shade100,
  onErrorContainer: Colors.red.shade900,
  // 表面/背景
  surface: Colors.white,
  onSurface: Colors.black,
  surfaceContainerHighest: const Color(0xFFF0F2F5),
  surfaceContainerHigh: const Color(0xFFF3F5F8),
  surfaceContainer: const Color(0xFFF6F8FA),
  surfaceContainerLow: const Color(0xFFF9FAFB),
  surfaceContainerLowest: Colors.white,
  surfaceVariant: const Color(0xFFE6E8EC),
  onSurfaceVariant: Colors.black87,
  outline: const Color(0x33000000),
  outlineVariant: const Color(0x1F000000),
  // 其他
  shadow: Colors.black,
  scrim: Colors.black54,
  inverseSurface: Colors.black,
  onInverseSurface: Colors.white,
  inversePrimary: const Color(0xFF90A4C1),
  background: Colors.white,
  onBackground: Colors.black,
);

// Dark 配色方案（使用原先“深色风格”的配色：白字深底）
final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: kPrymaryColor,
  onPrimary: Colors.white,
  primaryContainer: const Color(0xFF3A4A60),
  onPrimaryContainer: Colors.white,
  secondary: kButtonBgColor2,
  onSecondary: Colors.white,
  secondaryContainer: const Color(0xFF465465),
  onSecondaryContainer: Colors.white,
  tertiary: kButtonBgColor,
  onTertiary: Colors.white,
  tertiaryContainer: const Color(0xFF2DBD67),
  onTertiaryContainer: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  errorContainer: Colors.redAccent,
  onErrorContainer: Colors.white,
  surface: kScaffoldBgColor,
  onSurface: Colors.white,
  surfaceContainerHighest: const Color(0xFF2C3A4C),
  surfaceContainerHigh: const Color(0xFF2C3A4C),
  surfaceContainer: const Color(0xFF2C3A4C),
  surfaceContainerLow: const Color(0xFF2C3A4C),
  surfaceContainerLowest: const Color(0xFF2C3A4C),
  surfaceVariant: const Color(0xFF39475A),
  onSurfaceVariant: kBody2Color,
  outline: kDividerColor,
  outlineVariant: const Color(0xFF465465),
  shadow: Colors.black,
  scrim: Colors.black54,
  inverseSurface: Colors.white,
  onInverseSurface: Colors.black,
  inversePrimary: const Color(0xFF90A4C1),
  background: kScaffoldBgColor,
  onBackground: Colors.white,
);

// 构建 ThemeData（Material 3）
ThemeData buildLightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: lightColorScheme.background,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: lightColorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
      // 状态栏图标/文字：Light 使用深色（黑色）
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // Android: 图标颜色
        statusBarIconBrightness: Brightness.dark,
        // iOS: 文本颜色与背景对比，设置为浅背景（dark icons）
        statusBarBrightness: Brightness.light,
        systemStatusBarContrastEnforced: false,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: const Size.fromHeight(35),
      ),
    ),
    iconTheme: IconThemeData(color: lightColorScheme.onSurface, size: 30),
    dividerColor: Colors.black12,
    extensions: const [
      AppColors(
        success: kButtonBgColor, // 绿色：可用/准备好
        warning: kReviewLableColor, // 橙色：需要复习等提醒
      ),
    ],
  );
}

ThemeData buildDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: darkColorScheme.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      // 状态栏图标/文字：Dark 使用浅色（白色）
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // Android: 图标颜色
        statusBarIconBrightness: Brightness.light,
        // iOS: 文本颜色与背景对比，设置为深背景（light icons）
        statusBarBrightness: Brightness.dark,
        systemStatusBarContrastEnforced: false,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkColorScheme.secondary,
        foregroundColor: darkColorScheme.onSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: const Size.fromHeight(35),
      ),
    ),
    iconTheme: IconThemeData(color: darkColorScheme.onSurface, size: 30),
    dividerColor: Colors.white24,
    extensions: const [
      AppColors(
        success: kButtonBgColor, // 深色下保持一致
        warning: kReviewLableColor,
      ),
    ],
  );
}
