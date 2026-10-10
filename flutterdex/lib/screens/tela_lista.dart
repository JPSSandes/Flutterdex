import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../services/pokemon_service.dart';
import 'tela_detalhes.dart';

class TelaLista extends StatelessWidget {
  const TelaLista({super.key});

  String _formatarNumero(int id) {
    return '#${id.toString().padLeft(3, '0')}';
  }

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
            // Margem ao redor de toda a lista.
            padding: const EdgeInsets.all(8),
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];

              return Card(
                child: ListTile(
                  leading: Image.asset(pokemon.imagem, width: 56, height: 56),
                  title: Text(
                    pokemon.nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(_formatarNumero(pokemon.id)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDetalhes(pokemon: pokemon),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
