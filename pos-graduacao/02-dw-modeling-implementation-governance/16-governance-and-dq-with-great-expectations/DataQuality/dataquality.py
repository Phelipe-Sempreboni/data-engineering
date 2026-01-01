# Script de Validações e Expectativas Para Testes de Qualidade de Dados

# Importa a biblioteca Great Expectations para validação de dados
import great_expectations as gx

# Obtém o contexto de execução do Great Expectations
context = gx.get_context()

# Cria um validador para o dataset, lendo o arquivo CSV
validator = context.sources.pandas_default.read_csv("dataset.csv")

# Define a expectativa de que a coluna "id" exista no dataset
validator.expect_column_to_exist(column="id")

# Define a expectativa de que o número de colunas na tabela esteja entre 1 e 3
validator.expect_table_column_count_to_be_between(min_value=1, max_value=3)

# Define a expectativa de que o número de linhas na tabela esteja entre 1 e 100
validator.expect_table_row_count_to_be_between(min_value=1, max_value=100)

# Define a expectativa de que os valores da coluna "id" não sejam nulos, indicando identificação de cada funcionário
validator.expect_column_values_to_not_be_null(column="id", notes="**Identificação** de cada funcionário")

# Define a expectativa de que os valores da coluna "id" estejam entre 1 e 10
validator.expect_column_values_to_be_between("id", min_value=1, max_value=10)

# Define a expectativa de que os valores da coluna "id" sejam únicos
validator.expect_column_values_to_be_unique(column="id")

# Define a expectativa de que a contagem de valores únicos da coluna "id" esteja entre 1 e 10
validator.expect_column_unique_value_count_to_be_between(column="id", min_value=1, max_value=10)

# Salva o conjunto de expectativas, mantendo as expectativas que falharam
validator.save_expectation_suite(discard_failed_expectations=False)

# Adiciona ou atualiza um checkpoint para executar as validações definidas
checkpoint = context.add_or_update_checkpoint(name="dsa_checkpoint", validator=validator)

# Executa o checkpoint e armazena o resultado
checkpoint_result = checkpoint.run()

# Verifica se houve sucesso no checpoint, indicando se todas as expectativas foram cumpridas
result = dict(checkpoint_result)["_success"]

# Exibe se houve sucesso nas validações
print(f"Resultado da Análise: {result}")

# Visualiza o resultado da validação no contexto do Great Expectations
context.view_validation_result(checkpoint_result)




