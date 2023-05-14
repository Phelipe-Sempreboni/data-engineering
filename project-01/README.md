### Engenharia de Dados com SQLite, Python e CSV.

---

#### Neste projeto é utilizado o SQLite para armazenamento, o Python para ferramenta que realizará o pipeline de dados e o CSV é a fonte de dados, ou seja, o arquivo que contém os dados que serão utilizados.

---

Se você quiser testar esse projeto e verificar seu funcionamento, seguem algumas orientações para uso.

Sobre os arquivos:

_**job-v1.py**_: Este primeiro job importa as bibliotecas, cria uma conexão com o banco de dados do SQLite (caso não exista o banco de dados será criado), cria uma tabela no banco de dados, comita a tabela, encerra a conexão com o banco de dados, realiza a leitura do arquivo em CSV, coloca o arquivo em codificação UFT-8, pula a primeira linha de cabeçalho, conecta novamente no banco de dados, cria um loop for para executar o comando de (insert into) na tabela criada do banco de dados, comita os dados na tabela, encerra a conexão com o banco de dados e informa em tela para o usuário que o job foi concluído.

_**job-v2.py**_: Este segundo job importa as bibliotecas, realiza a leitura do arquivo em CSV, coloca o arquivo em codificação UFT-8, pula a primeira linha de cabeçalho, cria uma conexão com o banco de dados do SQLite (caso não exista o banco de dados será criado), dropa a tabela no banco de dados caso ela exista, cria uma tabela no banco de dados, cria um loop for com uma regra de negócio para executar o comando de (insert into) na tabela criada do banco de dados, comita os dados na tabela, encerra a conexão com o banco de dados e informa em tela para o usuário que o job foi concluído.

_**job-v3.py**_: Este terceiro job importa as bibliotecas, cria uma função para retirar o ponto (.) de valores inteiros, realiza a leitura do arquivo em CSV, coloca o arquivo em codificação UFT-8, pula a primeira linha de cabeçalho, cria uma conexão com o banco de dados do SQLite (caso não exista o banco de dados será criado), dropa a tabela no banco de dados caso ela exista, cria uma tabela no banco de dados, cria um loop for com uma regra de negócio, adiciona no loop for a função de remoção de ponto em determinada coluna e ainda no loop for executa o comando de (insert into) na tabela criada do banco de dados, comita os dados na tabela, encerra a conexão com o banco de dados e informa em tela para o usuário que o job foi concluído.

_**job-v4.py**_: Este quarto job importa as bibliotecas, cria uma função para retirar o ponto (.) de valores inteiros, realiza a leitura do arquivo em CSV, coloca o arquivo em codificação UFT-8, pula a primeira linha de cabeçalho, cria uma conexão com o banco de dados do SQLite (caso não exista o banco de dados será criado), dropa a tabela no banco de dados caso ela exista, cria uma tabela no banco de dados, cria um loop for com uma regra de negócio, adiciona no loop for a função de remoção de ponto em determinada coluna, cria uma nova coluna de margem de lucro com uma regra de negócio, cria uma nova coluna no loop for e ainda no loop for executa o comando de (insert into) na tabela criada do banco de dados, comita os dados na tabela, encerra a conexão com o banco de dados e informa em tela para o usuário que o job foi concluído.

_**job-v5.py**_: Este quinto job importa as bibliotecas, cria uma função para retirar o ponto (.) de valores inteiros, realiza a leitura do arquivo em CSV, coloca o arquivo em codificação UFT-8, pula a primeira linha de cabeçalho, cria uma conexão com o banco de dados do SQLite (caso não exista o banco de dados será criado), dropa a tabela no banco de dados caso ela exista, cria uma tabela no banco de dados, cria um loop for com uma regra de negócio, adiciona no loop for a função de remoção de ponto em determinada coluna, cria uma nova coluna de margem de lucro com uma regra de negócio, arredonda os valores dessa nova coluna, ainda no loop for executa o comando de (insert into) na tabela criada do banco de dados, comita os dados na tabela, encerra a conexão com o banco de dados e informa em tela para o usuário que o job foi concluído.

---

[Acesse meu GitHub :cat:](https://github.com/Phelipe-Sempreboni)

[Acesse meu LinkedIn :computer:](https://www.linkedin.com/in/luiz-phelipe-utiama-sempreboni-319902169/)

---

_Espero ajudar_ :smiley:
