import 'md_nodes.dart';

main() {
  print("Starting...");
  final text =
      "This is a paragraph with **bold ~~_italic_~~ text**, *italic text* and `code` text.";
  final parser = MarkdownParser();
  final nodes = parser.parse(text);
  print(nodes);
}

class MarkdownParser {
  MarkdownParser();

  List<Node> parse(String input) {
    final buffer = StringBuffer(input);
    return _parseText(buffer);
  }

  List<Node> _parseText(StringBuffer buffer) {
    final nodeBuilder = NodeBuilder();
    while (buffer.hasMore()) {
      final char = buffer.currentChar();
      switch (char) {
        case "*":
        case "_":
          final repetitions = buffer.repetitionsOfCurrentChar();
          if (repetitions == 1) {
            nodeBuilder.pushType(NodeType.italic);
            buffer.advanceBy(1);
          } else if (repetitions == 2) {
            nodeBuilder.pushType(NodeType.bold);
            buffer.advanceBy(2);
          } else {
            nodeBuilder.pushText(char);
            buffer.advanceBy(1);
          }
        case "~":
          final repetitions = buffer.repetitionsOfCurrentChar();
          if (repetitions == 2) {
            nodeBuilder.pushType(NodeType.strikethrough);
            buffer.advanceBy(2);
          } else {
            nodeBuilder.pushText(char);
            buffer.advanceBy(1);
          }
        case "`":
          nodeBuilder.pushType(NodeType.code);
          buffer.advanceBy(1);
        default:
          nodeBuilder.pushText(char);
          buffer.advanceBy(1);
      }
    }
    nodeBuilder.flush();
    return nodeBuilder._nodes;
  }
}

class NodeBuilder {
  String _text = "";
  final List<NodeType> _nodeType = [NodeType.text];
  final List<Node> _nodes = [];

  void pushText(String text) {
    _text += text;
  }

  void pushType(NodeType type) {
    flush();
    final lastNodeType = _nodeType.last;
    if (lastNodeType != type) {
      _text = "";
      _nodeType.add(type);
    } else {
      _text = "";
      _nodeType.removeLast();
    }
  }

  void flush() {
    final lastNodeType = _nodeType.last;
    final node = switch (lastNodeType) {
      NodeType.text => TextNode(_text, []),
      NodeType.bold => BoldNode(_text, []),
      NodeType.italic => ItalicNode(_text, []),
      NodeType.code => CodeNode(_text, []),
      NodeType.strikethrough => StrikeThroughNode(_text, [])
    };
    _nodes.add(node);
  }
}

enum NodeType { text, bold, italic, code, strikethrough }

class StringBuffer {
  final String _input;
  int _position = 0;

  StringBuffer(this._input);

  void advanceBy(int positions) {
    final newPosition = _position + positions;
    _position = newPosition;
  }

  int repetitionsOfCurrentChar() {
    final char = _input[_position];
    int offset = _position + 1;
    int repetitions = 1;
    while (offset < _input.length && char == _input[offset]) {
      repetitions++;
      offset++;
    }
    return repetitions;
  }

  String currentChar() {
    return _input[_position];
  }

  bool hasMore() {
    return _position < _input.length;
  }
}
