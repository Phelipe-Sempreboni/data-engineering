#### Mapeamento e descrição da estrutura desse diretório e o que fazem:

Diretório: infra/db

.env -> para armazenar as variáveis mais sensíveis como chaves, segredos, senhas, entre outros
    - este arquivo precisa sempre estar dentro do (.gitignore), pois como é um arquivo que normalmente contém senhas, chaves, secrets, usuários e outras informações sensíveis, não deve ser comitado para o Github
    - sempre tome cuidado ao comitar seus arquivos, e valide que nenhum contenha informações sensíveis que possam prejudicar seus projetos

comandos.txt -> possuí os comandos que serão utilizados para manipular o docker, imagens, arquivos
    - este arquivo terá comandos que vão apoiar ao decorrer do aprendizado nesse diretório e ao decorrer da trilha

docker-compose.yml -> para definir, configurar e executar múltiplos containers Docker como um único serviço
    - instalação do banco de dados do sql server
    - instalação dos componentes necessários (sistema operacional, python, aws cli, terraform) a partir do dockerfile.app

dockerfile.app -> contém as configurações para: 
    - atualização dos pacotes do sistema
    - instalação de dependências necessárias
    - instalação de utilitários essenciais
    - instalação do python
    - instalação do aws cli
    - instalação do terraform
    - criação de diretório e mapeamento de volume
    - iniciar o sistema com o prompt de bash

Não é uma boa prática inserir senhas diretamente no arquivo (Dockerfile)
    - mesmo que seja utilizado os comandos de (arg ou env) no arquivo, as senhas ficarão expostas nas layers (docker history) do docker
    - a melhor maneira é utilizar um arquivo (docker compose) nesses casos, jutamente de um arquivo (.env), onde esse terá a variável e senha, e poderá ser inserido no arquivo (.gitignore)

---
