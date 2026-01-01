# DSA Projeto 2 - Script 26 - Withcolumn

# Veja o ebook complementar no Capítulo 6 do curso.

# Imports
import os
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, lit
from pyspark.sql.types import StructType, StructField, StringType,IntegerType

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 26 - Withcolumn:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script26').getOrCreate()

# Cria uma lista de tuplas contendo dados pessoais
dados_dsa = [('Lucas','','Gomes','1991-04-01','M',3000),
             ('Rafael','Almeida','','2000-05-19','M',4000),
             ('Bruno','','Silva','1978-09-05','M',4000),
             ('Eduarda','Pires','Barros','1967-12-01','F',4000),
             ('Isabela','Cristina','Souza','1980-02-17','F',-1)]

# Define os nomes das colunas para o DataFrame
colunas = ["primeironome", "nomedomeio", "sobrenome", "nascimento", "genero", "salario"]

# Cria um DataFrame com os dados e os nomes de colunas especificados
df = spark.createDataFrame(data = dados_dsa, schema = colunas)

# Imprime o esquema do DataFrame para visualizar sua estrutura
df.printSchema()

# Exibe o DataFrame completo sem truncar os dados
df.show(truncate=False)

# Converte a coluna 'salario' para o tipo Integer
df2 = df.withColumn("salario",col("salario").cast("Integer"))

# Imprime o esquema do DataFrame após a conversão de tipo
df2.printSchema()

# Exibe o DataFrame com a coluna 'salario' convertida para Integer
df2.show(truncate=False)

# Multiplica o valor da coluna 'salario' por 100
df3 = df.withColumn("salario",col("salario")*100)

# Imprime o esquema do DataFrame após a operação matemática
df3.printSchema()

# Exibe o DataFrame após a multiplicação
df3.show(truncate=False)

# Cria uma nova coluna 'CopiedColumn' copiando e invertendo o sinal da coluna 'salario'
df4 = df.withColumn("CopiedColumn",col("salario")* -1)

# Imprime o esquema do DataFrame com a nova coluna
df4.printSchema()

# Adiciona uma coluna constante 'Country' com o valor "USA"
df5 = df.withColumn("Country", lit("USA"))

# Imprime o esquema do DataFrame após adicionar a coluna constante
df5.printSchema()

# Adiciona duas colunas constantes, 'Country' com "USA" e 'anotherColumn' com "anotherValue"
df6 = df.withColumn("Country", lit("USA")) \
   .withColumn("anotherColumn",lit("anotherValue"))

# Imprime o esquema do DataFrame após adicionar as duas colunas constantes
df6.printSchema()

# Renomeia a coluna 'genero' para 'sex' e mostra o DataFrame com o novo nome de coluna
df.withColumnRenamed("genero","sex").show(truncate=False)

# Exclui a coluna 'CopiedColumn' do df4 e mostra o DataFrame resultante
df4.drop("CopiedColumn").show(truncate=False)

# Cria uma lista de tuplas com dados estruturados
dataStruct = [(("James","","Smith"),"36636","M","3000"), \
              (("Michael","Rose",""),"40288","M","4000"), \
              (("Robert","","Williams"),"42114","M","4000"), \
              (("Maria","Anne","Jones"),"39192","F","4000"), \
              (("Jen","Mary","Brown"),"","F","-1")]

# Define um esquema complexo com tipos aninhados para o DataFrame
schemaStruct = StructType([
        StructField('name', StructType([
             StructField('primeironome', StringType(), True),
             StructField('nomedomeio', StringType(), True),
             StructField('sobrenome', StringType(), True)
             ])),
          StructField('nascimento', StringType(), True),
         StructField('genero', StringType(), True),
         StructField('salario', StringType(), True)
         ])

# Cria um DataFrame com dados estruturados e esquema especificado
df7 = spark.createDataFrame(data = dataStruct, schema = schemaStruct)

# Imprime o esquema do novo DataFrame para visualizar a estrutura de colunas aninhadas
df7.printSchema()

# Exibe o DataFrame com a estrutura de dados complexa
df7.show(truncate=False)


