# Lab 8 - Deploy e Orquestração de Aplicação de IA com Docker e Kubernetes

# Imports
import joblib
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

# Gerar dados fictícios com valores realistas
np.random.seed(42)

temperatura = np.random.uniform(20, 100, 1250)        # 20-100 °C
pressao = np.random.uniform(1, 10, 1250)              # 1-10 bar
horas_operacao = np.random.uniform(10, 1000, 1250)    # 10-1000 horas
vibracao = np.random.uniform(0.1, 10, 1250)           # 0.1-10 mm/s
ruido = np.random.uniform(50, 120, 1250)              # 50-120 dB

# Criar uma variável alvo baseada nas variáveis acima (para simular manutenção necessária ou não)
manutencao = ((temperatura > 80) | (pressao > 8) | (vibracao > 7) | (ruido > 90)).astype(int)

# Preparar dataset
X = pd.DataFrame({
    "temperatura": temperatura,
    "pressao": pressao,
    "horas_operacao": horas_operacao,
    "vibracao": vibracao,
    "ruido": ruido
})

y = manutencao

# Dividir em treino e teste
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Criar e treinar o modelo
model = RandomForestClassifier(random_state=42)
model.fit(X_train, y_train)

# Avaliar o modelo
predictions = model.predict(X_test)
accuracy = accuracy_score(y_test, predictions)
print(f"Acurácia: {accuracy:.2f}")

# Salvar o modelo ajustado
joblib.dump(model, "modelo_dsa.pkl")
