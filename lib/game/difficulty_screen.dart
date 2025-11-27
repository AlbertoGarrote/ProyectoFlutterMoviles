import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';
import 'game_screen.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameState>();

    return Scaffold(
      appBar: AppBar(title: const Text("Selecciona la dificultad")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                game.setDifficulty("Fácil");
                game.startNewMatch();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GameScreen()),
                );
              },
              child: const Text("Fácil"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.setDifficulty("Medio");
                game.startNewMatch();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GameScreen()),
                );
              },
              child: const Text("Medio"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.setDifficulty("Difícil");
                game.startNewMatch();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GameScreen()),
                );
              },
              child: const Text("Difícil"),
            ),
          ],
        ),
      ),
    );
  }
}
