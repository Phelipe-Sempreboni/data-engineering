# DSA Projeto 2 - Script 10 - Row

# Imports
import os
from pyspark.sql import SparkSession, Row

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 010 - Row:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script10').getOrCreate()

# Cria uma Row (linha) com valores específicos, sem nomes de campos
row = Row("Zico", 600)

# Imprime os valores da Row, acessando-os por índice
print(row[0] + "," + str(row[1]))
print() 

# Cria uma Row com nomes de campos especificados, usando argumentos nomeados
row2 = Row(nome = "Pele", gols = 1200)

# Imprime o valor do campo 'nome' da segunda Row
print(row2.nome)
print()  

# Define uma Row chamada Person com campos nomeados
Person = Row("nome", "gols")

# Cria instâncias de Person
p1 = Person("Zico", 600)
p2 = Person("Pele", 1200)

# Imprime os nomes das duas instâncias de Person
print(p1.nome + "," + p2.nome)
print() 

# Define dados de exemplo com Rows, incluindo nomes, linguagens e estados
dados_dsa = [Row(nome="Ana Silva",lang=["Python","PHP","C++"],estado="CA"), 
             Row(nome="Jeferson Rosa",lang=["Rust","Python","C++"],estado="NJ"),
             Row(nome="Gabriel Williams",lang=["Julia","Ruby"],estado="NV")]

# Cria um RDD a partir dos dados fornecidos
rdd = spark.sparkContext.parallelize(dados_dsa)

# Coleta os dados do RDD para a memória local
collData = rdd.collect()

# Imprime os dados coletados
print(collData)
print() 

# Itera sobre cada Row no conjunto de dados coletados
for row in collData:
    # Imprime o nome e as linguagens (lang) de cada Row
    print(row.nome + "," + str(row.lang))

print()  

# Define uma nova estrutura Row chamada Person com campos nomeados
Person = Row("nome","lang","estado")

# Cria uma lista de Person com dados específicos
dados_dsa = [Person("Ana Silva",["Python","Ruby","C++"],"CA"), 
             Person("Jeferson Rosa",["Spark","Python","C++"],"NJ"),
             Person("Gabriel Williams",["Rust","PHP"],"NV")]

# Cria um RDD a partir da lista de Person
rdd = spark.sparkContext.parallelize(dados_dsa)

# Coleta os dados do RDD para a memória local
collData = rdd.collect()

# Imprime os dados coletados
print(collData)
print()  

# Itera sobre cada instância de Person no conjunto de dados coletados
for person in collData:
    # Imprime o nome e as linguagens (lang) de cada Person
    print(person.nome + "," +str(person.lang))

print()

# Cria um DataFrame a partir dos dados de Person
df = spark.createDataFrame(dados_dsa)

# Exibe o esquema do DataFrame
df.printSchema()
print()  

# Mostra os dados do DataFrame
df.show()
print()  

# Coleta os dados do DataFrame para a memória local
collData = df.collect()

# Imprime os dados coletados
print(collData)
print()  

# Itera sobre cada Row no conjunto de dados coletados do DataFrame
for row in collData:
    # Imprime o nome e as linguagens (lang) de cada Row
    print(row.nome + "," +str(row.lang))

print()  
    
# Cria uma nova lista de dados, desta vez como tuplas
dados_dsa = [("Ana Silva",["Python","Ruby","C++"],"CA"), 
             ("Jeferson Rosa",["Rust","Python","C++"],"NJ"),
             ("Gabriel Williams",["CSharp","PHP"],"NV")]

# Define novamente os nomes das colunas para o DataFrame
columns = ["nome","linguagem","estado"]

# Cria um novo DataFrame a partir dos dados, atribuindo os nomes das colunas especificados
df = spark.createDataFrame(dados_dsa).toDF(*columns)

# Exibe o esquema do novo DataFrame
df.printSchema()
print()  

# Itera sobre cada Row no DataFrame coletado, imprimindo apenas o nome
for row in df.collect():
    print(row.nome)

print() 


# As Rows são usadas no Spark para organizar os dados de maneira estruturada. Quando você lê dados de uma 
# fonte externa (como um arquivo CSV, JSON, um banco de dados ou qualquer outra fonte de dados suportada pelo Spark), 
# ou quando você transforma dados dentro do Spark, os dados são tipicamente organizados em DataFrames ou Datasets, 
# que são coleções distribuídas de Rows.


