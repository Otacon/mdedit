import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class TextEditorWindows extends StatelessWidget {
  final void Function(String) onTextChanged;
  final TextEditingController? controller;

  const TextEditorWindows(
      {super.key, required this.onTextChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextBox(
      controller: controller,
      decoration: null,
      expands: true,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: null,
      onChanged: onTextChanged,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      style: GoogleFonts.notoSansMono(),
    );
  }
}
