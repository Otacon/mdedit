

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macos_ui/macos_ui.dart';

class TextEditorMacos extends StatelessWidget {
  final void Function(String) onTextChanged;

  const TextEditorMacos({super.key, required this.onTextChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MacosTextField.borderless(
        decoration: null,
        expands: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: null,
        onChanged: onTextChanged,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        style: GoogleFonts.spaceMono(),
      ),
    );
  }
}
