import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../services/pokemon_service.dart';

class TelaLista extends StatelessWidget {
  const TelaLista({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutterdex')),
      body: FutureBuilder<List<Pokemon>>(
        future: PokemonService().buscarTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final pokemons = snapshot.data!;

          return ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];

              return ListTile(
                leading: Text('#${pokemon.id}'),
                title: Text(pokemon.nome),
              );
            },
          );
        },
      ),
    );
  }
}
