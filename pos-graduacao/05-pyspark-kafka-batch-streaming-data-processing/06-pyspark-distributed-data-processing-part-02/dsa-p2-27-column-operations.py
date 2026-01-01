# DSA Projeto 2 - Script 27 - Operações de Coluna

# Veja o ebook complementar no Capítulo 6 do curso.

# Imports
import os
from pyspark.sql import SparkSession, Row
from pyspark.sql.functions import col

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 27 - Operações de Coluna:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script27').getOrCreate()

# Cria uma lista de tuplas com nome e idade
dsa_dados = [("Eduardo",23), ("Isabela",40)]

# Cria um DataFrame a partir dos dados e renomeia as colunas usando nomes qualificados
df = spark.createDataFrame(dsa_dados).toDF("nome.primeironome", "genero")

# Imprime o esquema do DataFrame para visualizar a estrutura de colunas
df.printSchema()

# Exibe o DataFrame
df.show()

# Seleciona e mostra apenas a coluna 'nome.primeironome' usando uma sintaxe que lida com o ponto no nome da coluna
df.select(col("`nome.primeironome`")).show()

# Outra forma de selecionar e mostrar apenas a coluna 'nome.primeironome' usando a indexação direta com o nome da coluna entre aspas
df.select(df["`nome.primeironome`"]).show()

# Cria uma nova coluna 'new_col' que contém os dois primeiros caracteres de 'nome.primeironome' e mostra o resultado
df.withColumn("new_col", col("`nome.primeironome`").substr(1,2)).show()

# Filtra e mostra as linhas onde 'nome.primeironome' começa com "J"
df.filter(col("`nome.primeironome`").startswith("J")).show()

# Cria um gerador para substituir pontos por sublinhados nos nomes das colunas
new_cols = (column.replace('.', '_') for column in df.columns)

# Cria um novo DataFrame df2 com nomes de colunas modificados substituindo pontos por sublinhados
df2 = df.toDF(*new_cols)

# Mostra o novo DataFrame df2
df2.show()

# Seleciona e mostra a coluna 'genero' usando o objeto coluna diretamente
df.select(df.genero).show()

# Seleciona e mostra a coluna 'genero' usando indexação de string
df.select(df["genero"]).show()

# Seleciona e mostra a coluna 'nome.primeironome' usando indexação de string com o nome qualificado
df.select(df["`nome.primeironome`"]).show()

# Seleciona e mostra a coluna 'genero' usando a função col()
df.select(col("genero")).show()

# Seleciona e mostra a coluna 'nome.primeironome' usando a função col() com nome qualificado
df.select(col("`nome.primeironome`")).show()

# Cria uma lista de objetos Row contendo nome e propriedades adicionais
data = [Row(name="Bruno", prop=Row(nivel="senior", especialidade="Data Science")),
        Row(name="Joana", prop=Row(nivel="pleno", especialidade="Engenharia de Dados"))]

# Cria um DataFrame a partir dos dados com uma coluna 'prop' estruturada
df = spark.createDataFrame(data)

# Imprime o esquema do DataFrame para mostrar a estrutura de colunas aninhadas
df.printSchema()

# Seleciona e mostra a subcoluna 'nivel' dentro da coluna 'prop'
df.select(df.prop.nivel).show()

# Outra forma de selecionar e mostrar a subcoluna 'nivel' usando indexação de string
df.select(df["prop.nivel"]).show()

# Seleciona e mostra a subcoluna 'nivel' usando a função col()
df.select(col("prop.nivel")).show()

# Seleciona e mostra todas as subcolunas dentro de 'prop' usando col("prop.*")
df.select(col("prop.*")).show()

# Cria um DataFrame com três colunas numéricas
data = [(100,2,1),(200,3,4),(300,4,4)]

# Cria um DataFrame e nomeia as colunas
df = spark.createDataFrame(data).toDF("col1","col2","col3")

# Realiza operações aritméticas entre colunas e mostra o resultado de col1 + col2
df.select(df.col1 + df.col2).show()

# Mostra o resultado de col1 - col2
df.select(df.col1 - df.col2).show()

# Mostra o resultado de col1 * col2
df.select(df.col1 * df.col2).show()

# Mostra o resultado de col1 / col2
df.select(df.col1 / df.col2).show()

# Mostra o resultado de col1 % col2 (resto da divisão)
df.select(df.col1 % df.col2).show()

# Realiza comparações entre colunas e mostra o resultado de col2 > col3
df.select(df.col2 > df.col3).show()

# Mostra o resultado de col2 < col3
df.select(df.col2 < df.col3).show()

# Mostra o resultado de col2 == col3 (igualdade)
df.select(df.col2 == df.col3).show()


