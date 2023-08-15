abstract class Node {
  String text;
  List<Node> children;

  Node(this.text, this.children);

}

class ParagraphNode extends Node {
  ParagraphNode(super.text, super.children);
}

class BoldNode extends Node {
  BoldNode(super.text, super.children);

  @override
  String toString() {
    return 'BoldNode{${super.text}}';
  }
}

class ItalicNode extends Node {
  ItalicNode(super.text, super.children);

  @override
  String toString() {
    return 'ItalicNode{${super.text}}';
  }
}

class CodeNode extends Node {
  CodeNode(super.text, super.children);

  @override
  String toString() {
    return 'CodeNode{${super.text}}';
  }
}


class StrikeThroughNode extends Node {
  StrikeThroughNode(super.text, super.children);

  @override
  String toString() {
    return 'StrikeThroughNode{${super.text}}';
  }
}

class TextNode extends Node {
  TextNode(super.text, super.children);

  @override
  String toString() {
    return 'TextNode{${super.text}}';
  }
}
