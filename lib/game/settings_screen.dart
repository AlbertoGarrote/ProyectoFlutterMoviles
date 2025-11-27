import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameState>();

    return Scaffold(
      appBar: AppBar(title: const Text("Ajustes")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Nivel de dificultad
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Nivel de dificultad:"),
                DropdownButton<String>(
                  value: game.difficulty,
                  items: const [
                    DropdownMenuItem(value: "Fácil", child: Text("Fácil")),
                    DropdownMenuItem(value: "Medio", child: Text("Medio")),
                    DropdownMenuItem(value: "Difícil", child: Text("Difícil")),
                  ],
                  onChanged: (value) {
                    if (value != null) game.setDifficulty(value);
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Tema oscuro
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Tema oscuro"),
                Switch(
                  value: game.isDarkMode,
                  onChanged: (value) => game.setDarkMode(value),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Nombre de usuario
            TextField(
              decoration: const InputDecoration(
                labelText: "Nombre de usuario",
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: game.username),
              onChanged: (value) => game.setUsername(value),
            ),
          ],
        ),
      ),
    );
  }
}
