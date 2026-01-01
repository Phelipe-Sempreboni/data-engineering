# Lab 9 - Analytics Engineering e Linhagem de Dados com Python, DBT, BigQuery e Looker Studio

# Imports
from google.cloud import bigquery
import os

# Configure a variável de ambiente para autenticação
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "../chave/dsalab9-0b65981268a7.json"

# Configure o projeto e dataset
project_id = "dsalab9"
dataset_id = "dsastaging"

# Diretório onde os arquivos CSV estão salvos
csv_directory = "dados"  

# Inicializa o cliente do BigQuery
client = bigquery.Client(project=project_id)

# Função para criar o dataset (banco de dados) se ele não existir
def dsa_cria_dataset(dataset_id):

    # Nome do projeto e do dataset
    dataset_ref = f"{project_id}.{dataset_id}"

    # Definir o dataset
    dataset = bigquery.Dataset(dataset_ref)

    # Você pode ajustar a região conforme necessário
    dataset.location = "US"  

    try:
        # Verifica se o dataset já existe
        client.get_dataset(dataset_ref)  
        print(f"Dataset '{dataset_id}' já existe.")
    except Exception:
        # Se não existir, cria o dataset
        dataset = client.create_dataset(dataset)
        print(f"Dataset '{dataset_id}' criado com sucesso.")

# Função para carregar cada CSV como uma tabela no BigQuery
def dsa_carrega_bigquery(table_name, csv_file_path):

    # Define o nome da tabela
    table_id = f"{project_id}.{dataset_id}.{table_name}"
    
    # Configuração do job de carregamento
    job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.CSV,
        skip_leading_rows=1,  # Ignora o cabeçalho
        autodetect=True       # Detecta automaticamente o esquema (colunas e tipos)
    )
    
    with open(csv_file_path, "rb") as file:
        load_job = client.load_table_from_file(file, table_id, job_config=job_config)
        load_job.result()  # Espera até o fim do job

    print(f"Tabela {table_name} criada com sucesso.")

# Primeiro, cria o dataset se ele ainda não existir
dsa_cria_dataset(dataset_id)

# Arquivos CSV e nomes das tabelas correspondentes
csv_files = {
    "stg_clientes": os.path.join(csv_directory, "stg_clientes.csv"),
    "stg_data": os.path.join(csv_directory, "stg_data.csv"),
    "stg_localidades": os.path.join(csv_directory, "stg_localidades.csv"),
    "stg_produtos": os.path.join(csv_directory, "stg_produtos.csv"),
    "stg_vendas": os.path.join(csv_directory, "stg_vendas.csv")
}

# Carrega cada CSV no BigQuery
for table_name, csv_file_path in csv_files.items():
    dsa_carrega_bigquery(table_name, csv_file_path)








