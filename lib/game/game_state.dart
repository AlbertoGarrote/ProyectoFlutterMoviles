import 'dart:math';
import 'package:flutter/material.dart';
import 'word_list.dart';

class GameState extends ChangeNotifier {
  late String secretWord;
  List<String> guessed = [];
  int mistakes = 0;
  final int maxMistakes = 6;

  GameState() {
    reset();
  }

  void reset() {
    secretWord = wordList[Random().nextInt(wordList.length)];
    guessed = [];
    mistakes = 0;
    notifyListeners();
  }

  void guess(String letter) {
    if (guessed.contains(letter)) return;

    guessed.add(letter);

    if (!secretWord.contains(letter)) {
      mistakes++;
    }

    notifyListeners();
  }

  bool get win => secretWord.split("").every(guessed.contains);

  bool get lose => mistakes >= maxMistakes;
}
