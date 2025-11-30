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
              onChanged: (value) => game.setUsername(value),
            ),
          ],
        ),
      ),
    );
  }
}
