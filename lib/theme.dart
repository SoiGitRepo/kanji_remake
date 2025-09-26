import 'package:flutter/material.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';

//textstyle
const TextStyle whiteBigIconText =
    TextStyle(fontSize: 45.0, color: Colors.white);
const TextStyle whiteTitleText =
    TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold);
const TextStyle whiteSubTitleText =
    TextStyle(fontSize: 20.0, color: Colors.white);
const TextStyle whiteLableText =
    TextStyle(fontSize: kNormalText, color: Colors.white);
final TextStyle whiteLable2Text = TextStyle(
    fontSize: kSmallText, color: Colors.grey[850], fontWeight: FontWeight.w300);
const TextStyle whiteBody1Text =
    TextStyle(fontSize: kSmallText, color: Colors.white);
const TextStyle whiteBody2Text =
    TextStyle(fontSize: kSmallerText, color: Colors.white);
const TextStyle blueBody1Text =
    TextStyle(fontSize: kSmallText, color: kButtonBgColor2);

final ButtonStyle kNormalButtonStyle = ElevatedButton.styleFrom(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
  backgroundColor: Colors.transparent,
  textStyle: blueBody1Text,
  minimumSize: Size.fromHeight(35),
);

final ButtonStyle kOkButtonStyle = ElevatedButton.styleFrom(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  ),
  backgroundColor: kButtonBgColor,
  textStyle: const TextStyle(
    color: Colors.white,
    fontSize: kBigText,
  ),
  minimumSize: Size.fromHeight(48),
);

// ===================== 推荐：按主题派生的文本样式（避免硬编码） =====================
// 保留上面的白字常量以兼容旧代码；新代码请优先使用下面这些 helpers。

class AppTextStyles {
  const AppTextStyles._();

  // 标题（主文色）
  static TextStyle title(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)
        .copyWith(color: cs.onSurface);
  }

  // 副标题（主文色）
  static TextStyle subTitle(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return const TextStyle(fontSize: 20.0).copyWith(color: cs.onSurface);
  }

  // 正文（次要信息）
  static TextStyle body1(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(fontSize: kSmallText, color: cs.onSurfaceVariant);
  }

  static TextStyle body2(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(fontSize: kSmallerText, color: cs.onSurfaceVariant);
  }

  // 大图标文字（根据语义色选择前景）
  static TextStyle bigIconOnTertiary(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return const TextStyle(fontSize: 45.0).copyWith(color: cs.onTertiary);
  }
}

// 也可以作为 BuildContext 的扩展，方便调用：context.texts.title
extension AppTextStylesX on BuildContext {
  AppTextStyles get texts => const AppTextStyles._();
}

// ===================== 推荐：按主题派生的按钮样式（避免硬编码） =====================
class AppButtonStyles {
  const AppButtonStyles._();

  static ButtonStyle primary(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ElevatedButton.styleFrom(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
      textStyle: const TextStyle(fontSize: kBigText),
      minimumSize: const Size.fromHeight(48),
    );
  }

  static ButtonStyle normal(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ElevatedButton.styleFrom(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      backgroundColor: Colors.transparent,
      foregroundColor: cs.onSurface,
      textStyle: TextStyle(fontSize: kNormalText, color: cs.onSurface),
      minimumSize: const Size.fromHeight(35),
    );
  }
}
