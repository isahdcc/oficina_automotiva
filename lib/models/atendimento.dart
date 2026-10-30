import 'item_atendimento.dart';
import 'situacao_atendimento.dart';
import 'veiculo.dart';

/// Atendimento de um veículo na oficina (tabela `atendimentos`).
///
/// Em desenvolvimento: por enquanto só os atributos.
/// `late` é provisório, até o construtor com validação ser implementado.
class Atendimento {
  int? id;
  late final Veiculo veiculo; // imutável
  late final DateTime dataEntrada; // imutável, padrão: agora
  late String problemaRelatado;
  SituacaoAtendimento situacao = SituacaoAtendimento.aberto;
  DateTime? dataConclusao; // só preenchida quando CONCLUIDO
  final List<ItemAtendimento> itens = [];
}
