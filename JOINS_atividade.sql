-- 1.
SELECT 
    p.nome AS nome_pet,
    p.especie,
    p.raca,
    c.nome AS nome_dono,
    c.telefone
FROM pets p
INNER JOIN clientes c ON p.cliente_id = c.id;

-- 2. 
SELECT 
    c.nome AS nome_cliente,
    v.data_venda,
    p.nome AS nome_produto,
    iv.quantidade,
    iv.preco_unitario,
    (iv.quantidade * iv.preco_unitario) AS subtotal
FROM vendas v
JOIN clientes c ON v.cliente_id = c.id
JOIN itens_venda iv ON v.id = iv.venda_id
JOIN produtos p ON iv.produto_id = p.id
ORDER BY v.data_venda DESC;

-- 3. 
SELECT 
    c.id,
    c.nome,
    COALESCE(COUNT(v.id), 0) AS total_compras
FROM clientes c
LEFT JOIN vendas v ON c.id = v.cliente_id
GROUP BY c.id, c.nome
ORDER BY total_compras DESC;

-- 4.
SELECT 
    p.id,
    p.nome,
    COALESCE(SUM(iv.quantidade), 0) AS unidades_vendidas
FROM produtos p
LEFT JOIN itens_venda iv ON p.id = iv.produto_id
GROUP BY p.id, p.nome
ORDER BY unidades_vendidas DESC;
