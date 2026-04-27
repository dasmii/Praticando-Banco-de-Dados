-- 1.
SELECT DISTINCT c.id, c.nome
FROM clientes c
WHERE c.id IN (
    SELECT v.cliente_id
    FROM vendas v
    JOIN itens_venda iv ON v.id = iv.venda_id
    JOIN produtos p ON iv.produto_id = p.id
    WHERE p.descricao ILIKE '%ração%'
);

-- 2. compra por cliente > 200
WITH media_compras AS (
    SELECT v.cliente_id, AVG(v.valor_total) AS media_valor
    FROM vendas v
    GROUP BY v.cliente_id
)
SELECT c.id, c.nome, mc.media_valor
FROM clientes c
JOIN media_compras mc ON c.id = mc.cliente_id
WHERE mc.media_valor > 200;

-- 3. 
SELECT p.id, p.nome, total_vendido
FROM (
    SELECT iv.produto_id, SUM(iv.quantidade) AS total_vendido
    FROM itens_venda iv
    GROUP BY iv.produto_id
) sub
JOIN produtos p ON p.id = sub.produto_id
WHERE sub.total_vendido > 2;

-- 4. Top 3 serviços
WITH total_agendamentos AS (
    SELECT a.servico_id, COUNT(*) AS qtd_agendamentos
    FROM agendamentos a
    GROUP BY a.servico_id
)
SELECT s.id, s.nome, ta.qtd_agendamentos
FROM servicos s
JOIN total_agendamentos ta ON s.id = ta.servico_id
ORDER BY ta.qtd_agendamentos DESC
LIMIT 3;

-- 5. 
WITH total_gasto AS (
    SELECT v.cliente_id, SUM(v.valor_total) AS gasto_total
    FROM vendas v
    GROUP BY v.cliente_id
),
media_geral AS (
    SELECT AVG(gasto_total) AS media_gastos
    FROM total_gasto
),
pets_por_cliente AS (
    SELECT cliente_id, COUNT(*) AS qtd_pets
    FROM pets
    GROUP BY cliente_id
)
SELECT c.id, c.nome, tg.gasto_total, pp.qtd_pets
FROM clientes c
JOIN total_gasto tg ON c.id = tg.cliente_id
JOIN media_geral mg ON TRUE
JOIN pets_por_cliente pp ON c.id = pp.cliente_id
WHERE tg.gasto_total > mg.media_gastos
  AND pp.qtd_pets > 1;