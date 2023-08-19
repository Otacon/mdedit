import 'dart:async';
import 'dart:io';

import 'package:mdedit/document_manager/document.dart';

class DocumentManager {
  
  var _document = Document(null, null, "", false);
  Document? _originalDocument;

  final docStream = StreamController<DocumentEvent>.broadcast();

  DocumentManager();

  loadFrom(String fullPath) async {
    try {
    final file = File(fullPath);
    final content = await file.readAsString();
    final fileName = file.path.split(Platform.pathSeparator).last;
    _document = Document(fileName, file.parent.path, content, false);
    _originalDocument = _document;
    docStream.add(FileLoaded(_document));
  } catch (e) {
    return 0;
  }
  }

  saveTo(String file, String path) async {
    //TODO write file
  }

  saveAs(String file, String path) async {

  }

  setDocument(Document document) async {
    _document = document;
    _originalDocument = document;
    _notifyObservers();
  }

  setContent(String content) async {
    bool isContentChanged = _originalDocument?.content != content;
    _document = Document(_document.name, _document.path, content, isContentChanged);
    _notifyObservers();
  }

  //TODO probably URI is better
  setFile(String file, String path) async {
    _document = Document(file, path, _document.content, false);
    _notifyObservers();
  }

  _notifyObservers() {
    docStream.add(ContentChanged(_document));
  }

}

sealed class DocumentEvent{

}

class FileLoaded extends DocumentEvent{
  final Document document;
  FileLoaded(this.document);
}

class ContentChanged extends DocumentEvent {
  final Document document;
  ContentChanged(this.document);
}
