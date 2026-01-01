# DSA Projeto 2 - Script 31 - Variáveis Broadcast e RDD
 
# Imports
import os
from pyspark.sql import SparkSession
from pyspark.sql.functions import broadcast


# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 31 - Variáveis Broadcast e RDD:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script31').getOrCreate()

# Define um dicionário com estados e suas respectivas cidades
cidades = {"RJ":"Cabo Frio", "SP":"Indaiatuba", "MG":"Contagem"}

# Cria uma variável broadcast que será enviada a todos os nós do cluster apenas uma vez
broadcast_variable = spark.sparkContext.broadcast(cidades)

# Define uma lista de tuplas, cada uma representando uma pessoa com nome, sobrenome, país e sigla do estado
dados_dsa = [("Marcelo","Andrade","BRA","SP"),
             ("Isabel","Figueiredo","BRA","RJ"),
             ("Renato","Carvalho","BRA","MG"),
             ("Bianca","Serra","BRA","MG")]

# Cria um RDD a partir da lista de dados
rdd = spark.sparkContext.parallelize(dados_dsa)

# Define uma função que usa a variável broadcast para converter a sigla do estado em nome da cidade
def dsa_converte_dados(code):
    return broadcast_variable.value[code]

# Transforma o RDD original mapeando cada elemento para incluir o nome da cidade ao invés da sigla do estado
resultado = rdd.map(lambda x: (x[0],x[1],x[2],dsa_converte_dados(x[3]))).collect()

# Imprime o resultado 
print(resultado)

# Cria dois DataFrames
df_large = spark.createDataFrame([(1, "A"), (2, "B"), (3, "C")], ["id", "value"])
df_small = spark.createDataFrame([(1, "X"), (2, "Y")], ["id", "label"])

# Realiza um join forçando o uso de broadcast para o DataFrame pequeno
df_joined = df_large.join(broadcast(df_small), "id")

# Mostra o resultado do join
df_joined.show()



# Variáveis broadcast são um mecanismo fornecido pelo Apache Spark para compartilhar eficientemente dados imutáveis 
# em todos os nós do cluster. Em vez de enviar esses dados junto com cada tarefa, o Spark envia uma cópia desses dados 
# para cada nó de trabalhador apenas uma vez, tornando-os disponíveis como uma variável local em cada máquina. 
# Isso reduz significativamente o custo de comunicação e a quantidade de dados transferidos durante o processamento distribuído.

# As variáveis broadcast são especialmente úteis quando uma grande quantidade de dados precisa ser acessada 
# por múltiplas tarefas distribuídas em vários nós, como em operações de join, lookup ou outros cálculos 
# que requerem acesso a dados compartilhados (como tabelas de dimensão em processamentos de data warehouse).

# você pode usar variáveis broadcast com DataFrames no Apache Spark, embora o mecanismo seja um pouco diferente 
# do uso direto de variáveis broadcast com RDDs. Em vez de usar o método broadcast() explicitamente como faria com RDDs, 
# o Spark já otimiza operações de join em DataFrames de forma automática, especialmente em situações onde uma tabela 
# pequena é usada repetidamente em joins com tabelas maiores. Este processo é conhecido como broadcast join.

# Quando você realiza uma operação de join entre dois DataFrames e um deles é significativamente menor que o outro, 
# o Spark pode decidir automaticamente utilizar um broadcast join. Isso significa que ele enviará automaticamente o 
# DataFrame menor para todos os nós de processamento, permitindo que o join seja realizado localmente em cada nó 
# sem a necessidade de shuffles dispendiosos de rede, que são típicos em joins normais de grandes DataFrames distribuídos.


