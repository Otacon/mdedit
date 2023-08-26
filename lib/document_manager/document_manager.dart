import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mdedit/document_manager/document.dart';

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
    if(kIsWeb) {
      final text = _document.content;
      final bytes = utf8.encode(text);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = _document.path;
      html.document.body?.children.add(anchor);
      anchor.click();
      html.document.body?.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
    } else {
      try {
        final file = File(path);
        await file.writeAsString(_document.content);
        _document = Document(path, _document.content, false);
        docStream.add(ContentChanged(_document));
      } catch (e) {
        return 0;
      }
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
