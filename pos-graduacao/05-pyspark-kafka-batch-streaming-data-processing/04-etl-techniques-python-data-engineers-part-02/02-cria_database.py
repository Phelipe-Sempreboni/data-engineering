# Projeto 1 - Pipeline PySpark Para Extrair, Transformar e Carregar Arquivos JSON em Banco de Dados

# Import
# pip install sqlite3
import sqlite3

# Conecta ao banco de dados SQLite (cria se o arquivo não existir)
conexao = sqlite3.connect('usuarios.db')

# Cria a tabela
cursor = conexao.cursor()
cursor.execute("""
CREATE TABLE IF NOT EXISTS dsa_usuarios (
    nome TEXT,
    idade INTEGER,
    salario INTEGER,
    cidade TEXT
)
""")

# Grava e fecha a conexão
conexao.commit()
conexao.close()
