import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:mdedit/document_manager/document_manager.dart';

class HomeViewModel with ChangeNotifier {
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
}

sealed class HomeEvent {}

class LoadContent extends HomeEvent {
  final String text;
  LoadContent(this.text);
}
