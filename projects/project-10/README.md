#### Teremos a divisão dessa trilha em alguns tópicos de discussão e aprendizado, sendo:
   - Infraestrutura local para desenvolvimento, teste e homologação:
      - segurança:
         - usuários e grupos de acesso
         - armazenamento de senhas
         - variáveis e dados sensíveis
         - registry do docker
         - Docker Hub
         - Imagens oficiais
         - Imagens não oficiais
      - boas práticas
         - em ambientes - desenvolvimento, homologação e produção
    - 11. Construção e deploy do ambiente local com Docker para a Cloud na AWS e Azure
    - 12. Demonstração da plataforma

---

1. Criação do dockerfile.app com:
   - SQL Server local
   - Terraform
   - AWS CLI
   - Python
   - Ferramentas Linux essenciais: wget, unzip, openssh, iputils-ping, vim
   - Boa prática: imagem leve, performática e com ponto de entrada via /bin/bash
   - Mapeamento de volumes locais

2. Criação do dockerfile.flow com:
   - Apache Airflow
   - Mesmo stack de ferramentas do dockerfile.app + Apache Airflow

3. docker-compose.yml para orquestração:
   - Container 1: SQL Server
   - Container 2: Apache Airflow
   - Container 3: Python, AWS CLI e Terraform
   - Comunicação entre os três via rede interna no Docker
   - Mapeamento de volumes locais

---

4. Versionamento de código com GitHub e CI/CD com GitHub Actions:
   - Build automático das imagens
   - Execução de testes unitários
   - Deploy e recriação dos containers

5. Criação de ETL em Python para:
   - Ingestão de dados abertos do Gov.br para o SQL Server
   - Validação de schema/tabelas (testes unitários)
   - Organização modular seguindo boas práticas de Clean Code e SOLID

6. Integração com Apache Airflow:
   - Orquestração do pipeline de ingestão e testes
   - Job DAGs organizados e legíveis (SoC e modularidade)

7. Aplicação de framework de Qualidade de Dados:
   - DQX e Great Expectations para comparação
   - Escolha do mais completo com base nos critérios técnicos
   - Scripts e validações reais

8. docker-compose final:
   - Orquestração dos três ambientes
   - Infraestrutura como código (IaC)

9. Desenho da arquitetura geral do projeto

10. Estrutura de diretórios e repositórios (com boas práticas)

11. Avaliação crítica do projeto (notas, sugestões e recomendações)

---

Ao decorrer dessa trilha, também falaremos sobre conceitos e boas práticas de Engenharia de Dados, Engenharia de Analytics, Engenharia de Software e Clean Code, como:

| Área                             | Aplicação no Projeto                                                              |
| -------------------------------- | --------------------------------------------------------------------------------- |
| **SOLID**                        | Separação dos scripts de ETL, testes e execução em módulos reutilizáveis          |
| **SoC (Separation of Concerns)** | Cada container tem uma única responsabilidade: banco ou orquestrador              |
| **IaC (Infrastructure as Code)** | Dockerfiles, docker-compose.yml e scripts Terraform seguem padrão declarativo     |
| **Modularidade**                 | Pastas bem organizadas (ex: `/etl`, `/infra`, `/tests`, `/dags`, `/expectations`) |
| **Clean Code**                   | Nome de arquivos e funções claros, comentários apenas quando necessário           |
| **Reusabilidade**                | Frameworks de testes e transformações reaproveitáveis entre datasets              |
| **Performance e Leveza**         | Imagens otimizadas, ferramentas mínimas e foco em shell-script enxuto             |
| **CI/CD com GitHub Actions**     | Automatização de testes, build e deploy com base em práticas DevOps modernas      |

---
