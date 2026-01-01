# Projeto 2 - Deploy do Stack de Treinamento Distribuído de Machine Learning com PySpark no Amazon EMR
# Script de Preparação do Ambiente Python

# Download do Miniconda (interpretador da Linguagem Python)
wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
    && /bin/bash ~/miniconda.sh -b -p $HOME/conda

# Configura o miniconda no PATH
echo -e '\nexport PATH=$HOME/conda/bin:$PATH' >> $HOME/.bashrc && source $HOME/.bashrc

# Instala os pacotes via conda
conda install -y boto3 pendulum numpy scikit-learn 

# Instala os pacotes via pip 
pip install --upgrade pip
pip install findspark
pip install pendulum
pip install boto3
pip install numpy
pip install python-dotenv
pip install scikit-learn

# Cria as pastas
mkdir $HOME/pipeline
mkdir $HOME/logs

