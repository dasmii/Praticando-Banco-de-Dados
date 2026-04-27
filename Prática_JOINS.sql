--  Lista pets com nome do dono
SELECT p.id AS pet_id,
       p.nome AS pet_nome,
       c.nome AS dono_nome
FROM pets p
JOIN clientes c ON p.cliente_id = c.id;

-- Mostra produtos mais caros que a média
SELECT *
FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos);

--  Total por venda, com o Id da venda, o nome do cliente e o total de vendas
SELECT v.id AS venda_id,
       c.nome AS cliente_nome,
       v.valor_total
FROM vendas v
JOIN clientes c ON v.cliente_id = c.id;
