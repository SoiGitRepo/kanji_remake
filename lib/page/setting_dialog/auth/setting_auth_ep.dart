import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';

import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/page/setting_dialog/auth/auth_viewmodel.dart';
import 'package:kanji_remake/page/setting_dialog/auth/setting_auth_route.dart';
import 'package:kanji_remake/page/setting_dialog/feedback/setting_send_feedback.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';
import 'package:kanji_remake/theme.dart';

class AuthInfoFormPage extends HookWidget {
  const AuthInfoFormPage({Key? key, required this.updateEvent})
      : super(key: key);

  final Function(BuildContext, AuthEvent) updateEvent;
  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);
    final formKey = GlobalKey<FormState>();
    final emailController = useTextEditingController();
    final pswController = useTextEditingController();
    final authEventPro = useProvider(authEventProvider);
    final authViewModel = useProvider(authViewModelProvider);
    final isLoggingin = authEventPro.state == AuthEvent.signIn;
    final loading = useState(false);
    final focuesNode = useFocusNode();

    toggleLoadingState() {
      loading.value = !loading.value;
    }

    onEmailComplete() {
      focuesNode.requestFocus();
    }

    submit() async {
      if (formKey.currentState!.validate()) {
        toggleLoadingState();
        if (isLoggingin) {
          await authViewModel.signIn(emailController.text, pswController.text);
        } else {
          await authViewModel.signUp(emailController.text, pswController.text);
        }
        toggleLoadingState();
      }
    }

    emailValidator(String? text) {
      if (text != null) {
        if (text.isNotEmpty) {
          if (EmailValidator(text).isValidEmail()) {
            return null;
          } else {
            return locale.not_email_error;
          }
        } else {
          return locale.empty_field_error;
        }
      }
      return locale.empty_field_error;
    }

    passwordValidator(String? text) {
      if (text != null) {
        if (text.isEmpty) {
          return locale.empty_field_error;
        } else if (text.length < 8) {
          return locale.psw_short_error;
        }
      } else {
        return locale.empty_field_error;
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("邮箱"),
          SizedBox(
            height: kSmallPaddding,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: loading.value,
            validator: emailValidator,
            controller: emailController,
            cursorColor: kCursorColor,
            textInputAction: TextInputAction.next,
            onEditingComplete: onEmailComplete,
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: kSmallPaddding),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: kSmallPaddding,
          ),
          Text("密码"),
          SizedBox(
            height: kSmallPaddding,
          ),
          TextFormField(
            focusNode: focuesNode,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: loading.value,
            validator: passwordValidator,
            textInputAction: TextInputAction.done,
            onEditingComplete: submit,
            controller: pswController,
            cursorColor: kCursorColor,
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: kSmallPaddding),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: kNormalPaddding,
          ),
          Visibility(
              visible: authViewModel.errorMsg != null,
              child: Padding(
                padding: const EdgeInsets.all(kSmallPaddding),
                child: Center(
                  child: Text(
                    authViewModel.errorMsg ?? "",
                    style: TextStyle(color: Colors.red, fontSize: kSmallText),
                  ),
                ),
              )),
          loading.value
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.all(kSmallPaddding),
                  child: const CircularProgressIndicator(
                    color: kPrymaryColor,
                  ),
                ))
              : ElevatedButton(
                  onPressed: submit,
                  child: Text(isLoggingin ? '登录' : '注册',
                      style: TextStyle(
                          fontSize: kSmallText,
                          fontWeight: FontWeight.normal))),
          isLoggingin
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      // updateEvent(context, AuthEvent.forgetPassword);
                    },
                    child: Text(
                      '忘记密码',
                      style: blueBody1Text.apply(color: Colors.blue),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
