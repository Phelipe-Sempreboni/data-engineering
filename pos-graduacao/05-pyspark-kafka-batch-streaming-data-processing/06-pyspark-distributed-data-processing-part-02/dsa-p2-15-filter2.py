# DSA Projeto 2 - Script 15 - Mais Filtros

# Imports
import os
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, ArrayType

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 15 - Mais Filtros:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script15').getOrCreate()

# Cria dados de exemplo
dados_dsa = [
        (("Jonas","","Soares"),["Java","Scala","C++"],"SP","M"),
        (("Clara","Rose",""),["Spark","Java","C++"],"RJ","F"),
        (("Marcela","","Teixeira"),["Rust","Go"],"SP","F"),
        (("Roberto","Vasconcelos","Souza"),["Rust","Go"],"RJ","M"),
        (("Alice","Telles","Morgan"),["Rust","Go"],"RJ","M"),
        (("Luiz","Duarte","Oliveira"),["Python","Go"],"SP","M")
        ]
        
# Define o schema
schema_dados_dsa = StructType([
        StructField('nome', StructType([
             StructField('primeironome', StringType(), True),
             StructField('nomedomeio', StringType(), True),
             StructField('sobrenome', StringType(), True)
             ])),
         StructField('linguagens', ArrayType(StringType()), True),
         StructField('estado', StringType(), True),
         StructField('genero', StringType(), True)
         ])

# Cria o dataframe com a definição do schema
df = spark.createDataFrame(data = dados_dsa, schema = schema_dados_dsa)

# Mostra o DataFrame sem truncar os valores (para visualização completa)
print("Dataframe Completo:")
df.show(truncate=False)

# Cria uma lista de estados
lista_estados_dsa = ["SP","MG","ES"]

print("Mais Filtros:")

# Filtra as linhas do DataFrame onde o valor da coluna 'estado' está na lista 'lista_estados_dsa'
df.filter(df.estado.isin(lista_estados_dsa)).show(truncate=False)

# Filtra as linhas do DataFrame onde o valor da coluna 'estado' NÃO está na lista 'lista_estados_dsa'
df.filter(~df.estado.isin(lista_estados_dsa)).show(truncate=False)

# Filtra as linhas do DataFrame onde o estado é "SP" e o gênero é "M", exibindo os resultados sem truncar os valores
df.filter((df.estado == "SP") & (df.genero == "M")).show(truncate=False)

# Tentativa de filtrar linhas baseadas no início do nome, mas resulta em erro devido ao acesso incorreto ao campo 'nome'
# df.filter(df.nome.startswith("M")).show()

# Filtra as linhas onde o primeiro nome começa com "M"
df.filter(df.nome.primeironome.startswith("M")).show(truncate=False)

# Filtra as linhas onde o primeiro nome termina com "a"
df.filter(df.nome.primeironome.endswith("a")).show(truncate=False)

# Filtra as linhas onde o sobrenome é igual a "Oliveira", exibindo os resultados sem truncar os valores
df.filter(df.nome.sobrenome == "Oliveira").show(truncate=False)

# Cria dados de exemplo
dados_dsa2 = [(1,"James Smith"), 
              (2,"Michael Rose"), 
              (3,"Lucas Martins"), 
              (4,"Marcelo Carvalho"), 
              (5,"Marcelo carvalho")]

# Cria o dataframe com a definição do schema
df2 = spark.createDataFrame(data = dados_dsa2, schema = ["id","nome"])

print("Outros Filtros:")

# Filtra linhas onde o campo 'nome' começa com "L"
df2.filter(df2.nome.like("L%")).show(truncate=False)

# Filtra linhas onde o campo 'nome' contém a substring "carvalho" em qualquer parte do texto
df2.filter(df2.nome.like("%carvalho%")).show(truncate=False)

# Filtra linhas onde o campo 'nome' corresponde à expressão regular que identifica nomes 
# que terminam com "carvalho", ignorando diferenças entre maiúsculas e minúsculas. 
df2.filter(df2.nome.rlike("(?i).*carvalho$")).show(truncate=False)






