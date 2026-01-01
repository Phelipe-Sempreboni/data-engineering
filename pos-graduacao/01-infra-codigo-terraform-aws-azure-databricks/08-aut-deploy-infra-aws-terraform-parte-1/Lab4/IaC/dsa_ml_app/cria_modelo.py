# Lab 4 - Deploy de Infraestrutura e API Para Aplicação de Data Science na AWS com Terraform
# Criação do Modelo de Machine Learning
# Modelo de Classificação - Considerando o valor das 4 compras anteriores de um cliente, prever se ele vai realizar outra compra (Sim/Não)

# Imports
import pandas as pd
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
import joblib

# Geração de um conjunto de dados fictício
X, y = make_classification(n_samples = 1000, n_features = 4, random_state = 42)

# Dividindo os dados em conjuntos de treino e teste
X_treino, X_teste, y_treino, y_teste = train_test_split(X, y, test_size = 0.2, random_state = 42)

# Criando e treinando o modelo de regressão logística
modelo_dsa = LogisticRegression()
modelo_dsa.fit(X_treino, y_treino)

# Avaliando o modelo
predictions = modelo_dsa.predict(X_teste)
accuracy = accuracy_score(y_teste, predictions)
print(f"Acurácia do Modelo: {accuracy:.2f}")

# Salvando o modelo
joblib.dump(modelo_dsa, 'modelo_dsa_treinado.pkl')
