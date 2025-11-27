import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';
import 'home_screen.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameState>();

    // Partida terminada
    if (game.isGameOver) {
      bool partidaGanada = !game.lose; // Ganaste si no perdiste en ninguna palabra
      return Scaffold(
        appBar: AppBar(title: const Text("Ahorcado")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                partidaGanada
                    ? "¡Ganaste la partida! 🎉"
                    : "Perdiste la partida 😢",
                style: const TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  game.startNewMatch(); // Reinicia la partida en GameState
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false, // Elimina la pila de navegación
                  );
                },
                child: const Text("Volver a inicio"),
              )
            ],
          ),
        ),
      );
    }

    // Pantalla de juego normal
    return Scaffold(
      appBar: AppBar(title: const Text("Ahorcado")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Palabra ${game.currentIndex + 1} de ${game.words.length}",
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            "Errores: ${game.mistakes}/${game.maxMistakes}",
            style: const TextStyle(fontSize: 24),
          ),

          // Palabra
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: game.secretWord.split("").map((char) {
              final show = game.guessed.contains(char);
              return Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  show ? char : "_",
                  style: const TextStyle(fontSize: 32),
                ),
              );
            }).toList(),
          ),

          // Letras A-Z
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: List.generate(26, (i) {
              String letter = String.fromCharCode(65 + i);
              bool disabled = game.guessed.contains(letter) || game.win || game.lose;

              return ElevatedButton(
                onPressed: disabled ? null : () => game.guess(letter),
                child: Text(letter),
              );
            }),
          ),
        ],
      ),
    );
  }
}
