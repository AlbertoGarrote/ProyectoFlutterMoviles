import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';
import 'game_screen.dart';
import 'credits_screen.dart';
import 'settings_screen.dart';
import 'difficulty_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameState>();
    return Scaffold(
      appBar: AppBar(

        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreditsScreen())
              );
            }
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                "assets/LOGO.png",
              width: 600,
            ),
            const SizedBox(height: 50),
            Text(
              "Bienvenido, ${game.username}!",
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DifficultyScreen()),
                );
              },
              child: const Text("Jugar"),
            ),
          ],
        ),
      ),
    );
  }
}
