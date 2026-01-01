SELECT c.cliente_id,
       c.nome,
       c.estado,
       {{ calcular_total_vendas('v.valor') }} AS total_vendas
FROM {{ ref('clientes_sudeste') }} c
JOIN {{ ref('vendas') }} v
ON c.cliente_id = v.cliente_id
GROUP BY c.cliente_id, c.nome, c.estado