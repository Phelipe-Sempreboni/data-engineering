# Lab 4 - Processo de Governança e Qualidade de Dados no Data Warehouse

# Imports
import yaml
import great_expectations as ge
from great_expectations.core.batch import RuntimeBatchRequest
from great_expectations.core.expectation_configuration import ExpectationConfiguration
from great_expectations.render.renderer import ValidationResultsPageRenderer
from great_expectations.render.view import DefaultJinjaPageView

# Configurar conexão com o banco de dados PostgreSQL
host = "localhost"  
port = "5631"  
db_name = "dsadb"
user = "dsaadmin"
password = "dsa1010"

# String de conexão
connection_string = f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{db_name}"

# Cria o contexto do Great Expectations
context = ge.get_context()

# Configura o datasource para PostgreSQL
datasource_config = {
    "name": "dsa_postgres_datasource",
    "class_name": "Datasource",
    "execution_engine": {
        "class_name": "SqlAlchemyExecutionEngine",
        "connection_string": connection_string,
    },
    "data_connectors": {
        "default_runtime_data_connector_name": {
            "class_name": "RuntimeDataConnector",
            "batch_identifiers": ["default_identifier_name"],
        }
    },
}

# Adiciona a configuração do datasource ao contexto
context.test_yaml_config(yaml.dump(datasource_config))
context.add_datasource(**datasource_config)

# Função para validar a tabela com um conjunto de expectativas
def dsa_valida_expectativas(tabela, expectativas):

    # Solicitar um batch de dados da tabela usando RuntimeBatchRequest
    batch_request = RuntimeBatchRequest(datasource_name = "dsa_postgres_datasource",
                                        data_connector_name = "default_runtime_data_connector_name",
                                        data_asset_name = tabela,
                                        runtime_parameters = {"query": f"SELECT * FROM dw.{tabela} LIMIT 1000"},
                                        batch_identifiers = {"default_identifier_name": "default_id"})
    
    # Cria o validador para aplicar as expectativas
    validator = context.get_validator(batch_request = batch_request)

    # Aplica as expectativas fornecidas
    for expectativa in expectativas:
        validator.expectation_suite.add_expectation(expectativa)

    # Validar os dados e retornar o resultado
    validation_result = validator.validate()

    # Renderiza resultado como HTML
    renderer = ValidationResultsPageRenderer()
    rendered_document_content = renderer.render(validation_result)
    html_content = DefaultJinjaPageView().render(rendered_document_content)

    # Salva resultado em um arquivo HTML
    with open(f"validation_report_{tabela}.html", "w") as f:
        f.write(html_content)
    
    return validation_result

# Define expectativas para a tabela 'dim_produto' usando ExpectationConfiguration
expectativas_dim_produto = [
    ExpectationConfiguration(
        expectation_type="expect_column_to_exist",
        kwargs={"column": "id_produto"}
    ),
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_be_unique",
        kwargs={"column": "id_produto"}
    ),
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_not_be_null",
        kwargs={"column": "nome"}
    ),
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_be_in_set",
        kwargs={"column": "categoria", "value_set": ["Eletrônicos", "Alimentos", "Bebidas", "Educação", "Acessórios"]}
    )
]

# Validar a tabela 'dim_produto' e gerar relatório HTML
print("Validação da tabela dim_produto:")
resultado_dim_produto = dsa_valida_expectativas("dim_produto", expectativas_dim_produto)
print(resultado_dim_produto)

# Define expectativas para a tabela 'dim_canal' usando ExpectationConfiguration
expectativas_dim_canal = [
    # Verificar se a coluna 'id_canal' existe
    ExpectationConfiguration(
        expectation_type="expect_column_to_exist",
        kwargs={"column": "id_canal"}
    ),
    # Verificar se os valores da coluna 'id_canal' são únicos
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_be_unique",
        kwargs={"column": "id_canal"}
    ),
    # Verificar se a coluna 'nome' não contém valores nulos
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_not_be_null",
        kwargs={"column": "nome"}
    ),
    # Verificar se a coluna 'regiao' possui valores dentro do conjunto esperado
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_be_in_set",
        kwargs={
            "column": "regiao",
            "value_set": [
                "Global", 
                "América do Norte", 
                "Europa", 
                "Ásia", 
                "América do Sul", 
                "África", 
                "Oceania", 
                "América Latina"
            ]
        }
    )
]

