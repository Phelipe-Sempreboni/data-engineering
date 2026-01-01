-- Testa se o campo de e-mail contém o caracter @
SELECT *
FROM {{ ref('clientes') }}
WHERE email NOT LIKE '%@%'