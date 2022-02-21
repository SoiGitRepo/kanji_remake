import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/global_providers.dart';
import 'package:kanji_remake/page/setting_dialog/auth/auth_viewmodel.dart';
import 'package:kanji_remake/page/setting_dialog/auth/setting_auth_ep.dart';
import 'package:kanji_remake/page/setting_dialog/auth/setting_auth_root.dart';
import 'package:kanji_remake/page/setting_dialog/sync/sync_view_model.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';
import 'package:kanji_remake/theme.dart';

final authStateProvider = StateProvider<bool>((ref) {
  final authServices = ref.watch(authServiceProvider);
  if (authServices.user == null) {
    return false;
  } else {
    return true;
  }
});

final authEventProvider = StateProvider<AuthEvent>((ref) {
  return AuthEvent.root;
});

enum AuthEvent {
  root,
  signUp,
  signIn,
  online,
  accountSetting,
  changePassword,
  forgetPassword,
}

class AuthRoute extends HookConsumerWidget {
  const AuthRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authEvent = ref.watch(authEventProvider);
    final authViewMode = ref.watch(authViewModelProvider);

    resetEvent() {
      ref.read(authEventProvider.notifier).state = AuthEvent.root;
      authViewMode.clearErrorText();
    }

    cancelSync() {
      ref.read(syncViewModelProvider.notifier).toggleSyncState(false);
    }

    return MyDialogContainer(
      child: Column(children: [
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              if (authEvent == AuthEvent.root) {
                cancelSync();
              }
              resetEvent();
            },
            child: Text(
              "取消",
              style: blueBody1Text,
            ),
          ),
        ),
        eventToUI(authEvent)
      ]),
    );
  }

  updateEvent(BuildContext context, WidgetRef ref, AuthEvent event) {
    ref.read(authEventProvider.notifier).state = event;
  }

  Widget eventToUI(AuthEvent? event) {
    final authInfoPage = AuthInfoFormPage(updateEvent: updateEvent);
    switch (event) {
      case AuthEvent.signUp:
        return authInfoPage;
      case AuthEvent.signIn:
        return authInfoPage;
      case AuthEvent.accountSetting:
        return authInfoPage;
      case AuthEvent.changePassword:
        return authInfoPage;
      case AuthEvent.forgetPassword:
        return authInfoPage;
      default:
        return AuthRootPage(updateEvent: updateEvent);
    }
  }
}
