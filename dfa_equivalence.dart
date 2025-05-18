class DFA {
  final Set<int> states;
  final Set<String> alphabet;
  final Map<int, Map<String, int>> transitions;
  final int initialState;
  final Set<int> acceptingStates;

  DFA({
    required this.states,
    required this.alphabet,
    required this.transitions,
    required this.initialState,
    required this.acceptingStates,
  });
}

bool areEquivalent(DFA dfa1, DFA dfa2) {
  if (!_sameAlphabet(dfa1, dfa2)) {
    return false;
  }

  Set<String> visited = {};
  List<List<int>> queue = [];
  queue.add([dfa1.initialState, dfa2.initialState]);

  while (queue.isNotEmpty) {
    List<int> currentPair = queue.removeAt(0);
    int state1 = currentPair[0];
    int state2 = currentPair[1];
    String pairKey = "$state1,$state2";

    if (visited.contains(pairKey)) {
      continue;
    }

    visited.add(pairKey);

    bool accepts1 = dfa1.acceptingStates.contains(state1);
    bool accepts2 = dfa2.acceptingStates.contains(state2);

    if (accepts1 != accepts2) {
      return false;
    }

    for (String symbol in dfa1.alphabet) {
      int nextState1 = dfa1.transitions[state1]?[symbol] ?? -1;
      int nextState2 = dfa2.transitions[state2]?[symbol] ?? -1;

      if (nextState1 == -1 || nextState2 == -1) {
        continue;
      }

      queue.add([nextState1, nextState2]);
    }
  }

  return true;
}

bool _sameAlphabet(DFA dfa1, DFA dfa2) {
  if (dfa1.alphabet.length != dfa2.alphabet.length) {
    return false;
  }

  for (String symbol in dfa1.alphabet) {
    if (!dfa2.alphabet.contains(symbol)) {
      return false;
    }
  }

  return true;
}

void main() {
  DFA dfa1 = DFA(
    states: {0, 1},
    alphabet: {'a', 'b'},
    transitions: {
      0: {'a': 1, 'b': 0},
      1: {'a': 1, 'b': 0},
    },
    initialState: 0,
    acceptingStates: {1},
  );

  DFA dfa2 = DFA(
    states: {0, 1, 2},
    alphabet: {'a', 'b'},
    transitions: {
      0: {'a': 1, 'b': 2},
      1: {'a': 1, 'b': 2},
      2: {'a': 1, 'b': 2},
    },
    initialState: 0,
    acceptingStates: {1},
  );

  bool result = areEquivalent(dfa1, dfa2);
  print('DFAs are equivalent: $result');

  DFA dfa3 = DFA(
    states: {0, 1},
    alphabet: {'a', 'b'},
    transitions: {
      0: {'a': 1, 'b': 0},
      1: {'a': 0, 'b': 1},
    },
    initialState: 0,
    acceptingStates: {0},
  );

  DFA dfa4 = DFA(
    states: {0, 1},
    alphabet: {'a', 'b'},
    transitions: {
      0: {'a': 0, 'b': 1},
      1: {'a': 1, 'b': 0},
    },
    initialState: 0,
    acceptingStates: {0},
  );

  result = areEquivalent(dfa3, dfa4);
  print('DFAs are equivalent: $result');
}