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

      //Modo claro
      theme: ThemeData(
        brightness: Brightness.light,
        //Color botones
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),

      //Tema oscuro
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        //Color botones
        colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.orange,
        brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.blueGrey,  // Fondo
        appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        ),
        useMaterial3: true,
      ),

      // Cambio entre temas
      themeMode: game.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: const HomeScreen(),
    );
  }
}