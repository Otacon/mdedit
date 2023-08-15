import 'md_nodes.dart';

main() {
  print("Starting...");
  final text =
      "This is a paragraph with **bold text**, *italic text* and `code` text.";
  print("Tokenizing...");
  final tokenizer = Tokenizer();
  tokenizer.parse(text);
}

class Tokenizer {
  final tokens = <Token>[];
  final finalGroup = <Token>[];
  final currentGroup = <Token>[];
  final nodes = <Node>[];
  String accum = "";

  List<Node> parse(String text) {
    _tokenize(text);
    print(tokens);
    _normalize();
    print(finalGroup);
    _createNodes();
    print(nodes);
    return [];
  }

  _tokenize(String text) {
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      switch (char) {
        case "*":
          _createWord();
          bool isBold = text.substring(i + 1).startsWith("*");
          if (isBold) {
            i++;
            tokens.add(TokenBold());
          } else {
            tokens.add(TokenItalic());
          }
        case "`":
          _createWord();
          tokens.add(TokenCode());
        case " ":
          _createWord();
          tokens.add(TokenSpace());
        default:
          accum += char;
      }
    }
    _createWord();
    accum = "";
  }

  _normalize() {
    for (int i = 0; i < tokens.length; i++) {
      final currentToken = tokens[i];
      switch (currentToken) {
        case TokenWord():
        case TokenSpace():
          currentGroup.add(currentToken);
        case TokenBold():
        case TokenItalic():
        case TokenCode():
          _groupTokens(currentToken, tokens.sublist(i));
      }
    }
    finalGroup.addAll(currentGroup);
    return finalGroup;
  }

  _createNodes() {
    Node currentNode = TextNode("", []);
    for (int i = 0; i < tokens.length; i++) {
      final currentToken = tokens[i];
      switch (currentToken) {
        case TokenWord():
          currentNode.text += currentToken.text;
        case TokenSpace():
          currentNode.text += " ";
        case TokenBold():
          nodes.add(currentNode);
          if (currentNode is! BoldNode) {
            currentNode = BoldNode("", []);
          } else {
            currentNode = TextNode("", []);
          }
        case TokenItalic():
          nodes.add(currentNode);
          if (currentNode is! ItalicNode) {
            currentNode = ItalicNode("", []);
          } else {
            currentNode = TextNode("", []);
          }
        case TokenCode():
          nodes.add(currentNode);
          if (currentNode is! CodeNode) {
            currentNode = CodeNode("", []);
          } else {
            currentNode = TextNode("", []);
          }
      }
    }
    nodes.add(currentNode);
  }

  _createWord() {
    if (accum.isNotEmpty) {
      tokens.add(TokenWord(accum));
      accum = "";
    }
  }

  _groupTokens<T extends Token>(T currentToken, List<Token> tokens) {
    if (tokens.length == 1) {
      currentGroup.add(currentToken);
      return;
    }
    final italicEndIndex = _findNextMatchingToken<TokenCode>(tokens);
    if (italicEndIndex == null) {
      currentGroup.add(currentToken);
      return;
    }
    finalGroup.addAll(currentGroup);
    currentGroup.clear();
    finalGroup.addAll(tokens.sublist(0, italicEndIndex));
  }

  int? _findNextMatchingToken<T extends Token>(List<Token> tokens) {
    final index = tokens.indexWhere((element) => element is T);
    if (index < 0) {
      return null;
    }
    return index;
  }
}

/*
[
  T:"This is a paragraph with",
  B:"Bold",
  T:", ",
  I:"italic",
  T:" and ",
  C:"code",
  T:" text.",
]
 */

sealed class Token {}

class TokenWord extends Token {
  final String text;

  TokenWord(this.text);

  @override
  String toString() {
    return 'Word($text)';
  }
}

class TokenSpace extends Token {
  @override
  String toString() {
    return 'Space';
  }
}

class TokenBold extends Token {
  @override
  String toString() {
    return 'Bold';
  }
}

class TokenItalic extends Token {
  @override
  String toString() {
    return 'Italic';
  }
}

class TokenCode extends Token {
  @override
  String toString() {
    return 'Code';
  }
}
