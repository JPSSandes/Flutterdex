import 'package:flutter/material.dart';

import '../models/pokemon.dart';

class TelaDetalhes extends StatelessWidget {
  final Pokemon pokemon;

  const TelaDetalhes({super.key, required this.pokemon});

  String _formatarNumero(int id) {
    return '#${id.toString().padLeft(3, '0')}';
  }

  String _comoEvolui() {
    final evolucao = pokemon.evolucao;
    if (evolucao.metodo == 'nivel') {
      return 'no nível ${evolucao.nivel}';
    }
    if (evolucao.metodo == 'amizade') {
      return 'com muita amizade';
    }
    if (evolucao.metodo == 'pedra') {
      return 'usando a ${evolucao.item}';
    }
    return '';
  }

  Widget _cartao(BuildContext context, String titulo, List<Widget> conteudo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...conteudo,
          ],
        ),
      ),
    );
  }

  Widget _linhaStatus(String nome, int valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 130, child: Text(nome)),
          SizedBox(
            width: 36,
            child: Text(
              '$valor',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: valor / 255,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final evolucao = pokemon.evolucao;
    final batalha = pokemon.batalha;
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: cores.primaryContainer,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Image.asset(pokemon.imagem, width: 220),
                  const SizedBox(height: 8),
                  Text(
                    _formatarNumero(pokemon.id),
                    style: TextStyle(color: cores.onPrimaryContainer),
                  ),
                  Text(
                    pokemon.nome,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: cores.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _cartao(context, 'Pokédex', [Text(pokemon.entrada)]),

                  _cartao(context, 'Evolução', [
                    Text('Estágio ${evolucao.estagio} da linha evolutiva'),
                    if (evolucao.evoluiuDe != null)
                      Text('Evoluiu de: ${evolucao.evoluiuDe}'),
                    if (evolucao.evolui)
                      Text(
                        'Evolui para ${evolucao.evoluiPara} ${_comoEvolui()}',
                      )
                    else
                      const Text('Não evolui (forma final)'),
                  ]),

                  _cartao(context, 'Dados de batalha', [
                    _linhaStatus('HP', batalha.hp),
                    _linhaStatus('Ataque', batalha.ataque),
                    _linhaStatus('Defesa', batalha.defesa),
                    _linhaStatus('Ataque especial', batalha.ataqueEspecial),
                    _linhaStatus('Defesa especial', batalha.defesaEspecial),
                    _linhaStatus('Velocidade', batalha.velocidade),
                  ]),

                  _cartao(context, 'Habilidades', [
                    Wrap(
                      spacing: 8,
                      children: batalha.habilidades
                          .map((habilidade) => Chip(label: Text(habilidade)))
                          .toList(),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
