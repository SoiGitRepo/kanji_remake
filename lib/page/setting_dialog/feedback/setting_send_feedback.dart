import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kanji_remake/colors.dart';
import 'package:kanji_remake/constant.dart';
import 'package:kanji_remake/generated/l10n.dart';
import 'package:kanji_remake/page/widgets/wedgets.dart';

class SendFeedBackPage extends HookConsumerWidget {
  const SendFeedBackPage({Key? key}) : super(key: key);

  saveEditState({required WidgetRef ref, String? email, String? msg}) {
    saveEmailState(ref: ref, email: email ?? "");
    saveMsgState(ref: ref, msg: msg ?? "");
  }

  saveEmailState({
    required WidgetRef ref,
    required String email,
  }) {
    ref.read(feedBackEmailProvider.notifier).state = email;
  }

  saveMsgState({
    required WidgetRef ref,
    required String msg,
  }) {
    ref.read(feedBackMsgProvider.notifier).state = msg;
  }

  clearEditState({required WidgetRef ref}) {
    ref.read(feedBackEmailProvider.notifier).state = "";
    ref.read(feedBackMsgProvider.notifier).state = "";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = S.of(context);
    final emailProvider = ref.watch(feedBackEmailProvider);
    final msgProvider = ref.watch(feedBackMsgProvider);
    final emailController = useTextEditingController();
    final msgController = useTextEditingController();
    final formKey = GlobalKey<FormState>();
    final checkingIfSaveState = useState(false);
    emailController.text = emailProvider;
    msgController.text = msgProvider;

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
                            ref: ref,
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
                            clearEditState(ref: ref);
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
