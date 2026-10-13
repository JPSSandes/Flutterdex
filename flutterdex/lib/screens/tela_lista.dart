import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pokemon.dart';
import '../services/navegacao.dart';
import '../services/pokemon_service.dart';
import '../services/sessao.dart';

class TelaLista extends StatelessWidget {
  const TelaLista({super.key});

  String _formatarNumero(int id) {
    return '#${id.toString().padLeft(3, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutterdex'),
        actions: [
          Consumer<Sessao>(
            builder: (context, sessao, child) {
              if (!sessao.logado) {
                return IconButton(
                  icon: const Icon(Icons.login),
                  tooltip: 'Entrar',
                  onPressed: () => context.read<Navegacao>().abrirLogin(),
                );
              }

              return Row(
                children: [
                  IconButton(
                    icon: Icon(
                      sessao.temaEscuro ? Icons.light_mode : Icons.dark_mode,
                    ),
                    tooltip: sessao.temaEscuro ? 'Tema claro' : 'Tema escuro',
                    onPressed: () => sessao.alternarTema(),
                  ),
                  Text(
                    sessao.usuario!,
                    style: TextStyle(
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    tooltip: 'Sair',
                    onPressed: () {
                      sessao.sair();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Você saiu da conta.')),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: PokemonService().buscarTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final todos = snapshot.data!;

          return Consumer<Sessao>(
            builder: (context, sessao, child) {
              final pokemons = sessao.apenasFavoritos
                  ? todos.where((p) => sessao.ehFavorito(p.id)).toList()
                  : todos;

              return Column(
                children: [
                  if (sessao.logado)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                        child: FilterChip(
                          avatar: const Icon(Icons.favorite, size: 18),
                          label: Text(
                            'Só favoritos (${sessao.totalFavoritos})',
                          ),
                          selected: sessao.apenasFavoritos,
                          showCheckmark: false,
                          onSelected: (_) => sessao.alternarFiltroFavoritos(),
                        ),
                      ),
                    ),

                  Expanded(
                    child: pokemons.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24),
                              child: Text(
                                'Você ainda não favoritou nenhum pokémon.\n'
                                'Toque no coração na tela de detalhes!',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: pokemons.length,
                            itemBuilder: (context, index) {
                              final pokemon = pokemons[index];

                              return Card(
                                child: ListTile(
                                  leading: Image.asset(
                                    pokemon.imagem,
                                    width: 56,
                                    height: 56,
                                  ),
                                  title: Text(
                                    pokemon.nome,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text(_formatarNumero(pokemon.id)),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (sessao.logado &&
                                          sessao.ehFavorito(pokemon.id))
                                        const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      const Icon(Icons.chevron_right),
                                    ],
                                  ),
                                  onTap: () {
                                    context.read<Navegacao>().abrirDetalhes(
                                      pokemon,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
