import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/tela_lista.dart';
import 'services/navegacao.dart';
import 'services/sessao.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<Navegacao>(create: (context) => Navegacao()),
        ChangeNotifierProvider<Sessao>(create: (context) => Sessao()),
      ],
      child: const FlutterdexApp(),
    ),
  );
}

ThemeData montarTema(Brightness brilho) {
  final cores = ColorScheme.fromSeed(
    seedColor: Colors.black,
    brightness: brilho,
  );
  final escuro = brilho == Brightness.dark;

  return ThemeData(
    colorScheme: cores,
    appBarTheme: AppBarTheme(
      backgroundColor: escuro ? cores.primaryContainer : cores.primary,
      foregroundColor: escuro ? cores.onPrimaryContainer : cores.onPrimary,
    ),
  );
}

class FlutterdexApp extends StatelessWidget {
  const FlutterdexApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navegacao = context.read<Navegacao>();

    final temaEscuro = context.select<Sessao, bool>((s) => s.temaEscuro);

    return MaterialApp(
      title: 'Flutterdex',
      debugShowCheckedModeBanner: false,
      navigatorKey: navegacao.chave,
      theme: montarTema(Brightness.light), // tema claro
      darkTheme: montarTema(Brightness.dark), // tema escuro
      // themeMode escolhe qual dos dois temas está valendo agora.
      themeMode: temaEscuro ? ThemeMode.dark : ThemeMode.light,
      home: const TelaLista(),
    );
  }
}
