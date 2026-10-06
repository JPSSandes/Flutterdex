class Evolucao {
  final int estagio;
  final bool evolui;

  final String? evoluiPara;
  final String? evoluiuDe;
  final String? metodo;
  final int? nivel;
  final String? item;

  const Evolucao({
    required this.estagio,
    required this.evolui,
    this.evoluiPara,
    this.evoluiuDe,
    this.metodo,
    this.nivel,
    this.item,
  });

  factory Evolucao.fromJson(Map<String, dynamic> json) {
    return Evolucao(
      estagio: json['estagio'],
      evolui: json['evolui'],
      evoluiPara: json['evolui_para'],
      evoluiuDe: json['evoluiu_de'],
      metodo: json['metodo'],
      nivel: json['nivel'],
      item: json['item'],
    );
  }
}
