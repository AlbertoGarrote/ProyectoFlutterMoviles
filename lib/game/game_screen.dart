import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';
import 'home_screen.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameState>();

    // PANTALLA FINAL (Ganaste / Perdiste)
    if (game.isGameOver) {
      bool partidaGanada = !game.lose;

      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                    game.startNewMatch();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                    );
                  },
                  child: const Text("Volver al inicio"),
                )
              ],
            ),
          ),
        ),
      );
    }

    // PANTALLA DE JUEGO NORMAL
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  Text(
                    "Palabra ${game.currentIndex + 1} de ${game.words.length}",
                    style: const TextStyle(fontSize: 20),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Errores: ${game.mistakes}/${game.maxMistakes}",
                    style: const TextStyle(fontSize: 24),
                  ),

                  const SizedBox(height: 10),

                  // Imagen responsiva
                  Image.asset(
                    game.CurrentImage,
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.30,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 20),

                  // Palabra
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: game.secretWord.split(" ").map((word) {
                      return Wrap(
                        alignment: WrapAlignment.center,
                        children: word.split("").map((char) {
                          final show = game.guessed.contains(char);
                          return Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              show ? char : "_",
                              style: const TextStyle(fontSize: 32),
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),


                  const SizedBox(height: 20),

                  // Teclado A-Z RESPONSIVE
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    alignment: WrapAlignment.center,
                    children: List.generate(26, (i) {
                      String letter = String.fromCharCode(65 + i);
                      bool disabled = game.guessed.contains(letter) || game.win || game.lose;

                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.16,
                        child: ElevatedButton(
                          onPressed: disabled ? null : () => game.guess(letter),
                          child: Text(letter),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
