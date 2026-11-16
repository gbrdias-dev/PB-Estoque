-- ============================================================
-- Arquivo: 02_dml_insercao.sql
-- Projeto: P&B Bijuterias
-- Banco de dados: PostgreSQL
-- Objetivo: Inserir 5 registros válidos em cada tabela
-- ============================================================

BEGIN;

-- ============================================================
-- 1. USUÁRIO
-- Tabela independente
-- ============================================================

INSERT INTO "usuario" ("nome", "email", "senha") VALUES
('Rogerio', 'rogerio@example.com', 'senha_demo_01'),
('Bruna Lima', 'bruna.lima@example.com', 'senha_demo_02'),
('Gabriel Dias', 'gabriel.dias@example.com', 'senha_demo_03'),
('Gilberto', 'gilberto@example.com', 'senha_demo_04'),
('Luciano Juba', 'luciano.juba@example.com', 'senha_demo_05');


-- ============================================================
-- 2. FORNECEDORA
-- Tabela independente (Inclui o campo 'ativo')
-- ============================================================

INSERT INTO "fornecedora" ("nome", "site_fornecedor", "ativo") VALUES
('Atacado Brilho Dourado', 'https://exemplo.com/fornecedor1', TRUE),
('Elegance Acessórios', 'https://exemplo.com/fornecedor2', TRUE),
('Mundo das Bijuterias', 'https://exemplo.com/fornecedor3', TRUE),
('Cristal Distribuidora', 'https://exemplo.com/fornecedor4', TRUE),
('Império dos Acessórios', 'https://exemplo.com/fornecedor5', FALSE);


-- ============================================================
-- 3. CATEGORIA
-- Tabela independente
-- ============================================================

INSERT INTO "categoria" ("nome") VALUES
('Brincos'),
('Colares'),
('Pulseiras'),
('Anéis'),
('Braceletes');


-- ============================================================
-- 4. COLEÇÃO
-- Tabela independente (Inclui o campo 'ativo')
-- ============================================================

INSERT INTO "colecao" ("nome", "ativo") VALUES
('Clássicos', TRUE),
('Elegance', TRUE),
('Pontos de Luz', TRUE),
('Delicadeza', TRUE),
('Dourados', FALSE);


-- ============================================================
-- 5. PRODUTO
-- Depende de categoria, coleção e fornecedora (Inclui 'ativo')
-- ============================================================

INSERT INTO "produto" (
    "descricao",
    "id_categoria",
    "id_colecao",
    "id_fornecedora",
    "preco",
    "quantidade",
    "url_fornecedor",
    "imagem_produto",
    "ativo"
) VALUES
(
    'Brinco Dourado com Zircônia',
    1, 5, 1,
    49.90,
    10,
    'https://exemplo.com/produto1',
    'https://exemplo.com/imagens/brinco1.jpg',
    TRUE
),
(
    'Colar Três Pontos de Luz',
    2, 3, 2,
    69.90,
    8,
    'https://exemplo.com/produto2',
    'https://exemplo.com/imagens/colar1.jpg',
    TRUE
),
(
    'Pulseira Delicada Dourada',
    3, 4, 3,
    39.90,
    15,
    'https://exemplo.com/produto3',
    'https://exemplo.com/imagens/pulseira1.jpg',
    TRUE
),
(
    'Anel Dourado Elegance',
    4, 2, 4,
    29.90,
    12,
    'https://exemplo.com/produto4',
    'https://exemplo.com/imagens/anel1.jpg',
    TRUE
),
(
    'Bracelete Clássico Dourado',
    5, 1, 5,
    59.90,
    6,
    'https://exemplo.com/produto5',
    'https://exemplo.com/imagens/bracelete1.jpg',
    TRUE
);


-- ============================================================
-- 6. REPOSIÇÃO
-- Depende de produto e usuário (Inclui a coluna 'quantidade')
-- ============================================================

INSERT INTO "reposicao" (
    "id_produto",
    "valor_compra",
    "id_usuario",
    "data_compra",
    "quantidade"
) VALUES
(1, 120.00, 1, '2026-09-01', 10),
(2, 150.00, 2, '2026-09-05', 8),
(3,  90.00, 3, '2026-09-10', 15),
(4,  75.00, 4, '2026-09-15', 12),
(5, 110.00, 5, '2026-09-20', 6);

COMMIT;
