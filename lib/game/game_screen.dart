import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameState>();

    return Scaffold(
      appBar: AppBar(title: const Text("Ahorcado")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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

          // Mensaje final
          if (game.win) const Text("¡Ganaste!", style: TextStyle(fontSize: 28)),
          if (game.lose)
            Text("Perdiste. La palabra era: ${game.secretWord}",
                style: const TextStyle(fontSize: 20)),

          ElevatedButton(
            onPressed: game.reset,
            child: const Text("Reiniciar"),
          )
        ],
      ),
    );
  }
}
