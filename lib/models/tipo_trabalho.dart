/// Tipo de serviço oferecido pela oficina (tabela `tipos_trabalho`).
///
/// Ex.: troca de óleo, alinhamento, balanceamento.
class TipoTrabalho {
  /// Nulo enquanto o registro ainda não foi salvo no banco.
  final int? id;

  /// A descrição não muda depois de criada; para "renomear", use [copyWith].
  final String descricao;

  /// Privado: o valor só muda pelos métodos de reajuste, que validam a regra.
  double _valorPadrao;

  /// Cria um tipo de trabalho validando os dados.
  ///
  /// Lança [ArgumentError] se a descrição estiver vazia
  /// ou se o valor for negativo.
  TipoTrabalho({
    this.id,
    required String descricao,
    required double valorPadrao,
  }) : descricao = _validarDescricao(descricao),
       _valorPadrao = _validarValor(valorPadrao);

  /// Monta o objeto a partir de uma linha do banco.
  ///
  /// O driver pode devolver o valor como int, double ou String (DECIMAL),
  /// por isso a conversão é feita aqui antes de chamar o construtor.
  factory TipoTrabalho.fromMap(Map<String, dynamic> map) {
    return TipoTrabalho(
      id: (map['id'] as num?)?.toInt(),
      descricao: map['descricao'] as String,
      valorPadrao: _paraDouble(map['valor_padrao']),
    );
  }

  double get valorPadrao => _valorPadrao;

  /// Define um novo valor padrão (regra: não pode ser negativo).
  void reajustar(double novoValor) {
    _valorPadrao = _validarValor(novoValor);
  }

  /// Aplica um reajuste percentual. Ex.: 10 aumenta 10%, -5 reduz 5%.
  ///
  /// O resultado é arredondado para 2 casas (centavos).
  /// Reduções acima de 100% são recusadas, pois deixariam o valor negativo.
  void reajustarPercentual(double percentual) {
    final novoValor = _valorPadrao * (1 + percentual / 100);
    reajustar((novoValor * 100).round() / 100);
  }

  /// Cria uma cópia com os campos informados alterados.
  ///
  /// Passa pelo construtor, então as mesmas validações são aplicadas.
  TipoTrabalho copyWith({int? id, String? descricao, double? valorPadrao}) {
    return TipoTrabalho(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      valorPadrao: valorPadrao ?? _valorPadrao,
    );
  }

  /// Converte para um mapa com as mesmas chaves das colunas do banco.
  Map<String, dynamic> toMap() {
    return {'id': id, 'descricao': descricao, 'valor_padrao': _valorPadrao};
  }

  @override
  String toString() {
    final valor = _valorPadrao.toStringAsFixed(2).replaceAll('.', ',');
    return 'TipoTrabalho(id: ${id ?? "novo"}, descricao: $descricao, '
        'valorPadrao: R\$ $valor)';
  }

  // --- Validações reutilizadas pelo construtor e pelos métodos ---

  static String _validarDescricao(String descricao) {
    final texto = descricao.trim();
    if (texto.isEmpty) {
      throw ArgumentError.value(
        descricao,
        'descricao',
        'A descrição não pode ser vazia',
      );
    }
    return texto;
  }

  static double _validarValor(double valor) {
    if (valor.isNaN || valor < 0) {
      throw ArgumentError.value(
        valor,
        'valorPadrao',
        'O valor padrão não pode ser negativo',
      );
    }
    return valor;
  }

  static double _paraDouble(dynamic valor) {
    if (valor is num) return valor.toDouble();
    if (valor is String) {
      final convertido = double.tryParse(valor);
      if (convertido != null) return convertido;
    }
    throw ArgumentError.value(
      valor,
      'valor_padrao',
      'Valor inválido vindo do banco',
    );
  }
}
