
import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class TextEditorWindows extends StatelessWidget {
  final void Function(String) onTextChanged;

  const TextEditorWindows({super.key, required this.onTextChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextBox(
        decoration: null,
        expands: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: null,
        onChanged: onTextChanged,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        style: GoogleFonts.notoSansMono(),
      ),
    );
  }
}
