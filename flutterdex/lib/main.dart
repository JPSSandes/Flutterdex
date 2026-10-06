import 'package:flutter/material.dart';

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
      home: const HomeScreen(),
    );
  }
}

// Tela temporária só para validar que tudo funciona.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutterdex')),
      body: const Center(child: Text('Bem-vindo à Flutterdex!')),
    );
  }
}
