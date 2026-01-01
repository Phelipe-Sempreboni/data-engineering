# Lab 5 - Analytics Engineering - Python, SQL e LLM Para Extrair Insights em Pipelines de Engenharia de Dados
# Python - Pipeline de Extração de Insights com LLM

# Imports
import csv
import psycopg2
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_community.llms.ollama import Ollama

# Instanciação do LLM Llama3 através do Ollama
llm = Ollama(model = "llama3")

# Criação do parser para a saída do modelo de linguagem
output_parser = StrOutputParser()

# Função para gerar texto baseado nos dados do PostgreSQL
def dsa_gera_insights():

    # Conecta ao banco de dados PostgreSQL com as credenciais fornecidas
    conn = psycopg2.connect(
        dbname="dsadb",
        user="dsa",
        password="dsa1010",
        host="localhost",
        port="5959"
    )

    # Cria um cursor para executar comandos SQL
    cursor = conn.cursor()
    
    # Define a consulta SQL para obter dados dos clientes, compras e produtos
    query = """
        SELECT 
            c.nome,
            COUNT(p.id_compra) AS total_compras,
            SUM(pr.preco) AS total_gasto
        FROM 
            lab5.clientes c
        JOIN 
            lab5.compras p ON c.id_cliente = p.id_cliente
        JOIN 
            lab5.produtos pr ON p.id_produto = pr.id_produto
        GROUP BY 
            c.nome;
    """
    
    # Executa a consulta SQL
    cursor.execute(query)

    # Obtém todos os resultados da consulta
    rows = cursor.fetchall()
    
    # Inicializa uma lista para armazenar os insights
    insights = []

    # Criação do template de prompt para o chatbot
    prompt = ChatPromptTemplate.from_messages(
        [
            ("system", "Você é um analista de dados especializado. Analise os dados sobre os padrões de compras dos clientes e forneça feedback em português do Brasil."),
            ("user", "question: {question}")
        ]
    )

    # Definição da cadeia de execução: prompt -> LLM -> output_parser
    chain = prompt | llm | output_parser

    # Itera sobre as linhas de resultados
    for row in rows:
        
        # Desempacota os valores de cada linha
        name, total_purchases, total_spent = row
        
        # Cria o prompt para o LLM com base nos dados do cliente
        consulta_cliente = f"Cliente {name} fez {total_purchases} compras totalizando ${total_spent:.2f}."
        
        # Gera o texto de insight usando o LLM
        response = chain.invoke({'question': consulta_cliente})
        
        # Adiciona o texto gerado à lista de insights
        insights.append(response)
    
    # Fecha a conexão com o banco de dados
    conn.close()

    # Salva os insights em um arquivo CSV
    with open('lab5-insights.csv', mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(["Insight"])
        for insight in insights:
            writer.writerow([insight])

    # Retorna a lista de insights
    return insights

# Gera insights chamando a função definida
insights = dsa_gera_insights()

# Imprime cada insight gerado
for insight in insights:
    print(insight)
