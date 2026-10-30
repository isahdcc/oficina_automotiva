/// Cliente da oficina (tabela `pessoas`).
///
/// Em desenvolvimento: por enquanto só os atributos.
/// `late` é provisório, até o construtor com validação ser implementado.
class Pessoa {
  int? id;
  late String nome;
  late String cpf; // 11 dígitos, único
  late String telefone;
  String? email; // opcional
}
