import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextEditorLinux extends StatelessWidget {
  final void Function(String) onTextChanged;

  const TextEditorLinux({super.key, required this.onTextChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: null,
        expands: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: null,
        onChanged: onTextChanged,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        style: GoogleFonts.robotoMono(),
      ),
    );
  }
}
