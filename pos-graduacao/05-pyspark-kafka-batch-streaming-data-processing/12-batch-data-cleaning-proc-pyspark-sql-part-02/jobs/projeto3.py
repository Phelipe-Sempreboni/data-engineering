# Projeto 3 - Pipeline de Limpeza e Transformação Para Aplicações de IA com PySpark SQL

# Imports
import numpy as np
import pyspark.ml.tuning as tune
from pyspark.sql import SparkSession
from pyspark.ml.classification import LogisticRegression
from pyspark.ml.evaluation import BinaryClassificationEvaluator
from pyspark.ml.tuning import ParamGridBuilder, CrossValidator

# Iniciar SparkSession
spark = SparkSession.builder.appName("Projeto3-Exec").getOrCreate()

# Ler os dados de treino e teste a partir de arquivos Parquet
dados_treino = spark.read.parquet('/opt/spark/data/dados_treino.parquet')
dados_teste = spark.read.parquet('/opt/spark/data/dados_teste.parquet')

# Incializa o modelo de Regressão Logística
modelo_dsa_rl = LogisticRegression()

# Cria o avaliador para AUC (Area Under the ROC Curve)
evaluator = BinaryClassificationEvaluator(metricName='areaUnderROC')

# Cria o grid de parâmetros
grid = tune.ParamGridBuilder()

# Adiciona os hiperparâmetros ao grid
grid = grid.addGrid(modelo_dsa_rl.regParam, np.arange(0, .1, .01))
grid = grid.addGrid(modelo_dsa_rl.elasticNetParam, [0,1])

# Constrói o grid
grid = grid.build()

# Cria o CrossValidator
cv = tune.CrossValidator(estimator = modelo_dsa_rl,
                         estimatorParamMaps = grid,
                         evaluator = evaluator) 

# Treina os modelos com validação cruzada
modelos = cv.fit(dados_treino)

# Extrai o melhor modelo
best_lr = modelos.bestModel

# Faz previsões no conjunto de teste
test_results = best_lr.transform(dados_teste)

# Avalia as previsões
auc = evaluator.evaluate(test_results)
print(f"AUC (Area Under ROC): {auc}")

# Salva o melhor modelo no disco
best_lr.write().overwrite().save('/opt/spark/data/dsa_melhor_modelo_lr')

