import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';
import 'package:kanji_remake/theme.dart';

class AccountSetting extends HookWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void popThisPageOut() {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }

    final _viewmodel = useProvider(_accountSettingViewModelProvider);
    return MyDialogContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Align(
            alignment: Alignment.center,
            child: Text(
              "帐户",
              style: whiteBody1Text.apply(color: kPrymaryColor),
            ),
          ),
          Text(
            '编辑帐户',
            style: TextStyle(fontSize: kSmallText),
          ),
          Divider(
            color: Colors.grey,
          ),
          Text(
            '请注意，更改密码将意味着所有设备将必须重新开启同步并同步数据。',
            style:
                TextStyle(fontSize: kSmallText, fontWeight: FontWeight.normal),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kSmallPaddding),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                '更改昵称',
                style: TextStyle(
                    fontSize: kSmallText, fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Text(
            '请注意，更改密码将意味着所有设备将必须重新开启同步并同步数据。',
            style:
                TextStyle(fontSize: kSmallText, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: kSmallPaddding,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              '更改密码',
              style: TextStyle(
                  fontSize: kSmallText, fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(
            height: kBigPaddding,
          ),
          Text(
            '编辑帐户',
            style: TextStyle(fontSize: kSmallText),
          ),
          Divider(
            color: Colors.grey,
          ),
          Text(
            '如果删除帐户，则云端中所有的进度将被删除，所有设备将停止相互更新，然而，每台设备将保留当前拥有的学习进度。',
            style:
                TextStyle(fontSize: kSmallText, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: kSmallPaddding,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () {},
            child: Text(
              '删除帐户',
              style: TextStyle(
                  fontSize: kSmallText, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}

final _accountSettingViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) {
  return AccountSettingViewModelImpl();
});

abstract class AccountSettingViewModel extends ChangeNotifier {
  changePsw();
  changeDisplayName();
  deleteAccount();
}

class AccountSettingViewModelImpl extends AccountSettingViewModel {
  @override
  changeDisplayName() {
    // TODO: implement changeDisplayName
    throw UnimplementedError();
  }

  @override
  changePsw() {
    // TODO: implement changePsw
    throw UnimplementedError();
  }

  @override
  deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }
}
