# Projeto 1 - Pipeline PySpark Para Extrair, Transformar e Carregar Arquivos JSON em Banco de Dados

# Imports
import random
import json

# Gerador de dados de exemplo
def dsa_gera_dados_exemplo(num_registros):
    
    nomes = ["Alice", "Bob", "Carol", "John", "Eve", "Frank", "Grace", "Hank", "Ivy", "Jack"]
    cidades = ["Natal", "Rio de Janeiro", "Blumenau", "Salvador", "Palmas", "Curitiba", "Fortaleza", "Manaus", "Recife", "Porto Alegre"]

    for _ in range(num_registros):
        nome = random.choice(nomes)
        idade = random.randint(20, 60)
        email = f"{nome.lower()}@dsa.com"
        salario = random.randint(3000, 8000)
        cidade = random.choice(cidades)

        yield {"nome": nome, "idade": idade, "email": email, "salario": salario, "cidade": cidade}

# Cria 1000 registros
dados_exemplo = list(dsa_gera_dados_exemplo(1000))

# Caminho do arquivo JSON
caminho_arquivo = 'usuarios.json'

# Salvando os dados no arquivo JSON
with open(caminho_arquivo, 'w') as arquivo:
    for item in dados_exemplo:
        json.dump(item, arquivo)
        arquivo.write('\n')


