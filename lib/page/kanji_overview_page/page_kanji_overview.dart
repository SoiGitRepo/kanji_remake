import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/page/setting_dialog/sync/setting_sync_route.dart';
import 'package:go_router/go_router.dart';

class KanjiOverviewPage extends HookConsumerWidget {
  const KanjiOverviewPage({Key? key}) : super(key: key);

  void popThisPageOut(BuildContext context) {
    context.pop();
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
        elevation: 0,
        backgroundColor: kScaffoldBgColor,
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
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );
  }
}
