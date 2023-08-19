import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:mdedit/document_manager/document_manager.dart';
import 'package:mdedit/generated/l10n.dart';

class HomeViewModel with ChangeNotifier {
  final DocumentManager _documentManager;
  String previewText = "";
  final _events = StreamController<HomeEvent>.broadcast();
  Stream<HomeEvent> get events => _events.stream.map((val) {
        return val;
      });

  HomeViewModel(this._documentManager) {
    _documentManager.docStream.stream.forEach((event) {
      switch (event) {
        case FileLoaded():
          final newContent = event.document.content;
          _events.add(LoadContent(newContent));
          previewText = newContent;
          notifyListeners();
        case ContentChanged():
          previewText = event.document.content;
          notifyListeners();
      }
    });
  }

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

  onTextChanged(String text) {
    _documentManager.setContent(text);
  }
}

sealed class HomeEvent {}

class LoadContent extends HomeEvent {
  final String text;
  LoadContent(this.text);
}
