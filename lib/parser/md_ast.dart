import 'package:markdown/markdown.dart';

main() {
  final document = Document();
  final nodes = document.parse("This is a paragraph\n```This is some sample code```\n*Something _else_*");
  for (final node in nodes) {
    visitNode(node);
  }
}

void visitNode(final Node node) {
  if (node is Text) {
    visitText(node);
  } else if (node is Element) {
    visitElement(node);
  } else {
    throw UnsupportedError("Unsupported Node $node");
  }
}

void visitElement(final Element element){
  final children = element.children;
  final text = element.textContent;
  print("Element: $text");
  if(children == null){
    return;
  }
  for(final child in children){
    visitNode(child);
  }
}

void visitText(final Text text){
  print("Text: ${text.text}");
}
