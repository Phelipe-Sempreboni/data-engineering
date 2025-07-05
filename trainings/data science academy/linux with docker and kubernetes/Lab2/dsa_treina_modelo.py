# Lab 2 - Deploy de Aplicação de Machine Learning com Docker e Streamlit

# Imports
import joblib
import pandas as pd
from sklearn.datasets import make_classification
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

# Gerar dados fictícios
X, y = make_classification(n_samples=1250, n_features=5, n_classes=2, random_state=42)

# Dividir em treino e teste
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Criar e treinar o modelo
modelo_dsa = RandomForestClassifier()
modelo_dsa.fit(X_train, y_train)

# Avaliar o modelo
predictions = modelo_dsa.predict(X_test)
accuracy = accuracy_score(y_test, predictions)
print(f"Acurácia: {accuracy:.2f}")

# Salvar o modelo
joblib.dump(modelo_dsa, "modelo_dsa.pkl")
