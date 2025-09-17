import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';
import 'package:kanji_remake/theme.dart';
import 'package:go_router/go_router.dart';

class AccountSetting extends HookConsumerWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void popThisPageOut(BuildContext context) {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/lesson');
      }
    }

    return MyDialogContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => popThisPageOut(context),
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
            style: TextStyle(fontSize: kSmallText, fontWeight: FontWeight.normal),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kSmallPaddding),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                '更改昵称',
                style: TextStyle(fontSize: kSmallText, fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Text(
            '请注意，更改密码将意味着所有设备将必须重新开启同步并同步数据。',
            style: TextStyle(fontSize: kSmallText, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: kSmallPaddding,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              '更改密码',
              style: TextStyle(fontSize: kSmallText, fontWeight: FontWeight.normal),
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
            style: TextStyle(fontSize: kSmallText, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: kSmallPaddding,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {},
            child: Text(
              '删除帐户',
              style: TextStyle(fontSize: kSmallText, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
