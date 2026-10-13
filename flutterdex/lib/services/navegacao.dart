import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../screens/tela_detalhes.dart';
import '../screens/tela_login.dart';

class Navegacao {
  final GlobalKey<NavigatorState> chave = GlobalKey<NavigatorState>();

  void abrirLogin() {
    chave.currentState?.push(
      MaterialPageRoute(builder: (context) => const TelaLogin()),
    );
  }

  void abrirDetalhes(Pokemon pokemon) {
    chave.currentState?.push(
      MaterialPageRoute(builder: (context) => TelaDetalhes(pokemon: pokemon)),
    );
  }

  void voltar() {
    chave.currentState?.pop();
  }
}
