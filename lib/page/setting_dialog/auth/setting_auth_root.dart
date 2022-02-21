import 'package:flutter/material.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/page/setting_dialog/auth/setting_auth_route.dart';
import 'package:kanji_remake/theme.dart';

class AuthRootPage extends StatelessWidget {
  const AuthRootPage({
    Key? key,
    required this.updateEvent,
  }) : super(key: key);
  final Function(BuildContext, AuthEvent) updateEvent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "账户",
          style: whiteBody1Text.apply(color: kPrymaryColor),
        ),
        SizedBox(
          height: kSmallPaddding,
        ),
        Text(
          "开始之前，您需要一个账户，创建账户非常简单，完全免费。如果您已经有账户，只需登录即可。",
          style: whiteLable2Text,
        ),
        SizedBox(
          height: kSmallPaddding,
        ),
        ElevatedButton(
            onPressed: () {
              updateEvent(context, AuthEvent.signUp);
            },
            child: Text('创建新账户',
                style: TextStyle(
                    fontSize: kSmallText, fontWeight: FontWeight.normal))),
        ElevatedButton(
            onPressed: () {
              updateEvent(context, AuthEvent.signIn);
            },
            child: Text('登录',
                style: TextStyle(
                    fontSize: kSmallText, fontWeight: FontWeight.normal))),
      ],
    );
  }
}
