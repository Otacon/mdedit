// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "app_name": MessageLookupByLibrary.simpleMessage("Markdown Edit"),
        "file_picker_new_title":
            MessageLookupByLibrary.simpleMessage("Create new file"),
        "file_picker_open_title":
            MessageLookupByLibrary.simpleMessage("Open file"),
        "file_picker_save_as_title":
            MessageLookupByLibrary.simpleMessage("Save file"),
        "menu_file": MessageLookupByLibrary.simpleMessage("File"),
        "menu_file_exit": MessageLookupByLibrary.simpleMessage("Exit"),
        "menu_file_new": MessageLookupByLibrary.simpleMessage("New"),
        "menu_file_open": MessageLookupByLibrary.simpleMessage("Open"),
        "menu_file_save": MessageLookupByLibrary.simpleMessage("Save"),
        "menu_file_save_as": MessageLookupByLibrary.simpleMessage("Save as...")
      };
}
