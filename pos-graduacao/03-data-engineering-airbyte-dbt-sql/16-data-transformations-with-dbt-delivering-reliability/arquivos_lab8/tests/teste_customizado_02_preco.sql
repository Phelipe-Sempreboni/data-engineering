-- Testa se o preço está dentro de umm intervalo definido nas regras de negócio
SELECT *
FROM {{ ref('produtos') }}
WHERE preco < 10 OR preco > 5000
