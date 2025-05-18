class Rule {
  final String leftSide;
  final List<String> rightSide;

  Rule(this.leftSide, this.rightSide);

  @override
  String toString() {
    return '$leftSide -> ${rightSide.join(' ')}';
  }
}

class CNFGrammar {
  final List<Rule> rules;
  final String startSymbol;

  CNFGrammar(this.rules, this.startSymbol);

  List<Rule> getRulesForVariable(String variable) {
    return rules.where((rule) => rule.leftSide == variable).toList();
  }
}

bool belongsToLanguage(CNFGrammar grammar, String inputString) {
  if (inputString.isEmpty) {
    return grammar.rules.any((rule) =>
        rule.leftSide == grammar.startSymbol &&
        rule.rightSide.length == 1 &&
        rule.rightSide[0] == 'ε');
  }

  int n = inputString.length;

  List<List<Set<String>>> dp = List.generate(
      n, (i) => List.generate(n, (j) => <String>{}, growable: false),
      growable: false);

  for (int i = 0; i < n; i++) {
    String currentChar = inputString[i];
    for (Rule rule in grammar.rules) {
      if (rule.rightSide.length == 1 && rule.rightSide[0] == currentChar) {
        dp[0][i].add(rule.leftSide);
      }
    }
  }

  for (int l = 2; l <= n; l++) {
    for (int i = 0; i <= n - l; i++) {
      int j = i + l - 1;
      for (int k = i; k < j; k++) {
        for (Rule rule in grammar.rules) {
          if (rule.rightSide.length == 2) {
            String B = rule.rightSide[0];
            String C = rule.rightSide[1];

            if (dp[k - i][i].contains(B) && dp[j - (k + 1)][k + 1].contains(C)) {
              dp[l - 1][i].add(rule.leftSide);
            }
          }
        }
      }
    }
  }

  return dp[n - 1][0].contains(grammar.startSymbol);
}

void main() {
  List<Rule> rules = [
    Rule('S', ['A', 'B']),
    Rule('S', ['B', 'C']),
    Rule('A', ['B', 'A']),
    Rule('A', ['a']),
    Rule('B', ['C', 'C']),
    Rule('B', ['b']),
    Rule('C', ['A', 'B']),
    Rule('C', ['c']),
  ];

  CNFGrammar grammar = CNFGrammar(rules, 'S');

  List<String> testStrings = ['ab', 'abc', 'abbc', 'aabbc', 'aabbcc'];

  for (String str in testStrings) {
    bool result = belongsToLanguage(grammar, str);
    print('$str ${result ? 'belongs' : 'does not belong'} to the language');
  }
}

class CYKParser {
  final CNFGrammar grammar;

  CYKParser(this.grammar);

  bool parse(String input) {
    int n = input.length;
    if (n == 0) {
      return grammar.rules.any((rule) =>
          rule.leftSide == grammar.startSymbol &&
          rule.rightSide.length == 1 &&
          rule.rightSide[0] == 'ε');
    }

    List<List<Set<String>>> table = List.generate(
      n,
      (i) => List.generate(n, (j) => <String>{}, growable: false),
    );

    for (int i = 0; i < n; i++) {
      for (Rule rule in grammar.rules) {
        if (rule.rightSide.length == 1 && rule.rightSide[0] == input[i]) {
          table[0][i].add(rule.leftSide);
        }
      }
    }

    for (int length = 1; length < n; length++) {
      for (int start = 0; start < n - length; start++) {
        for (int split = 0; split < length; split++) {
          int leftLength = split;
          int rightLength = length - split - 1;
          int rightStart = start + split + 1;

          for (Rule rule in grammar.rules) {
            if (rule.rightSide.length == 2) {
              String left = rule.rightSide[0];
              String right = rule.rightSide[1];

              if (table[leftLength][start].contains(left) &&
                  table[rightLength][rightStart].contains(right)) {
                table[length][start].add(rule.leftSide);
              }
            }
          }
        }
      }
    }

    return table[n - 1][0].contains(grammar.startSymbol);
  }
}

void mainEnhanced() {
  List<Rule> rules = [
    Rule('S', ['A', 'B']),
    Rule('S', ['B', 'C']),
    Rule('A', ['B', 'A']),
    Rule('A', ['a']),
    Rule('B', ['C', 'C']),
    Rule('B', ['b']),
    Rule('C', ['A', 'B']),
    Rule('C', ['c']),
  ];

  CNFGrammar grammar = CNFGrammar(rules, 'S');
  CYKParser parser = CYKParser(grammar);

  List<String> testStrings = ['ab', 'abc', 'abbc', 'aabbc', 'aabbcc'];

  for (String str in testStrings) {
    bool result = parser.parse(str);
    print('$str ${result ? 'ينتمي' : 'لا ينتمي'} إلى اللغة');
  }
}