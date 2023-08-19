import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:mdedit/document_manager/document_manager.dart';
import 'package:mdedit/generated/l10n.dart';

class ToolbarViewModel with ChangeNotifier {
  final DocumentManager _documentManager;
  final _events = StreamController<ToolbarEvent>.broadcast();
  Stream<ToolbarEvent> get events => _events.stream.map((val) =>val);

  var isSaveEnabled = false;

  ToolbarViewModel(this._documentManager) {
    _documentManager.docStream.stream.forEach((event) {
      final document = switch (event) {
        FileLoaded() => event.document,
        ContentChanged() => event.document,
      };
      isSaveEnabled = document.hasContentChanged;
      notifyListeners();
    });
  }

  onNewClicked() async {
    FilePicker.platform.saveFile(
      dialogTitle: S.current.file_picker_new_title,
      type: FileType.custom,
      allowedExtensions: ["md"],
      lockParentWindow: true,
    );
  }

  onOpenClicked() async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: S.current.file_picker_open_title,
      type: FileType.custom,
      allowedExtensions: ["md"],
      lockParentWindow: true,
    );
    if (result != null) {
      final path = result.files.single.path;
      if (path != null) {
        _documentManager.loadFrom(path);
      }
    }
  }

  onSaveClicked() async {
    final document = _documentManager.getDocument();
    final path = document.path;
    if(path == null){
      onSaveAsClicked();
      return;
    }
    _documentManager.saveAs(path);
  }

  onSaveAsClicked() async {
    final path = await FilePicker.platform.saveFile(
      dialogTitle: S.current.file_picker_save_as_title,
      type: FileType.any,
      allowedExtensions: ["md"],
      lockParentWindow: true,
    );
    if (path != null) {
      _documentManager.saveAs(path);
    }
  }

  onExitClicked() async {
    exit(0);
  }
}

sealed class ToolbarEvent {}

class LoadContent extends ToolbarEvent {
  final String text;
  LoadContent(this.text);
}
