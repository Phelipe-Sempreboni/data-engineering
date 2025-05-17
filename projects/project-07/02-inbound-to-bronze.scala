// Databricks notebook source
// MAGIC %md
// MAGIC
// MAGIC # Validar acesso aos dados no datalake

// COMMAND ----------


display(dbutils.fs.ls("/mnt/dados/inbound"))

// COMMAND ----------

// MAGIC %md
// MAGIC
// MAGIC # Criação de caminho (path)

// COMMAND ----------


val path = "dbfs:/mnt/dados/inbound/dados_brutos_imoveis.json"
val dados = spark.read.json(path)

// COMMAND ----------

// MAGIC %md
// MAGIC
// MAGIC # Leitura dos dados

// COMMAND ----------


display(dados)

// COMMAND ----------

// MAGIC %md
// MAGIC
// MAGIC # Remover colunas

// COMMAND ----------


val dados_anuncio = dados.drop("imagens", "usuario")
display(dados_anuncio)

// COMMAND ----------

// MAGIC %md
// MAGIC
// MAGIC # Criando uma coluna de identificação

// COMMAND ----------


import org.apache.spark.sql.functions.col

val df_bronze = dados_anuncio.withColumn("id", col("anuncio.id"))
display(df_bronze)

// COMMAND ----------

// MAGIC %md
// MAGIC
// MAGIC # Salvando os dados na camada bronze

// COMMAND ----------


val path_bronze_01 = "dbfs:/mnt/dados/bronze/dataset_imoveis"
df_bronze.write.format("delta").mode(SaveMode.Overwrite).save(path_bronze_01)

// COMMAND ----------

// MAGIC %md
// MAGIC
// MAGIC # Verificar se dados foram salvos

// COMMAND ----------


display(dbutils.fs.ls("/mnt/dados/bronze/dataset_imoveis/"))
