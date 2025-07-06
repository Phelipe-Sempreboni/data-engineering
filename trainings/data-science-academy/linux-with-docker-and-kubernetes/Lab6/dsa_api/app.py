# Lab 6 - Deploy de API Para Aplicação de IA com Ollama, Streamlit e Docker Compose

# Importa módulo para acessar variáveis de ambiente
import os

# Importa o framework web FastAPI e classes para tratamento de exceções HTTP
from fastapi import FastAPI, HTTPException

# Importa módulo para realizar requisições HTTP externas
import requests

# Importa BaseModel do Pydantic para validação dos dados recebidos
from pydantic import BaseModel

# Inicializa a aplicação FastAPI
app = FastAPI()

# Define o esquema para o corpo da requisição
class Message(BaseModel):
    message: str

# Define a rota para interagir com a API Ollama
@app.post("/chat")
async def chat(msg: Message):

    # Realiza uma requisição POST para a API Ollama com os parâmetros do usuário
    response = requests.post(
        f"http://{os.getenv('OLLAMA_HOST')}:{os.getenv('OLLAMA_PORT')}/api/chat",
        json={
            "model": "llama3.2:1b",
            "messages": [{"role": "user", "content": msg.message}],
            "stream": False
        }
    )

    # Tenta extrair e retornar o conteúdo da resposta recebida
    try:
        response.raise_for_status()
        data = response.json()
        return {"response": data["message"]["content"]}

    # Trata erros relacionados à requisição HTTP feita ao Ollama
    except requests.exceptions.RequestException as e:
        raise HTTPException(status_code=500, detail=f"Ollama erro: {str(e)}")
        
    # Trata erros relacionados à resposta inválida recebida do Ollama
    except (requests.exceptions.JSONDecodeError, KeyError) as e:
        raise HTTPException(status_code=500, detail=f"Erro ao processar resposta Ollama: {str(e)}")
