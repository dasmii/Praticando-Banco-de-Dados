--Produtos que custam mais que o preço médio
SELECT *
FROM Produtos
WHERE preco > (SELECT AVG(preco) FROM Produtos);


--Quais clientes tem pet e ja fizeram uma compra
SELECT DISTINCT c.id, c.nome, c.email
FROM clientes c
JOIN pets p ON c.id = p.cliente_id
JOIN vendas v ON c.id = v.cliente_id;

-- Gastou mais que a média
SELECT c.id, c.nome, SUM(v.valor_total) AS total_gasto
FROM clientes c
JOIN vendas v ON c.id = v.cliente_id
GROUP BY c.id, c.nome
HAVING SUM(v.valor_total) > (
    SELECT AVG(total_por_cliente)
    FROM (
        SELECT SUM(valor_total) AS total_por_cliente
        FROM vendas
        GROUP BY cliente_id
    ) sub
);



