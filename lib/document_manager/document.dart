class Document {
  final String? _path;
  final String _content;
  final bool _hasContentChanged;

  Document(
    this._path,
    this._content,
    this._hasContentChanged
  );

  String? get path => _path;
  String get content => _content;
  bool get hasContentChanged => _hasContentChanged;

  @override
  String toString() => 'Document(_path: $_path, _content: $_content, _hasContentChanged: $_hasContentChanged)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Document &&
      other._path == _path &&
      other._content == _content;
  }

  @override
  int get hashCode => _path.hashCode ^ _content.hashCode;
}
