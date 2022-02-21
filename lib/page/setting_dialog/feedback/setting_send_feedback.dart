import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';

class SendFeedBackPage extends HookWidget {
  const SendFeedBackPage({Key? key}) : super(key: key);

  saveEditState({required BuildContext context, String? email, String? msg}) {
    saveEmailState(context: context, email: email ?? "");
    saveMsgState(context: context, msg: msg ?? "");
  }

  saveEmailState({
    required BuildContext context,
    required String email,
  }) {
    context.read(feedBackEmailProvider).state = email;
  }

  saveMsgState({
    required BuildContext context,
    required String msg,
  }) {
    context.read(feedBackMsgProvider).state = msg;
  }

  clearEditState({required BuildContext context}) {
    context.read(feedBackEmailProvider).state = "";
    context.read(feedBackMsgProvider).state = "";
  }

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);
    final emailProvider = useProvider(feedBackEmailProvider);
    final msgProvider = useProvider(feedBackMsgProvider);
    final emailController = useTextEditingController();
    final msgController = useTextEditingController();
    final formKey = GlobalKey<FormState>();
    final checkingIfSaveState = useState(false);
    emailController.text = emailProvider.state;
    msgController.text = msgProvider.state;

    return MyDialogContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: kFastDuration,
            curve: Curves.easeInCubic,
            padding: EdgeInsets.symmetric(horizontal: kSmallPaddding),
            margin: EdgeInsets.only(bottom: kSmallPaddding),
            decoration: BoxDecoration(
                color: checkingIfSaveState.value
                    ? kRadioGroupColor
                    : kDialogBgColor,
                borderRadius: BorderRadius.circular(
                  kSmallRadius,
                )),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedContainer(
                      height: checkingIfSaveState.value ? 20 : 0,
                      duration: kFastDuration,
                      curve: Curves.easeInCubic,
                      child: FittedBox(child: Text(locale.ask_save_edit)),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.close_rounded,
                        color: kPrymaryColor,
                      ),
                      onTap: () {
                        if (emailController.text.isNotEmpty ||
                            msgController.text.isNotEmpty) {
                          saveEditState(
                            context: context,
                            email: emailController.text,
                            msg: msgController.text,
                          );
                          checkingIfSaveState.value =
                              !checkingIfSaveState.value;
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
                AnimatedContainer(
                    height: checkingIfSaveState.value ? 50 : 0,
                    curve: Curves.easeInCubic,
                    duration: kFastDuration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: MyOutlineTextButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          text: locale.save,
                          color: kPrymaryColor,
                          textColor: Colors.white,
                        )),
                        SizedBox(
                          width: kSmallPaddding,
                        ),
                        Expanded(
                            child: MyOutlineTextButton(
                          onTap: () {
                            clearEditState(context: context);
                            Navigator.pop(context);
                          },
                          text: locale.dont_save,
                          color: Colors.red,
                          textColor: Colors.white,
                        )),
                      ],
                    )),
              ],
            ),
          ),
          Text(locale.your_email_address),
          Text('${locale.optional}:'),
          SizedBox(
            height: kSmallPaddding,
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty || text.isValidEmail()) {
                      return null;
                    }
                    ;
                    return locale.not_email_error;
                  },
                  onChanged: (text) {
                    if (text.isNotEmpty) formKey.currentState!.validate();
                  },
                  controller: emailController,
                  cursorColor: kCursorColor,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: kSmallPaddding),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: kSmallPaddding,
                ),
                Text('${locale.message}:'),
                SizedBox(
                  height: kSmallPaddding,
                ),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return locale.empty_field_error;
                    }
                    return null;
                  },
                  onChanged: (text) {
                    if (text.isNotEmpty) formKey.currentState!.validate();
                  },
                  controller: msgController,
                  cursorColor: kCursorColor,
                  maxLines: 8,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(kSmallPaddding),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: kNormalPaddding,
          ),
          MyOutlineTextButton(
              onTap: () {
                formKey.currentState!.validate();
              },
              text: locale.send),
          Text(
            locale.feedback_note,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

final feedBackEmailProvider = StateProvider((ref) => "");
final feedBackMsgProvider = StateProvider((ref) => "");
final feedBackIfSaveStateProvider = StateProvider((ref) => false);