# Validar a tabela 'dim_canal' e gerar relatório HTML
print("Validação da tabela dim_canal:")
resultado_dim_canal = dsa_valida_expectativas("dim_canal", expectativas_dim_canal)
print(resultado_dim_canal)

# Define expectativas para a tabela 'dim_cliente' usando ExpectationConfiguration
expectativas_dim_cliente = [
    # Verificar se a coluna 'id_cliente' existe
    ExpectationConfiguration(
        expectation_type="expect_column_to_exist",
        kwargs={"column": "id_cliente"}
    ),
    # Verificar se os valores da coluna 'id_cliente' são únicos
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_be_unique",
        kwargs={"column": "id_cliente"}
    ),
    # Verificar se a coluna 'nome' não contém valores nulos
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_not_be_null",
        kwargs={"column": "nome"}
    ),
    # Verificar se a coluna 'tipo' contém valores dentro de um conjunto esperado
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_be_in_set",
        kwargs={"column": "tipo", "value_set": ["Corporativo", "Individual"]}
    ),
    # Verificar se a coluna 'pais' não contém valores nulos
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_not_be_null",
        kwargs={"column": "pais"}
    ),
    # Verificar se a coluna 'estado' não contém valores nulos
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_not_be_null",
        kwargs={"column": "estado"}
    )
]

# Validar a tabela 'dim_cliente' e gerar relatório HTML
print("Validação da tabela dim_cliente:")
resultado_dim_cliente = dsa_valida_expectativas("dim_cliente", expectativas_dim_cliente)
print(resultado_dim_cliente)

# Define expectativas para a tabela 'fato_venda' usando ExpectationConfiguration
expectativas_fato_venda = [
    # Verificar se as colunas principais existem
    ExpectationConfiguration(
        expectation_type="expect_column_to_exist",
        kwargs={"column": "sk_produto"}
    ),
    ExpectationConfiguration(
        expectation_type="expect_column_to_exist",
        kwargs={"column": "sk_cliente"}
    ),
    ExpectationConfiguration(
        expectation_type="expect_column_to_exist",
        kwargs={"column": "sk_canal"}
    ),
    ExpectationConfiguration(
        expectation_type="expect_column_to_exist",
        kwargs={"column": "sk_data"}
    ),
    ExpectationConfiguration(
        expectation_type="expect_column_to_exist",
        kwargs={"column": "quantidade"}
    ),
    ExpectationConfiguration(
        expectation_type="expect_column_to_exist",
        kwargs={"column": "valor_venda"}
    ),
    
    # Verificar se os valores de 'quantidade' não são nulos
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_not_be_null",
        kwargs={"column": "quantidade"}
    ),
    
    # Verificar se os valores de 'valor_venda' não são nulos
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_not_be_null",
        kwargs={"column": "valor_venda"}
    ),
    
    # Verificar se os valores de 'quantidade' estão dentro de um intervalo esperado (1 a 1000)
    ExpectationConfiguration(
        expectation_type="expect_column_values_to_be_between",
        kwargs={"column": "quantidade", "min_value": 1, "max_value": 1000}
    ),
    
    # Verificar se os valores mínimos de 'valor_venda' são maiores ou iguais a 0
    ExpectationConfiguration(
        expectation_type="expect_column_min_to_be_between",
        kwargs={"column": "valor_venda", "min_value": 0, "max_value": None}
    ),
    
    # Verificar se a combinação das colunas 'sk_produto', 'sk_cliente', 'sk_canal', 'sk_data' é única (chave primária)
    ExpectationConfiguration(
        expectation_type="expect_compound_columns_to_be_unique",
        kwargs={"column_list": ["sk_produto", "sk_cliente", "sk_canal", "sk_data"]}
    )
]

# Validar a tabela 'fato_venda' e gerar relatório HTML
print("Validação da tabela fato_venda:")
resultado_fato_venda = dsa_valida_expectativas("fato_venda", expectativas_fato_venda)
print(resultado_fato_venda)

print("\nValidação Concluída com Sucesso. Verifique os Relatórios em Formato HTML.\n")

