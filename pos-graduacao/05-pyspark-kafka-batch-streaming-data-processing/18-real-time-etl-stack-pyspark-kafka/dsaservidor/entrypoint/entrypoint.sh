#!/bin/bash
set -e

if [ -e "/opt/airflow/requirements.txt" ]; then
  $(command python) pip install --upgrade pip
  $(command -v pip) install --no-cache-dir -r requirements.txt
fi

if [ ! -f "/opt/airflow/airflow.db" ]; then
  airflow db init && \
  airflow users create \
    --username admin \
    --firstname admin \
    --lastname admin \
    --role Admin \
    --email suporte@datascienceacademy.com.br \
    --password dsacademy
fi

$(command -v airflow) db upgrade

exec airflow webserver