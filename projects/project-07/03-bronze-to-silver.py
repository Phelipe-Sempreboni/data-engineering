# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC # Consultar diretório

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC display(dbutils.fs.ls("/mnt/dados/bronze"))

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # Leitura dos dados na camada bronze

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC val path = "dbfs:/mnt/dados/bronze/dataset_imoveis/"
# MAGIC val df = spark.read.format("delta").load(path)
# MAGIC display(df.limit(5))

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # Transformação dos campos json em colunas

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC display(
# MAGIC   df.select("anuncio.*")
# MAGIC   )

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # Diminuindo granularidade da coluna (endereço)

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC display(
# MAGIC   df.select("anuncio.*", "anuncio.endereco.*")
# MAGIC   )

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # Criação de novo dataframe

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC val dados_detalhados = df.select("anuncio.*", "anuncio.endereco.*")
# MAGIC display(dados_detalhados.limit(5))

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # Remover colunas

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC val df_silver = dados_detalhados.drop("caracteristicas", "endereco")
# MAGIC display(df_silver)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # Salvando os dados na camada bronze

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC val path_salvar_camada_silver = "dbfs:/mnt/dados/silver/dataset_imoveis"
# MAGIC df_silver.write.format("delta").mode("overwrite").save(path_salvar_camada_silver)

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # Verificar se dados foram salvos

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC display(dbutils.fs.ls("/mnt/dados/silver/dataset_imoveis/"))

# COMMAND ----------

# MAGIC %md
# MAGIC
# MAGIC # Verificar nome das colunas

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC val columnNames = df_silver.columns
# MAGIC columnNames

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC val columnNames: Array[String] = df_silver.columns
# MAGIC columnNames

# COMMAND ----------

# MAGIC %scala
# MAGIC
# MAGIC columnNames.foreach(println)
