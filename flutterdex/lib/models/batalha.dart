class Batalha {
  final int hp;
  final int ataque;
  final int defesa;
  final int ataqueEspecial;
  final int defesaEspecial;
  final int velocidade;
  final List<String> habilidades;

  const Batalha({
    required this.hp,
    required this.ataque,
    required this.defesa,
    required this.ataqueEspecial,
    required this.defesaEspecial,
    required this.velocidade,
    required this.habilidades,
  });

  factory Batalha.fromJson(Map<String, dynamic> json) {
    return Batalha(
      hp: json['hp'],
      ataque: json['ataque'],
      defesa: json['defesa'],
      ataqueEspecial: json['ataque_especial'],
      defesaEspecial: json['defesa_especial'],
      velocidade: json['velocidade'],
      habilidades: List<String>.from(json['habilidades']),
    );
  }
}
