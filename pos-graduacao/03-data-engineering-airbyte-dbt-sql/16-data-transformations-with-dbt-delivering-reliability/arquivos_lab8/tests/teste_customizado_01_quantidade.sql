-- Testa se há algum valor maior ou igual a 450 (não permitido de acordo com nossas regras de negócio, por exemplo)
SELECT *
FROM {{ ref('pedidos') }}
WHERE quantidade < 1