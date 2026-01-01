# Job do Lab 2

# Imports
from pyspark.sql import SparkSession
from pyspark.ml import Pipeline
from pyspark.ml.feature import VectorAssembler, StringIndexer, OneHotEncoder
from pyspark.ml.classification import LogisticRegression
from pyspark.ml.tuning import ParamGridBuilder, CrossValidator
from pyspark.ml.evaluation import BinaryClassificationEvaluator

# Cria a sessão
spark = SparkSession.builder.appName("Lab2").getOrCreate()

print("Processamento Iniciado. Aguarde...")

# Configura o nível de log
spark.sparkContext.setLogLevel('ERROR')

# Carrega o dataset a partir do HDFS
df_dsa = spark.read.csv("hdfs:///opt/spark/data/dataset.csv", inferSchema=True, header=False)

# Lista com os nomes das colunas
column_names = ["age", "workclass", "fnlwgt", "education", "education_num", "marital_status",
                "occupation", "relationship", "race", "sex", "capital_gain", "capital_loss",
                "hours_per_week", "native_country", "income"]

# Associa os nomes das colunas no dataframe
df_dsa = df_dsa.toDF(*column_names)

# Preenche valores NA com a categoria "Unknown" em algumas colunas
df_dsa = df_dsa.na.fill({"workclass": "Unknown", "occupation": "Unknown", "native_country": "Unknown"})

# Drop dos valores NA
df_dsa = df_dsa.dropna()

# Lista com nome das colunas categóricas
categorical_columns = ["workclass", "education", "marital_status", "occupation", "relationship", "race", "sex", "native_country"]

# Cria indexers para converter colunas de strings em colunas de índices numéricos
indexers = [StringIndexer(inputCol=column, outputCol=column+"_index") for column in categorical_columns]

# Cria encoders para converter índices categóricos em vetores One-Hot Encoding
encoders = [OneHotEncoder(inputCol=column+"_index", outputCol=column+"_vec") for column in categorical_columns]

# Cria um assembler para combinar todas as colunas de recursos em um único vetor de características
assembler = VectorAssembler(inputCols=[c + "_vec" for c in categorical_columns] + ["age", "fnlwgt", "education_num", "capital_gain", "capital_loss", "hours_per_week"], outputCol="features")

# Cria um indexer para a coluna target, transformando-a em rótulos numéricos
labelIndexer = StringIndexer(inputCol="income", outputCol="label")

# Define o pipeline com todas as etapas de processamento
pipeline = Pipeline(stages=indexers + encoders + [assembler, labelIndexer])

# Divide o dataframe em conjuntos de treinamento e teste antes de aplicar o pipeline
dados_treino, dados_teste = df_dsa.randomSplit([0.7, 0.3], seed=42)

# Ajusta o pipeline apenas ao conjunto de dados de treino
pipelineModel = pipeline.fit(dados_treino)

# Aplica as transformações aos dados de treino e teste
dados_treino_transformado = pipelineModel.transform(dados_treino)
dados_teste_transformado = pipelineModel.transform(dados_teste)

# Cria uma instância do algoritmo de regressão logística
modelo_dsa = LogisticRegression(featuresCol="features", labelCol="label")

# Constrói uma grade de parâmetros para otimização, especificando valores para o parâmetro de regularização da regressão logística
modelo_dsa_paramGrid = ParamGridBuilder().addGrid(modelo_dsa.regParam, [0.1, 0.01]).build()

# Cria um avaliador para modelos de classificação binária, configurado para usar a métrica AUC (Área Sob a Curva ROC)
dsa_evaluator = BinaryClassificationEvaluator(metricName="areaUnderROC")

# Configura o validador cruzado com o estimador (regressão logística), a grade de parâmetros, 
# o avaliador e o número de folds
dsa_cv = CrossValidator(estimator = modelo_dsa, 
                        estimatorParamMaps = modelo_dsa_paramGrid, 
                        evaluator = dsa_evaluator, 
                        numFolds = 5,
                        parallelism = 3)

# Treina o modelo de regressão logística usando validação cruzada para encontrar os melhores hiperparâmetros
modelo_dsa_cv = dsa_cv.fit(dados_treino_transformado)

# Aplica o modelo treinado ao conjunto de teste para gerar predições
modelo_dsa_cv_predictions = modelo_dsa_cv.transform(dados_teste_transformado)

# Avalia o desempenho do modelo no conjunto de teste usando a métrica AUC
auc = dsa_evaluator.evaluate(modelo_dsa_cv_predictions)

# Criando um DataFrame com a métrica AUC (Vamos salvar no HDFS no formato CSV)
from pyspark.sql import Row
modelo_dsa_cv_auc_df = spark.createDataFrame([Row(auc=auc)])

# Salvando no HDFS
modelo_dsa_cv.write().overwrite().save("hdfs:///opt/spark/data/modelo")
modelo_dsa_cv_auc_df.write.csv("hdfs:///opt/spark/data/auc", mode="overwrite")

print("Processamento Concluído com Sucesso. Obrigado Por Usar o Cluster da DSA.")

# Fim



