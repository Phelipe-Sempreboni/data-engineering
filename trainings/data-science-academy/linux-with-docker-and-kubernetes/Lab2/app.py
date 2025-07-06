# Lab 2 - Deploy de Aplicação de Machine Learning com Docker e Streamlit

# Imports
import streamlit as st
import joblib
import numpy as np

# Carregar o modelo
modelo_dsa = joblib.load("modelo_dsa.pkl")

# Configuração da página do Streamlit
st.set_page_config(page_title="Data Science Academy", page_icon=":100:", layout="wide")

st.title("Aplicação Para Previsão Usando ML")

st.write("Insira os valores para previsão:")

# Criar campos para inserir valores
inputs = []
for i in range(1, 6):
    val = st.number_input(f"Atributo {i}", value=0.0)
    inputs.append(val)

# Se clicou no botão executamos o modelo
if st.button("Prever"):
    input_array = np.array(inputs).reshape(1, -1)
    prediction = modelo_dsa.predict(input_array)
    prediction_proba = modelo_dsa.predict_proba(input_array)
    st.write(f"**Classe Prevista:** {prediction[0]}")
    st.write(f"**Probabilidades:** {prediction_proba}")
