# Lab 8 - Deploy e Orquestração de Aplicação de IA com Docker e Kubernetes

# Imports
import streamlit as st
import joblib
import numpy as np

# Carregar o modelo
modelo_dsa = joblib.load("modelo_dsa.pkl")

# Configuração da página do Streamlit
st.set_page_config(page_title="Data Science Academy", page_icon=":100:", layout="wide")

# Barra lateral com instruções
st.sidebar.title("Instruções")
st.sidebar.write("""
Esta aplicação prevê se uma máquina industrial precisa ou não de manutenção.

Preencha os valores ao lado com os dados atuais da máquina:

- **Temperatura (°C)**
- **Pressão (bar)**
- **Horas de Operação**
- **Vibração (mm/s)**
- **Nível de Ruído (dB)**

Após inserir os valores, clique em **Prever**.
""")

# Botão de suporte na barra lateral
if st.sidebar.button("Suporte"):
    st.sidebar.write("No caso de dúvidas envie e-mail para: suporte@datascienceacademy.com.br")

# Título centralizado
st.title("Data Science Academy")
st.title("Previsão de Manutenção Industrial")

# Campos para entrada dos dados
st.write("Insira os dados da máquina:")

col1, col2 = st.columns(2)

with col1:
    temperatura = st.number_input("Temperatura (°C)", value=25.0)
    pressao = st.number_input("Pressão (bar)", value=1.0)
    horas_operacao = st.number_input("Horas de Operação", value=100.0)

with col2:
    vibracao = st.number_input("Vibração (mm/s)", value=0.5)
    ruido = st.number_input("Nível de Ruído (dB)", value=60.0)

# Botão de previsão
if st.button("Prever"):

    input_array = np.array([[temperatura, pressao, horas_operacao, vibracao, ruido]])
    prediction = modelo_dsa.predict(input_array)
    prediction_proba = modelo_dsa.predict_proba(input_array)[0]

    if prediction[0] == 1:
        st.warning("⚠️ **Manutenção Necessária!**")
    else:
        st.success("✅ **Máquina Operando Normalmente. Não Há Necessidade de Manutenção!**")

    st.subheader("Probabilidade por classe:")
    st.write(f"- **Máquina OK:** {prediction_proba[0]*100:.2f}%")
    st.write(f"- **Manutenção Necessária:** {prediction_proba[1]*100:.2f}%")

