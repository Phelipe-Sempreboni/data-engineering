# DSA Projeto 2 - Script 32 - RDD Map

# Imports
import os
from pyspark.sql import SparkSession

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 32 - RDD Map:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script32').getOrCreate()
    
# Lista de dados contendo informações de pessoas
dados_dsa = [('Carlos','Estrela','M',30), ('Tatiana','Moraes','F',41), ('Renato','Carvalho','M',62)]

# Definindo as colunas para o DataFrame
colunas = ["primeiro_nome", "sobrenome", "genero", "salario"]

# Criando um DataFrame com os dados e o esquema definido
df = spark.createDataFrame(data = dados_dsa, schema = colunas)

# Exibindo o DataFrame
df.show()

# Mapeando cada linha do DataFrame para uma nova forma, combinando nome e sobrenome, mantendo gênero e dobrando o salário
dsa_rdd = df.rdd.map(lambda x: (x[0] + " " + x[1], x[2], x[3] * 2))  

# Convertendo o RDD mapeado de volta para um DataFrame e mostrando o resultado
df2 = dsa_rdd.toDF(["nome", "genero", "novo_salario"]).show()

# Mapeando cada linha do DataFrame usando colunas por nome, ajustando o formato e dobrando o salário
dsa_rdd = df.rdd.map(lambda x: (x["primeiro_nome"] + " " + x["sobrenome"], x["genero"], x["salario"] * 2)) 

# Convertendo o RDD mapeado de volta para um DataFrame e mostrando o resultado
df3 = dsa_rdd.toDF(["nome", "genero", "novo_salario"]).show()

# Mapeando cada linha do DataFrame usando atributos diretamente, ajustando o formato e dobrando o salário
dsa_rdd = df.rdd.map(lambda x: (x.primeiro_nome + " " + x.sobrenome, x.genero, x.salario * 2)) 

# Convertendo o RDD mapeado de volta para um DataFrame e mostrando o resultado
df4 = dsa_rdd.toDF(["nome", "genero", "novo_salario"]).show()

# Definindo uma função que realiza operações similares ao mapeamento anterior, mas em uma função separada
def dsa_func(x):
    primeiro_nome = x.primeiro_nome
    sobrenome = x.sobrenome
    nome = primeiro_nome + " " + sobrenome
    genero = x.genero.lower()
    salario = x.salario * 2
    return (nome, genero, salario)

# Aplicando a função ao RDD e convertendo o resultado em um DataFrame, depois exibindo
df5 = df.rdd.map(lambda x: dsa_func(x)).toDF().show()

# Outra forma de aplicar a função ao RDD e converter para DataFrame, exibindo o resultado
df6 = df.rdd.map(dsa_func).toDF().show()



