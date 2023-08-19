class Document {
  final String? _name;
  final String? _path;
  final String _content;
  final bool _hasContentChanged;

  Document(
    this._name,
    this._path,
    this._content,
    this._hasContentChanged
  );

  String? get name => _name;
  String? get path => _path;
  String get content => _content;
  bool get hasContentChanged => _hasContentChanged;

  @override
  String toString() => 'Document(_name: $_name, _path: $_path, _content: $_content)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Document &&
      other._name == _name &&
      other._path == _path &&
      other._content == _content;
  }

  @override
  int get hashCode => _name.hashCode ^ _path.hashCode ^ _content.hashCode;
}
