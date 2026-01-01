# Lab 5 - Analytics Engineering - Python, SQL e LLM Para Extrair Insights em Pipelines de Engenharia de Dados
# Python - Pipeline de Criação do Banco de Dados

# Import
import psycopg2

def dsa_executa_script_sql(filename):
    
    # Conecta ao banco de dados PostgreSQL com as credenciais fornecidas
    conn = psycopg2.connect(
        dbname="dsadb",
        user="dsa",
        password="dsa1010",
        host="localhost",
        port="5959"
    )

    # Abre um cursor para realizar operações no banco de dados
    cur = conn.cursor()

    # Lê o conteúdo do arquivo SQL
    with open(filename, 'r') as file:
        sql_script = file.read()

    try:
        # Divide o script em comandos individuais
        sql_commands = sql_script.split(';')

        # Executa cada comando individualmente
        for command in sql_commands:

            # Ignora comandos vazios
            if command.strip():  
                cur.execute(command)

                # Verifica se o comando retorna dados
                if cur.description:  
                    rows = cur.fetchall()
                    for row in rows:
                        print(row)
        
        # Confirma as mudanças no banco de dados
        conn.commit()  
        print("\nScript executado com sucesso.\n")
    except Exception as e:
        
        # Reverte as mudanças em caso de erro
        conn.rollback()  
        print(f"Erro ao executar o script: {e}")
    finally:
        # Fecha a comunicação com o banco de dados
        cur.close()
        conn.close()

# Executa o script SQL
dsa_executa_script_sql('Lab5-04-Consulta.sql')

