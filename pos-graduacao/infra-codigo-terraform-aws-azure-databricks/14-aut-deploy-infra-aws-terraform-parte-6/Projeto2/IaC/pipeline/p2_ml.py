# Projeto 2 - Deploy do Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR
# Machine Learning

# Instala pacote Python dentro de código Python
import subprocess
comando = "pip install numpy"
subprocess.run(comando.split())

# Imports
import os
import numpy
from pyspark.ml.feature import * 
from pyspark.sql import functions
from pyspark.sql.functions import * 
from pyspark.sql.types import StringType,IntegerType
from pyspark.ml.classification import *
from pyspark.ml.evaluation import *
from pyspark.ml.evaluation import MulticlassClassificationEvaluator
from pyspark.ml.feature import StopWordsRemover
from pyspark.ml.tuning import CrossValidator, ParamGridBuilder
from p2_log import dsa_grava_log
from p2_upload_s3 import dsa_upload_modelos_ml_bucket

# Classe para treinar e avaliar o modelo
def DSATreinaAvaliaModelo(spark, classifier, features, classes, train, test, bucket, nome_bucket, ambiente_execucao_EMR):

    # Método para definir o tipo de classificador
    def FindMtype(classifier):
        M = classifier
        Mtype = type(M).__name__
        return Mtype
    
    # Cria instância da classe
    Mtype = FindMtype(classifier)
    
    # Método para o treinamento do modelo
    def IntanceFitModel(Mtype, classifier, classes, features, train):
        
        if Mtype in("LogisticRegression"):
  
            # Grid de hiperparâmetros para otimização
            paramGrid = (ParamGridBuilder().addGrid(classifier.maxIter, [10, 15, 20]).build())
            
            # Validação cruzada para otimização de hiperparâmetros
            crossval = CrossValidator(estimator = classifier,
                                      estimatorParamMaps = paramGrid,
                                      evaluator = MulticlassClassificationEvaluator(),
                                      numFolds = 2)

            # Cria objeto de treinamento
            fitModel = crossval.fit(train)

            return fitModel
    
    # Treinamento do modelo
    fitModel = IntanceFitModel(Mtype, classifier, classes, features, train)
    
    # Imprime algumas métricas
    if fitModel is not None:

        if Mtype in("LogisticRegression"):
            BestModel = fitModel.bestModel
            dsa_grava_log( Mtype, bucket)
            global LR_coefficients
            LR_coefficients = BestModel.coefficientMatrix.toArray()
            global LR_BestModel
            LR_BestModel = BestModel
        
    # Estabelece colunas da tabela que irá comparar os resultados de cada classificador
    columns = ['Classifier', 'Result']
    
    # Extrai previsões do modelo com dados de teste
    predictions = fitModel.transform(test)
    
    # Cria o avaliador
    MC_evaluator = MulticlassClassificationEvaluator(metricName="accuracy")
    
    # Calcula a acurácia
    accuracy = (MC_evaluator.evaluate(predictions)) * 100
    
    # Registra em log
    dsa_grava_log( "Classificador: " + Mtype + " / Acuracia: " + str(accuracy), bucket)
    
    # Gera o resultado
    Mtype = [Mtype]
    score = [str(accuracy)]
    result = spark.createDataFrame(zip(Mtype,score), schema=columns)
    result = result.withColumn('Result',result.Result.substr(0, 5))
    
    # Caminho para gravar o resultado
    path = f"s3://{nome_bucket}/output/" + Mtype[0] + '_' + train.name if ambiente_execucao_EMR else 'output/' + Mtype[0] + '_' + train.name
    s3_path = 'output/' + Mtype[0] + '_' + train.name
    
    # Grava o resultado no bucket
    dsa_upload_modelos_ml_bucket(fitModel, path , s3_path , bucket, ambiente_execucao_EMR)
    return result

# Função para criar o modelo de Machine Learning
def dsa_cria_modelos_ml(spark, HTFfeaturizedData, TFIDFfeaturizedData, W2VfeaturizedData, bucket, nome_bucket, ambiente_execucao_EMR):

    # Usaremos apenas um classificador, mas é possível incluir outros
    classifiers = [LogisticRegression()] 

    # Lista de atributos
    featureDF_list = [HTFfeaturizedData, TFIDFfeaturizedData, W2VfeaturizedData]

    # Loop por cada atributo
    for featureDF in featureDF_list:

        # Registra em log
        dsa_grava_log( featureDF.name + " Resultados: ", bucket)
        
        # Divisão de treino e teste
        train, test = featureDF.randomSplit([0.7, 0.3],seed = 11)
        
        # Nomes dos atributos
        train.name = featureDF.name
        
        # Atributos no formato Spark (dado de entrada)
        features = featureDF.select(['features']).collect()
        
        # Classes (dado de saída)
        classes = featureDF.select("label").distinct().count()
        
        # Lista de colunas
        columns = ['Classifier', 'Result']
        
        # Lista de termos
        vals = [("Place Holder","N/A")]
        
        # Cria o dataframe
        results = spark.createDataFrame(vals, columns)

        # Loop pela lista de classificadores
        for classifier in classifiers:
            
            # Cria objeto da classe
            new_result = DSATreinaAvaliaModelo(spark,
                                               classifier,
                                               features,
                                               classes,
                                               train,
                                               test, 
                                               bucket, 
                                               nome_bucket, 
                                               ambiente_execucao_EMR)
            
            # Gera o resultado
            results = results.union(new_result)
            results = results.where("Classifier!='Place Holder'")



        