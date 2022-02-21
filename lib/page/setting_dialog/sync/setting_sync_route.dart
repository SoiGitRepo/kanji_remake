import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/page/setting_dialog/auth/auth_viewmodel.dart';
import 'package:kanji_remake/page/setting_dialog/auth/setting_auth_route.dart';
import 'package:kanji_remake/page/setting_dialog/sync/setting_sync.dart';
import 'package:kanji_remake/page/setting_dialog/sync/sync_view_model.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';

class SyncRoute extends HookWidget {
  const SyncRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final syncViewModel = useProvider(syncViewModelProvider);
    final authViewModel = useProvider(authViewModelProvider);
    print("sync:${syncViewModel.ifSync} - user:${authViewModel.ifLoggedIn}");

    late final content;

    if (syncViewModel.ifSync) {
      if (authViewModel.ifLoggedIn) {
        content = SyncPage();
      } else {
        content = AuthRoute();
      }
    } else {
      content = SyncPage();
    }

    // return content;
    return AnimatedSwitcher(
      duration: kDuration,
      child: content,
      switchOutCurve: Curves.easeOutQuart,
      switchInCurve: Curves.easeOutQuart,
      transitionBuilder: (child, animation) {
        final ani2 = Tween<Offset>(
          begin: Offset(1, 0),
          end: Offset(0, 0),
        ).animate(animation);

        return SlideTransition(
          position: ani2,
          child: child,
        );
      },
    );
  }
}
