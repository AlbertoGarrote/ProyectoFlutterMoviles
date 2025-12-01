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
                  "Puntuación total: ${game.totalScore}",
                  style: const TextStyle(fontSize: 26),
                ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: LinearProgressIndicator(
                      value: (game.maxMistakes - game.mistakes) / game.maxMistakes,
                      backgroundColor: Colors.red.shade200,
                      valueColor: const AlwaysStoppedAnimation(Colors.green),
                    ),
                  ),
                  Text(
                    "Puntuación palabra: ${game.score}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Puntuación total: ${game.totalScore}",
                    style: const TextStyle(fontSize: 20),
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
                              style: const TextStyle(
                                fontSize: 32,
                                shadows: [
                                  Shadow(offset: Offset(2, 2), blurRadius: 3, color: Colors.black38)
                                ],
                              ),
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

                      // Determinar color según acierto/fallo
                      Color backgroundColor = Colors.blue; // default
                      if (game.correctLetters.contains(letter)) {
                        backgroundColor = Colors.green; // letra correcta
                      } else if (game.wrongLetters.contains(letter)) {
                        backgroundColor = Colors.red; // letra incorrecta
                      }

                      // Solo desactivamos interacción si la partida terminó
                      bool canPress = !(game.win || game.lose);

                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.16,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundColor,
                            foregroundColor: Colors.white,
                          ),
                            onPressed: canPress
                                ? () {
                              if (!game.guessed.contains(letter)) {
                                context.read<GameState>().guess(letter);
                              }
                            }
                                : null,
                          child: Text(letter),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
