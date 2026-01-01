# DSA Projeto 2 - Script 29 - Operações com RDD
 
# Imports
import os
from pyspark.sql import SparkSession
from operator import add

# Ambiente
os.environ['TERM'] = 'xterm'
os.system('clear')

print('\nDSA Projeto 2 - Script 29 - Operações com RDD:\n')

# Cria uma sessão Spark com um nome específico para a aplicação
spark = SparkSession.builder.appName('DSAProjeto2-Script29').getOrCreate()

# Cria outro RDD a partir de uma lista de números, com duplicatas
listRdd = spark.sparkContext.parallelize([1,2,3,4,5])

# Imprime a quantidade de elementos no RDD
print("RDD Count:" + str(listRdd.count()))

# Define uma operação sequencial para agregar elementos do RDD
seqOp = (lambda x, y: x + y)

# Define uma operação combinatória para juntar os resultados das partições
combOp = (lambda x, y: x + y)

# Realiza a agregação do RDD usando as operações definidas
agg = listRdd.aggregate(0, seqOp, combOp)

# Imprime o resultado da agregação
print(agg) # output 15

# Define uma nova operação sequencial para calcular a soma e a contagem
seqOp2 = (lambda x, y: (x[0] + y, x[1] + 1))

# Componentes da Função seqOp2:
# lambda: Indica que uma função anônima está sendo criada.
# x, y: São os parâmetros da função. x é uma tupla, onde x[0] representa um acumulador de soma e x[1] um contador. y é um elemento individual do RDD.
# x[0] + y: Este é o primeiro elemento do resultado da função lambda. Aqui, y (um elemento do RDD) é adicionado a x[0], que é o acumulador que mantém a soma dos elementos processados até agora.
# x[1] + 1: Este é o segundo elemento do resultado da função lambda. Ele representa a operação de incrementar o contador x[1] por um. Isso é usado para contar o número de elementos que foram agregados.

# Define uma nova operação combinatória para juntar somas e contagens de partições
combOp2 = (lambda x, y: (x[0] + y[0], x[1] + y[1]))

# Componentes da Função combOp2:
# lambda: Indica que uma função anônima está sendo definida.
# x, y: São os parâmetros da função. Ambos x e y são tuplas, e cada uma contém dois elementos. O primeiro elemento (x[0] ou y[0]) é um acumulador de soma, enquanto o segundo elemento (x[1] ou y[1]) é um contador.
# x[0] + y[0]: Este é o primeiro elemento do resultado da função lambda. Aqui, o primeiro elemento de cada tupla (ambos representam somas parciais de diferentes partições do RDD) é somado, combinando assim os resultados das agregações parciais em uma soma total.
# x[1] + y[1]: Este é o segundo elemento do resultado da função lambda. Aqui, o segundo elemento de cada tupla (ambos representam contagens de elementos de diferentes partições do RDD) é somado, resultando na contagem total de elementos.

# Realiza a agregação com soma e contagem usando as operações definidas
agg2 = listRdd.aggregate((0, 0), seqOp2, combOp2)

# Imprime o resultado da agregação com soma e contagem
print(agg2) # output (15,5)

# Realiza uma agregação em árvore, que é uma forma mais eficiente de agregação com grandes RDDs
agg2 = listRdd.treeAggregate(0, seqOp, combOp)

# Imprime o resultado da agregação em árvore
print(agg2) # output 15

# Realiza uma operação de fold no RDD que é similar a reduce, mas começa com um valor inicial
foldRes = listRdd.fold(0, add)

# Imprime o resultado do fold
print(foldRes) # output 15

# Realiza uma operação de redução no RDD para somar todos os elementos
redRes = listRdd.reduce(add)

# Imprime o resultado da redução
print(redRes) # output 15

# Define uma função anônima usando expressão lambda para adição
add = lambda x, y: x + y

# Realiza uma redução em árvore, que é mais eficiente em termos de comunicação de rede
redRes = listRdd.treeReduce(add)

# Imprime o resultado da redução em árvore
print(redRes) # output 15

# Coleta todos os elementos do RDD 
dados = listRdd.collect()

# Imprime os dados coletados
print(dados)
