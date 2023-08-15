import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:mdedit/generated/l10n.dart';

class HomeViewModel with ChangeNotifier {

  String text = "";

  onCreate() async {}

  onNewClicked() async {
    FilePicker.platform.saveFile(
      dialogTitle: S.current.file_picker_new_title,
      type: FileType.custom,
      allowedExtensions: ["md"],
      lockParentWindow: true,
    );
  }

  onOpenClicked() async {
    FilePicker.platform.pickFiles(
      dialogTitle: S.current.file_picker_open_title,
      type: FileType.custom,
      allowedExtensions: ["md"],
      lockParentWindow: true,
    );
  }

  onSaveClicked() async {}

  onSaveAsClicked() async {
    FilePicker.platform.saveFile(
      dialogTitle: S.current.file_picker_save_as_title,
      type: FileType.any,
      allowedExtensions: ["md"],
      lockParentWindow: true,
    );
  }

  onExitClicked() async {
    exit(0);
  }

  onTextChanged(String text){
    this.text = text;
    notifyListeners();
  }
}
