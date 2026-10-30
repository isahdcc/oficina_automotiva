# Oficina Automotiva

Sistema de console em Dart para gerenciar uma oficina automotiva: clientes, veículos, tipos de serviço e atendimentos. Trabalho acadêmico.

A modelagem das classes segue o banco de dados MySQL do projeto (tabelas `pessoas`, `veiculos`, `tipos_trabalho`, `atendimentos` e `itens_atendimento`).

## Objetivo desta etapa

- Criar a estrutura das classes de modelo com seus atributos e relacionamentos.
- Implementar por completo a classe `TipoTrabalho`, com validações, regras de negócio e conversão para/de mapa (formato do banco).
- Demonstrar o uso da classe em um programa de console.

## Estrutura de pastas

```
oficina_automotiva/
├── bin/
│   └── oficina_automotiva.dart     # ponto de entrada (demonstração)
├── lib/
│   └── models/
│       ├── pessoa.dart
│       ├── veiculo.dart
│       ├── tipo_trabalho.dart
│       ├── atendimento.dart
│       ├── item_atendimento.dart
│       └── situacao_atendimento.dart
├── analysis_options.yaml
├── pubspec.yaml
└── README.md
```

## Classes e relacionamentos

| Classe                | Tabela              | Relacionamentos                                              |
|-----------------------|---------------------|--------------------------------------------------------------|
| `Pessoa`              | `pessoas`           | Pode ter vários veículos                                     |
| `Veiculo`             | `veiculos`          | Pertence a uma `Pessoa`                                      |
| `TipoTrabalho`        | `tipos_trabalho`    | Usado por vários `ItemAtendimento`                           |
| `Atendimento`         | `atendimentos`      | Tem um `Veiculo` e uma lista de `ItemAtendimento`            |
| `ItemAtendimento`     | `itens_atendimento` | Pertence a um `Atendimento` e tem um `TipoTrabalho`          |
| `SituacaoAtendimento` | (enum)              | Situação do `Atendimento`: ABERTO, EM_ANDAMENTO, CONCLUIDO   |

## Regras de negócio implementadas

Classe `TipoTrabalho`:

- A descrição não pode ser vazia (espaços nas pontas são removidos).
- O valor padrão não pode ser negativo.
- O valor padrão é privado e só muda pelos métodos `reajustar` (novo valor) e `reajustarPercentual` (ex.: 10 para +10%), que validam a regra. O resultado do reajuste percentual é arredondado para centavos.
- `copyWith` cria uma cópia passando pelo construtor, então as mesmas validações valem.
- `toMap` usa as mesmas chaves das colunas do banco (`id`, `descricao`, `valor_padrao`).
- `fromMap` aceita o valor como inteiro, decimal ou texto e converte para `double`.
- Dados inválidos lançam `ArgumentError`.

Regras previstas para as próximas etapas:

- Placa no padrão Mercosul e imutável; ano do veículo entre 1886 e 2200.
- CPF com 11 dígitos; nome e telefone obrigatórios.
- Atendimento concluído não pode ser alterado nem receber ou remover itens.
- Só é possível concluir um atendimento com pelo menos um item.
- A data de conclusão só é preenchida quando o atendimento é concluído e não pode ser anterior à data de entrada.
- O total do atendimento é a soma dos valores cobrados nos itens.

## Como executar

Requisito: Dart SDK 3.x instalado.

```
dart pub get
dart run
```

Para verificar o código:

```
dart analyze
```

## Status das classes

| Classe                | Status                                      |
|-----------------------|---------------------------------------------|
| `TipoTrabalho`        | Completa                                    |
| `Pessoa`              | Em desenvolvimento (apenas atributos)       |
| `Veiculo`             | Em desenvolvimento (apenas atributos)       |
| `Atendimento`         | Em desenvolvimento (apenas atributos)       |
| `ItemAtendimento`     | Em desenvolvimento (apenas atributos)       |
| `SituacaoAtendimento` | Em desenvolvimento (apenas os valores)      |
