class Transition {
  final String currentState;
  final String currentSymbol;
  final String nextState;
  final String writeSymbol;
  final String direction;

  Transition(this.currentState, this.currentSymbol, this.nextState,
      this.writeSymbol, this.direction);

  @override
  String toString() {
    return '($currentState, $currentSymbol) -> ($nextState, $writeSymbol, $direction)';
  }
}

class TuringMachine {
  final Set<String> states;
  final Set<String> alphabet;
  final String blankSymbol;
  final List<Transition> transitions;
  final String initialState;
  final Set<String> acceptingStates;

  TuringMachine({
    required this.states,
    required this.alphabet,
    required this.blankSymbol,
    required this.transitions,
    required this.initialState,
    required this.acceptingStates,
  });

  Transition? findTransition(String state, String symbol) {
    for (var transition in transitions) {
      if (transition.currentState == state && transition.currentSymbol == symbol) {
        return transition;
      }
    }
    return null;
  }

  bool run(String input) {
    List<String> tape = input.split('');
    tape.insert(0, blankSymbol);
    tape.add(blankSymbol);
    
    int headPosition = 1;
    String currentState = initialState;
    
    int maxIterations = 1000;
    int iteration = 0;
    
    while (iteration < maxIterations) {
      String currentSymbol = tape[headPosition];
      Transition? transition = findTransition(currentState, currentSymbol);
      
      if (transition == null) {
        break;
      }
      
      tape[headPosition] = transition.writeSymbol;
      currentState = transition.nextState;
      
      if (transition.direction == 'R') {
        headPosition++;
        if (headPosition >= tape.length) {
          tape.add(blankSymbol);
        }
      } else if (transition.direction == 'L') {
        headPosition--;
        if (headPosition < 0) {
          tape.insert(0, blankSymbol);
          headPosition = 0;
        }
      }
      
      iteration++;
    }
    
    return acceptingStates.contains(currentState);
  }
}

TuringMachine createPrimeNumberTM() {
  Set<String> states = {
    'q0', 'q1', 'q2', 'q3', 'q4', 'q5', 'q6', 'q7',
    'qAccept', 'qReject'
  };
  
  Set<String> alphabet = {'1', '_'};
  
  List<Transition> transitions = [
    Transition('q0', '1', 'q1', '1', 'R'),
    Transition('q0', '_', 'qReject', '_', 'R'),
    
    Transition('q1', '1', 'q2', '1', 'R'),
    Transition('q1', '_', 'qReject', '_', 'R'),
    
    Transition('q2', '1', 'q3', '1', 'R'),
    Transition('q2', '_', 'qAccept', '_', 'R'),
    
    Transition('q3', '1', 'q4', '1', 'R'),
    Transition('q3', '_', 'qAccept', '_', 'R'),
    
    Transition('q4', '1', 'q5', '1', 'R'),
    Transition('q4', '_', 'qReject', '_', 'R'),
    
    Transition('q5', '1', 'q6', '1', 'R'),
    Transition('q5', '_', 'qAccept', '_', 'R'),
    
    Transition('q6', '1', 'q7', '1', 'R'),
    Transition('q6', '_', 'qReject', '_', 'R'),
    
    Transition('q7', '1', 'q8', '1', 'R'),
    Transition('q7', '_', 'qAccept', '_', 'R'),
  ];
  
  return TuringMachine(
    states: states,
    alphabet: alphabet,
    blankSymbol: '_',
    transitions: transitions,
    initialState: 'q0',
    acceptingStates: {'qAccept'},
  );
}

void main() {
  TuringMachine primeTM = createPrimeNumberTM();
  
  List<String> testCases = ['', '1', '11', '111', '1111', '11111', '111111', '1111111'];
  
  for (var input in testCases) {
    bool result = primeTM.run(input);
    print('السلسلة: $input (الطول: ${input.length}) - ${result ? "مقبولة (عدد أولي)" : "مرفوضة (ليس عدد أولي)"}');
  }
}