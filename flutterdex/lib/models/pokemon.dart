import 'batalha.dart';
import 'evolucao.dart';

class Pokemon {
  final int id;
  final String nome;
  final String imagem;
  final String entrada;

  final Evolucao evolucao;
  final Batalha batalha;

  const Pokemon({
    required this.id,
    required this.nome,
    required this.imagem,
    required this.entrada,
    required this.evolucao,
    required this.batalha,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      nome: json['nome'],
      imagem: json['imagem'],
      entrada: json['entrada'],
      evolucao: Evolucao.fromJson(json['evolucao']),
      batalha: Batalha.fromJson(json['batalha']),
    );
  }
}
