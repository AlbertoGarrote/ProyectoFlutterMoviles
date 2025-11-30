import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameState>();

    return Scaffold(
      appBar: AppBar(title: const Text("Creditos")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CREADORES",
              style: const TextStyle(fontSize: 36),
            ),

            Text(
              "David del Castillo Enríquez",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Ismael Esteban Liberal",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Alberto Garrote Salamanca",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Xabier López Aguilera",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Anatoli Nichei",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}