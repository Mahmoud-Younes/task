# كنت مكلم حضرتك يا دكتور عشان التاخير كان الجهاز عندى سقط نسخه  +  كل ملفاتى فى الجهاز اتمسحت و شكراا




# Formal Language Theory Implementations in Dart

This repository contains implementations of various formal language theory concepts and algorithms in Dart.

## Contents

### 1. DFA Equivalence (dfa_equivalence.dart)

Implementation of an algorithm to check if two Deterministic Finite Automata (DFAs) are equivalent - that is, if they recognize the same language.

Features:
- DFA class with states, alphabet, transitions, initial state, and accepting states
- Algorithm to check equivalence between two DFAs
- Example test cases with both equivalent and non-equivalent DFAs

### 2. Context-Free Grammar Parser (second.dart)

Implementation of the Cocke-Younger-Kasami (CYK) algorithm for parsing strings using context-free grammars in Chomsky Normal Form (CNF).

Features:
- Rule and CNFGrammar classes for representing context-free grammars
- Two implementations of the CYK algorithm:
  - A standalone function (`belongsToLanguage`)
  - An object-oriented approach (`CYKParser` class)
- Test cases for various input strings

### 3. Turing Machine (three.dart)

Implementation of a simple Turing Machine simulator with an example for recognizing prime numbers.

Features:
- Transition and TuringMachine classes
- Simulator for running a Turing Machine on an input string
- Example implementation of a Turing Machine that recognizes prime numbers
- Test cases for various input strings

## Usage

Each file contains a `main` function that demonstrates usage of the implemented algorithms with example inputs. To run any of the implementations:

```bash
dart run dfa_equivalence.dart
dart run second.dart
dart run three.dart
```

## Notes

- The implementations are primarily for educational purposes to demonstrate concepts in formal language theory.
- The Turing Machine for prime number recognition is a simplified example and has limitations on the number of iterations.
- Some output messages in the CYK parser and Turing Machine implementations are in Arabic.
