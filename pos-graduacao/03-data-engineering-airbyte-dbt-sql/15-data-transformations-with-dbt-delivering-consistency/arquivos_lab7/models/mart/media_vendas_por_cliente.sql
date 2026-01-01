SELECT c.cliente_id,
       c.nome,
       c.estado,
       {{ calcular_media_vendas('v.valor') }} AS media_vendas
FROM {{ ref('clientes') }} c
JOIN {{ ref('vendas') }} v
ON c.cliente_id = v.cliente_id
WHERE c.estado IN ('SP', 'RJ')
GROUP BY c.cliente_id, c.nome, c.estado