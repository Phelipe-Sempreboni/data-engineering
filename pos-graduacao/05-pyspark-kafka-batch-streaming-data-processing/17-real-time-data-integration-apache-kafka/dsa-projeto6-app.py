# Projeto 6 - Monitoramento de Criptomoedas em Tempo Real com Kafka, MongoDB e Streamlit

# Imports
import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from pymongo import MongoClient
from configparser import RawConfigParser
import warnings
warnings.filterwarnings('ignore')

# Configurações da página do Streamlit
st.set_page_config(page_title = "Monitoramento de Criptomoedas", page_icon = ":100:", layout = "wide")

# Título principal
st.title("📈 Monitoramento de Criptomoedas em Tempo Real")

# Barra lateral para navegação
st.sidebar.header("DSA Projeto 6")
st.sidebar.markdown("Selecione a criptomoeda desejada para personalizar a visualização.")

# Leitura das configurações
config_local = RawConfigParser()
config_local.read("dsa_config.conf")

# Conexão com o MongoDB
try:
    st.sidebar.text("Conectando ao MongoDB...")
    client = MongoClient(config_local['MongoDB']['url'])
    db = client[config_local['MongoDB']['database']]
    collection = db[config_local['MongoDB']['collection']]
    st.sidebar.success("Conectado ao MongoDB com sucesso!")
except Exception as e:
    st.sidebar.error(f"Falha ao conectar ao MongoDB: {e}")
    st.stop()

# Leitura de dados do MongoDB
data_list = []
query = {"timestamp": 1, "data.name": 1, "data.priceUsd": 1, "_id": 0}

try:
    documents = collection.find({}, query)
    for doc in documents:
        timestamp = doc.get("timestamp")
        if "data" in doc:
            for data_item in doc["data"]:
                data_list.append({
                    "timestamp": timestamp,
                    "name": data_item["name"],
                    "price": round(float(data_item["priceUsd"]), 3)
                })
except Exception as e:
    st.error(f"Erro ao buscar dados do MongoDB: {e}")
    st.stop()

# Criar DataFrame
df = pd.DataFrame(data_list)
if df.empty:
    st.warning("Nenhum dado encontrado no banco de dados.")
    st.stop()

# Seleção de criptomoeda na barra lateral
currencies = df['name'].unique()
selected_currency = st.sidebar.selectbox("Selecione uma criptomoeda", currencies)

# Filtrar dados para a criptomoeda selecionada
df1 = df[df['name'] == selected_currency].copy()

# Converter timestamp para datetime
df1['timestamp'] = pd.to_datetime(df1['timestamp'])
df1['time'] = df1['timestamp'].dt.strftime('%Y-%m-%d %H:%M:%S')

# Criar o gráfico
fig, ax = plt.subplots(figsize=(20, 6))
sns.lineplot(data = df1, 
             x = 'time', 
             y = 'price', 
             marker = 'o', 
             color = 'green', 
             label = selected_currency, 
             errorbar = None, 
             ax = ax)
ax.legend(title = "Criptomoeda")
ax.set_xticklabels(df1['time'], rotation = 45, ha = 'right')
ax.set_xlabel('Timestamp')
ax.set_ylabel('Preço (USD)')
ax.set_title(f'Cotação de {selected_currency} ao Longo do Tempo')

# Exibir o gráfico
st.pyplot(fig)

# Visualização dos dados
st.subheader("Prévia dos Dados")
st.write("Visualize os 10 primeiros registros dos dados processados:")
st.dataframe(df1.head(10))






