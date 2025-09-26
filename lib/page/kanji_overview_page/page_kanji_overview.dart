import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/page/setting_dialog/sync/setting_sync_route.dart';
import 'package:go_router/go_router.dart';

class KanjiOverviewPage extends HookConsumerWidget {
  const KanjiOverviewPage({Key? key}) : super(key: key);

  void popThisPageOut(BuildContext context) {
    try {
      final canPopGo = GoRouter.of(context).canPop();
      final canPopNav = Navigator.of(context).canPop();
      if (canPopGo || canPopNav) {
        Navigator.of(context).maybePop();
      } else {
        context.go('/lesson');
      }
    } catch (_) {
      context.go('/lesson');
    }
  }

  showSyncSettingDialog(BuildContext context) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SyncRoute();
        });
  }

  showAuthDialog(BuildContext context) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Material(child: SyncRoute());
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // 遵循全局主题（Material 3）设置的 AppBarTheme 与状态栏样式
        leading: IconButton(
          onPressed: () {
            popThisPageOut(context);
          },
          icon: const Icon(Icons.close_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await showSyncSettingDialog(context);
            },
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
    );
  }
}
