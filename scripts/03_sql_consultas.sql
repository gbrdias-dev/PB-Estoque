-- ============================================================
-- Projeto: P&B Bijuterias
-- Arquivo: 03_dql_consultas.sql
-- SGBD: PostgreSQL
-- Descrição: Consultas estruturadas (DQL) para relatórios e análises
-- ============================================================

-- ============================================================
-- 1. CONSULTAS BÁSICAS (Filtros com LIKE, IN e BETWEEN)
-- ============================================================

-- 1.1. Buscar produtos que possuem termos ligados a "Dourad" na descrição 
-- e cujo preço de venda esteja entre R$ 30,00 e R$ 60,00.
SELECT 
    id, 
    descricao, 
    preco, 
    quantidade
FROM produto
WHERE descricao ILIKE '%Dourad%'
  AND preco BETWEEN 30.00 AND 60.00
ORDER BY preco ASC;

-- 1.2. Listar reposições realizadas por usuários específicos (IDs 1, 2 e 3)
-- durante a primeira quinzena de setembro de 2026.
SELECT 
    id AS id_reposicao, 
    id_produto, 
    id_usuario, 
    valor_compra, 
    data_compra
FROM reposicao
WHERE id_usuario IN (1, 2, 3)
  AND data_compra BETWEEN '2026-09-01' AND '2026-09-15'
ORDER BY data_compra DESC;


-- ============================================================
-- 2. CONSULTAS COM JUNÇÕES (INNER, LEFT e RIGHT JOIN)
-- ============================================================

-- 2.1. [INNER JOIN] Detalhamento completo do catálogo de produtos com nomes 
-- de sua categoria, coleção e fornecedora.
SELECT 
    p.id AS codigo_produto,
    p.descricao AS produto,
    c.nome AS categoria,
    col.nome AS colecao,
    f.nome AS fornecedora,
    p.preco,
    p.quantidade AS estoque_atual
FROM produto p
INNER JOIN categoria c ON p.id_categoria = c.id
INNER JOIN colecao col ON p.id_colecao = col.id
INNER JOIN fornecedora f ON p.id_fornecedora = f.id
ORDER BY p.id;

-- 2.2. [LEFT JOIN] Listar todos os usuários cadastrados e suas respectivas 
-- movimentações de reposição (exibe também usuários que nunca fizeram reposições).
SELECT 
    u.id AS id_usuario,
    u.nome AS responsavel,
    u.email,
    r.id AS id_reposicao,
    r.valor_compra,
    r.data_compra
FROM usuario u
LEFT JOIN reposicao r ON u.id = r.id_usuario
ORDER BY u.nome ASC;

-- 2.3. [RIGHT JOIN] Listar todas as fornecedoras e os produtos vinculados a elas
-- (garante a exibição de todas as fornecedoras na direita, mesmo sem produtos).
SELECT 
    f.id AS id_fornecedora,
    f.nome AS fornecedora,
    f.site_fornecedor,
    p.descricao AS produto_fornecido,
    p.preco,
    p.quantidade
FROM produto p
RIGHT JOIN fornecedora f ON p.id_fornecedora = f.id
ORDER BY f.nome ASC;


-- ============================================================
-- 3. CONSULTAS COM AGREGAÇÕES (COUNT, SUM, AVG + GROUP BY / HAVING)
-- ============================================================

-- 3.1. Resumo de estoque e preços por categoria, filtrando apenas categorias 
-- que possuem estoque total somado igual ou superior a 10 unidades.
SELECT 
    c.nome AS categoria,
    COUNT(p.id) AS total_itens_distintos,
    SUM(p.quantidade) AS unidades_em_estoque,
    ROUND(AVG(p.preco), 2) AS preco_medio_categoria,
    SUM(p.preco * p.quantidade) AS valor_total_estimado_estoque
FROM categoria c
LEFT JOIN produto p ON c.id = p.id_categoria
GROUP BY c.id, c.nome
HAVING SUM(p.quantidade) >= 10
ORDER BY valor_total_estimado_estoque DESC;

-- 3.2. Análise de gastos com reposição por usuário comprador, exibindo apenas
-- usuários cujo valor médio de compra por reposição ultrapasse R$ 100,00.
SELECT 
    u.nome AS usuario_comprador,
    COUNT(r.id) AS qtd_reposicoes,
    SUM(r.valor_compra) AS total_investido,
    ROUND(AVG(r.valor_compra), 2) AS ticket_medio_reposicao
FROM usuario u
INNER JOIN reposicao r ON u.id = r.id_usuario
GROUP BY u.id, u.nome
HAVING AVG(r.valor_compra) > 100.00
ORDER BY total_investido DESC;


-- ============================================================
-- 4. CONSULTA AVANÇADA (VIEW Gerencial + Subconsulta)
-- ============================================================

-- 4.1. [VIEW GERENCIAL] Visão consolidada do desempenho financeiro de estoque 
-- vs. custos históricos de reposição por produto.
CREATE OR REPLACE VIEW vw_relatorio_gerencial_estoque AS
SELECT 
    p.id AS id_produto,
    p.descricao AS produto,
    c.nome AS categoria,
    col.nome AS colecao,
    f.nome AS fornecedora,
    p.preco AS preco_venda_unitario,
    p.quantidade AS qtd_estoque,
    (p.preco * p.quantidade) AS receita_potencial_estoque,
    COUNT(r.id) AS historico_qtd_reposicoes,
    COALESCE(SUM(r.valor_compra), 0.00) AS custo_total_reposicoes,
    ((p.preco * p.quantidade) - COALESCE(SUM(r.valor_compra), 0.00)) AS saldo_projetado,
    MAX(r.data_compra) AS data_ultima_reposicao
FROM produto p
INNER JOIN categoria c ON p.id_categoria = c.id
INNER JOIN colecao col ON p.id_colecao = col.id
INNER JOIN fornecedora f ON p.id_fornecedora = f.id
LEFT JOIN reposicao r ON p.id = r.id_produto
GROUP BY 
    p.id, p.descricao, c.nome, col.nome, f.nome, p.preco, p.quantidade;

-- Consulta na VIEW combinada com Subconsulta:
-- Filtra da visão gerencial apenas os produtos cujo preço unitário está acima da média 
-- geral da loja, ordenando pelo maior saldo projetado.
SELECT 
    id_produto,
    produto,
    categoria,
    fornecedora,
    preco_venda_unitario,
    qtd_estoque,
    receita_potencial_estoque,
    custo_total_reposicoes,
    saldo_projetado,
    data_ultima_reposicao
FROM vw_relatorio_gerencial_estoque
WHERE preco_venda_unitario >= (SELECT AVG(preco) FROM produto)
ORDER BY saldo_projetado DESC;