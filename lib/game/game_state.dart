import 'dart:math';
import 'package:flutter/material.dart';
import 'word_list.dart';

class GameState extends ChangeNotifier {
  // Palabras de la partida
  late List<String> words;
  int currentIndex = 0;

  // Estado actual de la palabra
  late String secretWord;
  List<String> guessed = [];
  int mistakes = 0;
  int maxMistakes = 6;

  // Ajustes
  String difficulty = "Medio"; // Fácil, Medio, Difícil
  bool isDarkMode = false;
  String username = "Jugador";

  GameState() {
    startNewMatch();
  }

  // Inicia una nueva partida de 4 palabras
  void startNewMatch() {
    words = List.generate(4, (_) => wordList[Random().nextInt(wordList.length)]);
    currentIndex = 0;
    resetCurrentWord();
  }

  void resetCurrentWord() {
    secretWord = words[currentIndex];
    guessed = [];
    mistakes = 0;

    // Ajusta maxMistakes según dificultad
    switch (difficulty) {
      case "Fácil":
        maxMistakes = 8;
        break;
      case "Medio":
        maxMistakes = 6;
        break;
      case "Difícil":
        maxMistakes = 4;
        break;
    }

    notifyListeners();
  }

  void guess(String letter) {
    if (guessed.contains(letter) || isGameOver) return;

    guessed.add(letter);
    if (!secretWord.contains(letter)) mistakes++;

    // Si adivina la palabra
    if (win) {
      // Si era la última palabra, no reseteamos
      if (currentIndex < words.length - 1) {
        currentIndex++;
        resetCurrentWord();
      } else {
        // Última palabra adivinada -> partida ganada
        notifyListeners();
      }
    }

    notifyListeners();
  }

  bool get isGameOver {
    // Pierdes si llegas al máximo de errores
    if (lose) return true;
    // Ganaste si adivinaste la última palabra
    if (win && currentIndex == words.length - 1) return true;
    return false;
  }

  bool get win => secretWord.split("").every(guessed.contains);
  bool get lose => mistakes >= maxMistakes;

  void setDifficulty(String value) {
    difficulty = value;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }

  void setUsername(String value) {
    username = value;
    notifyListeners();
  }
}
