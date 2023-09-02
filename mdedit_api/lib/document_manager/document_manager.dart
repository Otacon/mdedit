import 'dart:async';
import 'dart:io';
import 'package:mdedit_api/document_manager/document.dart';

class DocumentManager {
  var _document = Document(null, "", false);
  Document? _originalDocument;

  final docStream = StreamController<DocumentEvent>.broadcast();

  DocumentManager();

  loadFrom(String name, content) async {
    _document = Document(name, content, false);
    _originalDocument = _document;
    docStream.add(FileLoaded(_document));
  }

  saveAs(String path) async {
    try {
      final file = File(path);
      await file.writeAsString(_document.content);
      _document = Document(path, _document.content, false);
      docStream.add(ContentChanged(_document));
    } catch (e) {
      return 0;
    }
  }

  setDocument(Document document) async {
    _document = document;
    _originalDocument = document;
    _notifyObservers();
  }

  setContent(String content) async {
    bool isContentChanged = _originalDocument?.content != content;
    _document = Document(_document.path, content, isContentChanged);
    _notifyObservers();
  }

  Document getDocument() {
    return _document;
  }

  _notifyObservers() {
    docStream.add(ContentChanged(_document));
  }
}

sealed class DocumentEvent {}

class FileLoaded extends DocumentEvent {
  final Document document;

  FileLoaded(this.document);
}

class ContentChanged extends DocumentEvent {
  final Document document;

  ContentChanged(this.document);
}
