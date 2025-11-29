import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameState>();

    return Scaffold(
      appBar: AppBar(title: const Text("Puntuaciones")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}