import 'package:flutter/material.dart';

import 'screens/tela_lista.dart';

void main() {
  runApp(const FlutterdexApp());
}

class FlutterdexApp extends StatelessWidget {
  const FlutterdexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterdex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const TelaLista(),
    );
  }
}
