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

INSERT INTO usuario (id, nome, email, senha) VALUES
(1, 'Rogerio', 'rogerio@example.com', 'senha_demo_01'),
(2, 'Bruna Lima', 'bruna.lima@example.com', 'senha_demo_02'),
(3, 'Gabriel Dias', 'gabriel.dias@example.com', 'senha_demo_03'),
(4, 'Gilberto', 'gilberto@example.com', 'senha_demo_04'),
(5, 'Luciano Juba', 'luciano.juba@example.com', 'senha_demo_05');


-- ============================================================
-- 2. FORNECEDORA
-- Tabela independente
-- ============================================================

INSERT INTO fornecedora (id, nome, site_fornecedor) VALUES
(1, 'Atacado Brilho Dourado', 'https://exemplo.com/fornecedor1'),
(2, 'Elegance Acessórios', 'https://exemplo.com/fornecedor2'),
(3, 'Mundo das Bijuterias', 'https://exemplo.com/fornecedor3'),
(4, 'Cristal Distribuidora', 'https://exemplo.com/fornecedor4'),
(5, 'Império dos Acessórios', 'https://exemplo.com/fornecedor5');


-- ============================================================
-- 3. CATEGORIA
-- Tabela independente
-- ============================================================

INSERT INTO categoria (id, nome) VALUES
(1, 'Brincos'),
(2, 'Colares'),
(3, 'Pulseiras'),
(4, 'Anéis'),
(5, 'Braceletes');


-- ============================================================
-- 4. COLEÇÃO
-- Tabela independente
-- ============================================================

INSERT INTO colecao (id, nome) VALUES
(1, 'Clássicos'),
(2, 'Elegance'),
(3, 'Pontos de Luz'),
(4, 'Delicadeza'),
(5, 'Dourados');


-- ============================================================
-- 5. PRODUTO
-- Depende de categoria, coleção e fornecedora
-- ============================================================

INSERT INTO produto (
    id,
    descricao,
    id_categoria,
    id_colecao,
    id_fornecedora,
    preco,
    quantidade,
    url_fornecedor,
    imagem_produto
) VALUES
(
    1,
    'Brinco Dourado com Zircônia',
    1, 5, 1,
    49.90,
    10,
    'https://exemplo.com/produto1',
    'https://exemplo.com/imagens/brinco1.jpg'
),
(
    2,
    'Colar Três Pontos de Luz',
    2, 3, 2,
    69.90,
    8,
    'https://exemplo.com/produto2',
    'https://exemplo.com/imagens/colar1.jpg'
),
(
    3,
    'Pulseira Delicada Dourada',
    3, 4, 3,
    39.90,
    15,
    'https://exemplo.com/produto3',
    'https://exemplo.com/imagens/pulseira1.jpg'
),
(
    4,
    'Anel Dourado Elegance',
    4, 2, 4,
    29.90,
    12,
    'https://exemplo.com/produto4',
    'https://exemplo.com/imagens/anel1.jpg'
),
(
    5,
    'Bracelete Clássico Dourado',
    5, 1, 5,
    59.90,
    6,
    'https://exemplo.com/produto5',
    'https://exemplo.com/imagens/bracelete1.jpg'
);


-- ============================================================
-- 6. REPOSIÇÃO
-- Depende de produto e usuário
-- ============================================================

INSERT INTO reposicao (
    id,
    id_produto,
    valor_compra,
    id_usuario,
    data_compra
) VALUES
(1, 1, 120.00, 1, '2026-09-01'),
(2, 2, 150.00, 2, '2026-09-05'),
(3, 3,  90.00, 3, '2026-09-10'),
(4, 4,  75.00, 4, '2026-09-15'),
(5, 5, 110.00, 5, '2026-09-20');


COMMIT;
