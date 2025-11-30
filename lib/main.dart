import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game/game_screen.dart';
import 'game/game_state.dart';
import 'game/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inazuma Eleven: Ahorcado',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: game.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}