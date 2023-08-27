import 'package:file_picker/file_picker.dart';
import 'package:mdedit_api/document_manager/document_manager.dart';
import 'package:mdedit_api/file_saver/file_saver.dart';
import 'package:mdedit_api/generated/l10n.dart';

class DesktopFileSaver extends FileSaver {
  @override
  saveFile(DocumentManager documentManager) async {
    final path = await FilePicker.platform.saveFile(
      dialogTitle: S.current.file_picker_save_as_title,
      type: FileType.any,
      allowedExtensions: ["md"],
      lockParentWindow: true,
    );
    if (path != null) {
      documentManager.saveAs(path);
    }
  }

}

FileSaver getFileSaver() => DesktopFileSaver();