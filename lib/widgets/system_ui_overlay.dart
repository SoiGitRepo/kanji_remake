import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 全局状态栏/导航栏样式控制器，监听系统浅/深色切换并动态应用样式。
class SystemUIOverlay extends StatefulWidget {
  final Widget child;
  const SystemUIOverlay({super.key, required this.child});

  @override
  State<SystemUIOverlay> createState() => _SystemUIOverlayState();
}

class _SystemUIOverlayState extends State<SystemUIOverlay>
    with WidgetsBindingObserver {
  Brightness _platformBrightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    final b = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (_platformBrightness != b) {
      setState(() {
        _platformBrightness = b;
      });
    }
  }

  SystemUiOverlayStyle _buildStyle() {
    final isDark = _platformBrightness == Brightness.dark;
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = _buildStyle();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        systemOverlayStyle: style,
      ),
      body: widget.child,
    );
  }
}
