import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/pokemon.dart';

class PokemonService {
  Future<List<Pokemon>> buscarTodos() async {
    final texto = await rootBundle.loadString('assets/data/pokemons.json');

    final dados = jsonDecode(texto);

    final lista = dados['pokemons'] as List<dynamic>;

    return lista.map((item) => Pokemon.fromJson(item)).toList();
  }
}
