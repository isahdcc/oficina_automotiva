import 'tipo_trabalho.dart';

/// Serviço executado dentro de um atendimento (tabela `itens_atendimento`).
///
/// Em desenvolvimento: por enquanto só os atributos.
/// `late` é provisório, até o construtor com validação ser implementado.
class ItemAtendimento {
  int? id;
  int? atendimentoId; // o item fica dentro da lista do Atendimento
  late TipoTrabalho tipoTrabalho;
  late double valorCobrado; // >= 0
}
