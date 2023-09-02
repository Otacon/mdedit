import 'dart:convert';
import 'dart:html' as html;
import 'package:mdedit_api/document_manager/document_manager.dart';
import 'package:mdedit_api/file_saver/file_saver.dart';

class WebFileSaver extends FileSaver {
  @override
  saveFile(DocumentManager documentManager) {
    final document = documentManager.getDocument();
    final text = document.content;
    var path = document.path;
    path ??= "mdedit.md";
    final bytes = utf8.encode(text);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = path;
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

}

FileSaver getFileSaver() => WebFileSaver();