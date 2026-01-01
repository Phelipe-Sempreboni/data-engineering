provider "google" {
  project     = "modelagem-dw-lab1"
  region      = "us-west1"
}

resource "google_bigquery_dataset" "dsa_dataset" {
  dataset_id                  = "dsa_dw_dataset"
  friendly_name               = "DSA Lab 1"
  description                 = "Lab 1 do Curso de Modelagem de DW"
  location                    = "US"
}

resource "google_bigquery_table" "dsa_table_1" {
  deletion_protection = false
  dataset_id          = google_bigquery_dataset.dsa_dataset.dataset_id
  table_id            = "tbClienteDSA"

  schema = jsonencode([
    {
      "name": "tbClienteDSA_id",
      "type": "INTEGER",
      "mode": "REQUIRED"
    },
    {
      "name": "Nome_Cliente",
      "type": "STRING",
      "mode": "REQUIRED"
    },
    {
      "name": "Tipo_Cliente",
      "type": "STRING",
      "mode": "REQUIRED"
    }
  ])
}

resource "google_bigquery_table" "dsa_table_2" {
  deletion_protection = false
  dataset_id          = google_bigquery_dataset.dsa_dataset.dataset_id
  table_id            = "tbProdutoDSA"

  schema = jsonencode([
    {
      "name": "tbProdutoDSA_id",
      "type": "INTEGER",
      "mode": "REQUIRED"
    },
    {
      "name": "Nome_Produto",
      "type": "STRING",
      "mode": "REQUIRED"
    },
    {
      "name": "Categoria_Produto",
      "type": "STRING",
      "mode": "REQUIRED"
    }
  ])
}

resource "google_bigquery_table" "dsa_table_3" {
  deletion_protection = false
  dataset_id          = google_bigquery_dataset.dsa_dataset.dataset_id
  table_id            = "tbFatoDSA"

  schema = jsonencode([
    {
      "name": "fato_id",
      "type": "INTEGER",
      "mode": "REQUIRED"
    },
    {
      "name": "tbClienteDSA_id",
      "type": "INTEGER",
      "mode": "REQUIRED"
    },
    {
      "name": "tbProdutoDSA_id",
      "type": "INTEGER",
      "mode": "REQUIRED"
    },
    {
      "name": "valor_venda",
      "type": "FLOAT",
      "mode": "REQUIRED"
    },
    {
      "name": "data",
      "type": "TIMESTAMP",
      "mode": "REQUIRED"
    }
  ])
}

resource "random_string" "random_id" {
  length  = 8
  special = false
  upper   = false
}

resource "google_bigquery_job" "job_sql_1" {
  job_id = "dsa_job_${random_string.random_id.result}_1"

  labels = {
    "dsa_job" = "job_sql_1"
  }

  load {
    source_uris = [
      "gs://dsa-modeling-p1/tbClienteDSA.csv",
    ]

    destination_table {
      project_id = google_bigquery_table.dsa_table_1.project
      dataset_id = google_bigquery_table.dsa_table_1.dataset_id
      table_id   = google_bigquery_table.dsa_table_1.table_id
    }

    skip_leading_rows = 1
    schema_update_options = ["ALLOW_FIELD_RELAXATION", "ALLOW_FIELD_ADDITION"]
    write_disposition = "WRITE_APPEND"
    autodetect = true
  }
}

resource "google_bigquery_job" "job_sql_2" {
  job_id = "dsa_job_${random_string.random_id.result}_2"

  labels = {
    "dsa_job" = "job_sql_2"
  }

  load {
    source_uris = [
      "gs://dsa-modeling-p1/tbProdutoDSA.csv",
    ]

    destination_table {
      project_id = google_bigquery_table.dsa_table_2.project
      dataset_id = google_bigquery_table.dsa_table_2.dataset_id
      table_id   = google_bigquery_table.dsa_table_2.table_id
    }

    skip_leading_rows = 1
    schema_update_options = ["ALLOW_FIELD_RELAXATION", "ALLOW_FIELD_ADDITION"]
    write_disposition = "WRITE_APPEND"
    autodetect = true
  }
}

resource "google_bigquery_job" "job_sql_3" {
  job_id = "dsa_job_${random_string.random_id.result}_3"

  labels = {
    "dsa_job" = "job_sql_3"
  }

  load {
    source_uris = [
      "gs://dsa-modeling-p1/tbFatoDSA.csv",
    ]

    destination_table {
      project_id = google_bigquery_table.dsa_table_3.project
      dataset_id = google_bigquery_table.dsa_table_3.dataset_id
      table_id   = google_bigquery_table.dsa_table_3.table_id
    }

    skip_leading_rows = 1
    schema_update_options = ["ALLOW_FIELD_RELAXATION", "ALLOW_FIELD_ADDITION"]
    write_disposition = "WRITE_APPEND"
    autodetect = true
  }
}

