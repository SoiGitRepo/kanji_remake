// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "custom_review": MessageLookupByLibrary.simpleMessage("Custom Review"),
        "jlpt": MessageLookupByLibrary.simpleMessage("JLPT"),
        "learned": MessageLookupByLibrary.simpleMessage("Learned"),
        "level": MessageLookupByLibrary.simpleMessage("Level"),
        "memorize_this_word":
            MessageLookupByLibrary.simpleMessage("Memorize This Word..."),
        "need_review": MessageLookupByLibrary.simpleMessage("Need Review"),
        "ready_to_learn":
            MessageLookupByLibrary.simpleMessage("Ready To Learn"),
        "review": MessageLookupByLibrary.simpleMessage("Review Past Due"),
        "select_kanji":
            MessageLookupByLibrary.simpleMessage("Select the kanji..."),
        "which_is": MessageLookupByLibrary.simpleMessage("Which of this is...")
      };
}
