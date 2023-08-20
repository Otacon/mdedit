import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:mdedit/document_manager/document_manager.dart';
import 'package:mdedit/generated/l10n.dart';
import 'package:window_manager/window_manager.dart';

class HomeViewModel with ChangeNotifier, WindowListener {
  final DocumentManager _documentManager;
  String previewText = "";
  final _events = StreamController<HomeEvent>.broadcast();
  Stream<HomeEvent> get events => _events.stream.map((val) => val);

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

  onTextChanged(String text) {
    _documentManager.setContent(text);
  }

  @override
  onWindowClose() {
    final document = _documentManager.getDocument();
    if (document.hasContentChanged) {
      _events.add(ShowExitDialog());
    } else {
      exit(0);
    }
  }

  void onSaveFileDialogResult(bool? saveFile) async {
    final shouldSave = saveFile ?? false;
    if (!shouldSave) {
      exit(0);
    }
    if (shouldSave) {
      var path = _documentManager.getDocument().path ??
          await FilePicker.platform.saveFile(
            dialogTitle: S.current.file_picker_save_as_title,
            type: FileType.any,
            allowedExtensions: ["md"],
            lockParentWindow: true,
          );
      if (path != null) {
        _documentManager.saveAs(path);
      }
    }
  }
}

sealed class HomeEvent {}

class LoadContent extends HomeEvent {
  final String text;
  LoadContent(this.text);
}

class ShowExitDialog extends HomeEvent {}
