import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/page/setting_dialog/auth/auth_viewmodel.dart';
import 'package:kanji_remake/page/setting_dialog/auth/setting_account/setting_account.dart';
import 'package:kanji_remake/page/setting_dialog/auth/setting_auth_route.dart';
import 'package:kanji_remake/page/setting_dialog/sync/sync_view_model.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';
import 'package:kanji_remake/theme.dart';

class SyncPage extends HookConsumerWidget {
  const SyncPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _syncViewModel = ref.watch(syncViewModelProvider);
    final _authViewModel = ref.watch(authViewModelProvider);
    final authEventPro = ref.read(authEventProvider.notifier);
    final ifSync = _syncViewModel.ifSync && _authViewModel.user != null;

    void popThisPageOut() {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }

    resetAuthEvent() {
      authEventPro.state = AuthEvent.root;
    }

    List<Widget> syncOnToShow(BuildContext context, Size size) {
      return [
        Text(_authViewModel.email ?? ""),
        Text('已开启云同步', style: whiteLable2Text),
        Text(
          '上次更新时间：今天，下午8:24',
          style: whiteLable2Text,
        ),
        SizedBox(
          height: kBigPaddding,
        ),
        GestureDetector(
            onTap: () {
              showAccountSettingDialog(context);
            },
            child: simpleListTile("编辑帐户", Icons.account_box_rounded)),
      ];
    }

    final size = MediaQuery.of(context).size;
    return MyDialogContainer(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: popThisPageOut,
              child: Text(
                "完成",
                style: blueBody1Text,
              ),
            ),
          ),
          Text(
            "数据云同步",
            style: whiteBody1Text.apply(color: kPrymaryColor),
          ),
          SizedBox(
            height: kNormalPaddding,
          ),
          AnimatedCrossFade(
              firstChild: Icon(
                Icons.cloud_done_rounded,
                color: kPrymaryColor,
                size: kBigButtonHeight,
              ),
              secondChild: Icon(
                Icons.cloud_queue_rounded,
                color: kPrymaryColor,
                size: kBigButtonHeight,
              ),
              crossFadeState:
                  ifSync ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: kFastDuration),
          Switch(
            value: ifSync,
            onChanged: (value) {
              _syncViewModel.toggleSyncState(value);
              if (value) {
                resetAuthEvent();
              } else {
                _authViewModel.signOut();
              }
            },
            activeColor: kPrymaryColor,
          ),
          SizedBox(
            height: kNormalPaddding,
          ),
          AnimatedCrossFade(
              sizeCurve: Curves.easeOutCubic,
              firstChild: Column(children: syncOnToShow(context, size)),
              secondChild: Column(children: syncOffToShow()),
              crossFadeState:
                  ifSync ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: kFastDuration),
        ],
      ),
    );
  }

  showAccountSettingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (
          context,
        ) {
          return AccountSetting();
        });
  }

  simpleListTile(
    String title,
    IconData icon,
  ) {
    return Container(
      color: kDialogBgColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kSmallPaddding / 2),
            child: Icon(
              Icons.account_box_rounded,
              color: kPrymaryColor,
            ),
          ),
          SizedBox(
            width: kSmallPaddding,
          ),
          Text(
            '编辑账户',
            style: blueBody1Text,
          ),
          Spacer(),
          Icon(
            Icons.chevron_right_rounded,
            color: kPrymaryColor,
          ),
        ],
      ),
    );
  }

  List<Widget> syncOffToShow() {
    return [
      Text(
        '储存您的学习进度，在多个设备间随意切换。',
        style: blueBody1Text.copyWith(fontWeight: FontWeight.normal),
      ),
      SizedBox(
        height: kSmallPaddding,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Text(
          '了解详情',
          style: whiteBody2Text.copyWith(
              color: Colors.blue, fontWeight: FontWeight.normal),
        ),
      )
    ];
  }
}
