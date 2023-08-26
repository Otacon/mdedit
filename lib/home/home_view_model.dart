import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:mdedit/document_manager/document_manager.dart';
import 'package:mdedit/file_saver/file_saver.dart';
import 'package:mdedit/generated/l10n.dart';
import 'package:window_manager/window_manager.dart';

class HomeViewModel with ChangeNotifier, WindowListener {
  final DocumentManager _documentManager;
  final FileSaver _fileSaver;
  final _events = StreamController<HomeEvent>.broadcast();

  Stream<HomeEvent> get events => _events.stream.map((val) => val);

  var previewText = "";
  var isSaveEnabled = false;

  HomeViewModel(this._documentManager, this._fileSaver) {
    _documentManager.docStream.stream.forEach((event) {
      switch (event) {
        case FileLoaded():
          final document = event.document;
          isSaveEnabled = document.hasContentChanged;
          previewText = document.content;
          _events.add(LoadContent(document.content));
        case ContentChanged():
          final document = event.document;
          previewText = document.content;
          isSaveEnabled = document.hasContentChanged;
      }
      notifyListeners();
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
      withData: true,
      lockParentWindow: true,
    );
    if (result != null) {
      final bytes = result.files.single.bytes;
      if (bytes != null) {
        final content = String.fromCharCodes(bytes);
        final name = result.files.single.name;
        _documentManager.loadFrom(name, content);
      }
    }
  }

  onSaveClicked() async {
    final document = _documentManager.getDocument();
    final path = document.path;
    if (path == null) {
      onSaveAsClicked();
      return;
    }
    _documentManager.saveAs(path);
  }

  onSaveAsClicked() async {
    _fileSaver.saveFile(_documentManager);
  }

  onExitClicked() async {
    exit(0);
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
