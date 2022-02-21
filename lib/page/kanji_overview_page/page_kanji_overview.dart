import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/global_providers.dart';
import 'package:kanji_remake/page/setting_dialog/sync/setting_sync_route.dart';

class KanjiOverviewPage extends HookWidget {
  const KanjiOverviewPage({Key? key}) : super(key: key);

  void popThisPageOut(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
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
  Widget build(BuildContext context) {
    final authState = useProvider(authServiceProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kScaffoldBgColor,
        brightness: Brightness.dark,
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
