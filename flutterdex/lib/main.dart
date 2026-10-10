import 'package:flutter/material.dart';

import 'screens/tela_lista.dart';

void main() {
  runApp(const FlutterdexApp());
}

class FlutterdexApp extends StatelessWidget {
  const FlutterdexApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cores = ColorScheme.fromSeed(seedColor: Colors.white);

    return MaterialApp(
      title: 'Flutterdex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: cores,
        appBarTheme: AppBarTheme(
          backgroundColor: cores.primary,
          foregroundColor: cores.onPrimary,
        ),
      ),
      home: const TelaLista(),
    );
  }
}
