import 'package:oficina_automotiva/models/tipo_trabalho.dart';

/// Demonstração da classe TipoTrabalho.
void main() {
  print('=== Criando tipos de trabalho ===');
  final trocaOleo = TipoTrabalho(
    id: 1,
    descricao: 'Troca de óleo',
    valorPadrao: 120,
  );
  print(trocaOleo);

  print('\n=== Reajustes ===');
  trocaOleo.reajustar(130);
  print('Reajuste para 130: $trocaOleo');
  trocaOleo.reajustarPercentual(10);
  print('Reajuste de 10%:  $trocaOleo');

  print('\n=== copyWith ===');
  final trocaOleoSintetico = trocaOleo.copyWith(
    id: 2,
    descricao: 'Troca de óleo sintético',
    valorPadrao: 220,
  );
  print('Original: $trocaOleo');
  print('Cópia:    $trocaOleoSintetico');

  print('\n=== toMap ===');
  final mapa = trocaOleo.toMap();
  print(mapa);

  print('\n=== fromMap ===');
  // Simula uma linha vinda do banco, com valor inteiro (num -> double).
  final alinhamento = TipoTrabalho.fromMap({
    'id': 3,
    'descricao': 'Alinhamento',
    'valor_padrao': 80,
  });
  print(alinhamento);
  print('Ida e volta pelo mapa: ${TipoTrabalho.fromMap(mapa)}');

  print('\n=== Casos de erro ===');
  try {
    TipoTrabalho(descricao: '   ', valorPadrao: 50);
  } on ArgumentError catch (e) {
    print('Erro esperado: ${e.message}');
  }

  try {
    alinhamento.reajustar(-10);
  } on ArgumentError catch (e) {
    print('Erro esperado: ${e.message}');
    print('Valor continua o mesmo: $alinhamento');
  }
}
