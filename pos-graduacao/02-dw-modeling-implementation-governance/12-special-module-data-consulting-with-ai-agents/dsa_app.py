# Módulo Especial de Consultoria na Área de Dados com Agentes de IA
# Projeto Prático Para Consultoria na Área de Dados com Agentes de IA
# Deploy de App Para Day Trade Analytics em Tempo Real com Agentes de IA, Groq, DeepSeek e AWS Para Monetização

# Imports
import re
import streamlit as st
import yfinance as yf
import plotly.graph_objects as go
import plotly.express as px
from phi.agent import Agent
from phi.model.groq import Groq
from phi.tools.yfinance import YFinanceTools
from phi.tools.duckduckgo import DuckDuckGo
from dotenv import load_dotenv

# Carrega o arquivo de variáveis de ambiente
load_dotenv()

########## Analytics ##########

# Usa o cache de dados do Streamlit para armazenar os resultados da função e evitar reprocessamento
# Define a função que extrai dados históricos de uma ação com base no ticker e período especificado
@st.cache_data
def dsa_extrai_dados(ticker, period="6mo"):

    # Cria um objeto Ticker do Yahoo Finance para a ação especificada
    stock = yf.Ticker(ticker)
    
    # Obtém o histórico de preços da ação para o período definido
    hist = stock.history(period=period)
    
    # Reseta o índice do DataFrame para transformar a coluna de data em uma coluna normal
    hist.reset_index(inplace=True)
    
    # Retorna o DataFrame com os dados históricos da ação
    return hist

# Define a função para plotar o preço das ações com base no histórico fornecido
def dsa_plot_stock_price(hist, ticker):
    # Cria um gráfico de linha interativo usando Plotly Express
    # O eixo X representa a data e o eixo Y representa o preço de fechamento das ações
    # O título do gráfico inclui o ticker da ação e o período de análise
    fig = px.line(hist, x="Date", y="Close", title=f"{ticker} Preços das Ações (Últimos 6 Meses)", markers=True)
    
    # Exibe o gráfico no Streamlit
    st.plotly_chart(fig)

# Define a função para plotar um gráfico de candlestick com base no histórico fornecido
def dsa_plot_candlestick(hist, ticker):

    # Cria um objeto Figure do Plotly para armazenar o gráfico
    fig = go.Figure(

        # Adiciona um gráfico de candlestick com os dados do histórico da ação
        data=[go.Candlestick(x=hist['Date'],        # Define as datas no eixo X
                             open=hist['Open'],     # Define os preços de abertura
                             high=hist['High'],     # Define os preços mais altos
                             low=hist['Low'],       # Define os preços mais baixos
                             close=hist['Close'])]  # Define os preços de fechamento
    )
    
    # Atualiza o layout do gráfico, incluindo um título dinâmico com o ticker da ação
    fig.update_layout(title=f"{ticker} Candlestick Chart (Últimos 6 Meses)")
    
    # Exibe o gráfico no Streamlit
    st.plotly_chart(fig)

# Define a função para plotar médias móveis com base no histórico fornecido
def dsa_plot_media_movel(hist, ticker):

    # Calcula a Média Móvel Simples (SMA) de 20 períodos e adiciona ao DataFrame
    hist['SMA_20'] = hist['Close'].rolling(window=20).mean()
    
    # Calcula a Média Móvel Exponencial (EMA) de 20 períodos e adiciona ao DataFrame
    hist['EMA_20'] = hist['Close'].ewm(span=20, adjust=False).mean()
    
    # Cria um gráfico de linha interativo usando Plotly Express
    # Plota os preços de fechamento, a SMA de 20 períodos e a EMA de 20 períodos
    fig = px.line(hist, 
                  x='Date', 
                  y=['Close', 'SMA_20', 'EMA_20'],
                  title=f"{ticker} Médias Móveis (Últimos 6 Meses)",  # Define o título do gráfico
                  labels={'value': 'Price (USD)', 'Date': 'Date'})    # Define os rótulos dos eixos
    
    # Exibe o gráfico no Streamlit
    st.plotly_chart(fig)

