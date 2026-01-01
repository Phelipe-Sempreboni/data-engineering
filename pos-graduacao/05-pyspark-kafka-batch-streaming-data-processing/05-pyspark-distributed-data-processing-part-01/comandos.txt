# Execução dos scripts do Capítulo 5:

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-00-teste-log.py

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-01-distinct.py

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-02-add-new-column.py

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-03-add-month.py

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-04-expr.py

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-05-arraytype.py

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-06-array-string.py

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-07-create-dataframe-dictionary.py

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-08-show-top-n-rows.py

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-09-sampling.py

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-10-row.py

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-11-aggregate-stats.py

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-12-convert-map-to-columns.py

docker exec dsa-pyspark-master spark-submit --deploy-mode client ./apps/dsa-p2-13-convert_columns-to-map.py
