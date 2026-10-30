import 'pessoa.dart';

/// Veículo de um cliente (tabela `veiculos`).
///
/// Em desenvolvimento: por enquanto só os atributos.
/// `late` é provisório, até o construtor com validação ser implementado.
class Veiculo {
  late final String placa; // PK, padrão Mercosul, imutável
  late String marca;
  late String modelo;
  late int ano; // entre 1886 e 2200
  late String cor;
  late Pessoa pessoa; // dono do veículo (pessoa_id)
}