# Define a função para plotar o volume de negociação da ação com base no histórico fornecido
def dsa_plot_volume(hist, ticker):

    # Cria um gráfico de barras interativo usando Plotly Express
    # O eixo X representa a data e o eixo Y representa o volume negociado
    fig = px.bar(hist, 
                 x='Date', 
                 y='Volume', 
                 title=f"{ticker} Trading Volume (Últimos 6 Meses)")  # Define o título do gráfico
    
    # Exibe o gráfico no Streamlit
    st.plotly_chart(fig)

########## Agentes de IA ##########

# Agentes de IA 
dsa_agente_web_search = Agent(name="DSA Agente Web Search",
                              role="Fazer busca na web",
                              model=Groq(id="deepseek-r1-distill-llama-70b"),
                              tools=[DuckDuckGo()],
                              instructions=["Sempre inclua as fontes"],
                              show_tool_calls=True, markdown=True)

dsa_agente_financeiro = Agent(name="DSA Agente Financeiro",
                              model=Groq(id="deepseek-r1-distill-llama-70b"),
                              tools=[YFinanceTools(stock_price=True,
                                                   analyst_recommendations=True,
                                                   stock_fundamentals=True,
                                                   company_news=True)],
                              instructions=["Use tabelas para mostrar os dados"],
                              show_tool_calls=True, markdown=True)

multi_ai_agent = Agent(team=[dsa_agente_web_search, dsa_agente_financeiro],
                       model=Groq(id="llama-3.3-70b-versatile"),
                       instructions=["Sempre inclua as fontes", "Use tabelas para mostrar os dados"],
                       show_tool_calls=True, markdown=True)

########## App Web ##########

# Configuração da página do Streamlit
st.set_page_config(page_title="Data Science Academy", page_icon=":100:", layout="wide")

# Barra Lateral com instruções
st.sidebar.title("Instruções")
st.sidebar.markdown("""
### Como Utilizar a App:

- Insira o símbolo do ticker da ação desejada no campo central.
- Clique no botão **Analisar** para obter a análise em tempo real com visualizações e insights gerados por IA.

### Exemplos de tickers válidos:
- MSFT (Microsoft)
- TSLA (Tesla)
- AMZN (Amazon)
- GOOG (Alphabet)

Mais tickers podem ser encontrados aqui: https://stockanalysis.com/list/nasdaq-stocks/

### Finalidade da App:
Este aplicativo realiza análises avançadas de preços de ações da Nasdaq em tempo real utilizando Agentes de IA com modelo DeepSeek através do Groq e infraestrutura AWS para apoio a estratégias de Day Trade para monetização. Uma app completa de exemplo para quem deseja iniciar em Consultoria na Área de Dados e IA.
""")

# Botão de suporte na barra lateral
if st.sidebar.button("Suporte"):
    st.sidebar.write("No caso de dúvidas envie e-mail para: suporte@datascienceacademy.com.br")

# Título principal
st.title(":100: Data Science Academy")

# Interface principal
st.header("Day Trade Analytics em Tempo Real com Agentes de IA")

# Caixa de texto para input do usuário
ticker = st.text_input("Digite o Código (símbolo do ticker):").upper()

# Se o usuário pressionar o botão, entramos neste bloco
if st.button("Analisar"):

    # Se temos o código da ação (ticker)
    if ticker:

        # Inicia o processamento
        with st.spinner("Buscando os Dados em Tempo Real. Aguarde..."):
            
            # Obtém os dados
            hist = dsa_extrai_dados(ticker)
            
            # Renderiza um subtítulo
            st.subheader("Análise Gerada Por IA")
            
            # Executa o time de Agentes de IA
            ai_response = multi_ai_agent.run(f"Resumir a recomendação do analista e compartilhar as últimas notícias para {ticker}")

            # Remove linhas que começam com "Running:"
            # Remove o bloco "Running:" e também linhas "transfer_task_to_finance_ai_agent"
            clean_response = re.sub(r"(Running:[\s\S]*?\n\n)|(^transfer_task_to_finance_ai_agent.*\n?)","", ai_response.content, flags=re.MULTILINE).strip()

            # Imprime a resposta
            st.markdown(clean_response)

            # Renderiza os gráficos
            st.subheader("Visualização dos Dados")
            dsa_plot_stock_price(hist, ticker)
            dsa_plot_candlestick(hist, ticker)
            dsa_plot_media_movel(hist, ticker)
            dsa_plot_volume(hist, ticker)
    else:
        st.error("Ticker inválido. Insira um símbolo de ação válido.")


# Fim
# Obrigado DSA!




