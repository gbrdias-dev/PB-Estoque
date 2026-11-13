
-- ============================================================
-- Projeto: P&B Bijuterias
-- Arquivo: 01_ddl_criacao.sql
-- SGBD: PostgreSQL
-- Descrição: Criação das tabelas e restrições do banco de dados
-- ============================================================

-- 1. Tabela de usuários
CREATE TABLE IF NOT EXISTS usuario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL
);

-- 2. Tabela de fornecedoras
CREATE TABLE IF NOT EXISTS fornecedora (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    site_fornecedor VARCHAR(255) NOT NULL
);

-- 3. Tabela de categorias
CREATE TABLE IF NOT EXISTS categoria (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

-- 4. Tabela de coleções
CREATE TABLE IF NOT EXISTS colecao (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

-- 5. Tabela de produtos
CREATE TABLE IF NOT EXISTS produto (
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(500) NOT NULL,
    id_categoria INTEGER NOT NULL,
    id_colecao INTEGER NOT NULL,
    id_fornecedora INTEGER NOT NULL,
    preco NUMERIC(10,2) NOT NULL,
    quantidade INTEGER NOT NULL DEFAULT 0,
    url_fornecedor VARCHAR(255),
    imagem_produto VARCHAR(255) NOT NULL,

    CONSTRAINT fk_produto_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categoria(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_produto_colecao
        FOREIGN KEY (id_colecao)
        REFERENCES colecao(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_produto_fornecedora
        FOREIGN KEY (id_fornecedora)
        REFERENCES fornecedora(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_produto_preco
        CHECK (preco > 0),

    CONSTRAINT chk_produto_quantidade
        CHECK (quantidade >= 0)
);

-- 6. Tabela de reposições
CREATE TABLE IF NOT EXISTS reposicao (
    id SERIAL PRIMARY KEY,
    id_produto INTEGER NOT NULL,
    valor_compra NUMERIC(10,2) NOT NULL,
    id_usuario INTEGER NOT NULL,
    data_compra DATE NOT NULL DEFAULT CURRENT_DATE,

    CONSTRAINT fk_reposicao_produto
        FOREIGN KEY (id_produto)
        REFERENCES produto(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_reposicao_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_reposicao_valor
        CHECK (valor_compra > 0)
);

-- Índice para consultas por data de compra
CREATE INDEX IF NOT EXISTS idx_data_compra
    ON reposicao(data_compra);

-- Comentários das tabelas
COMMENT ON TABLE usuario IS 'Tabela de usuários do sistema';
COMMENT ON TABLE fornecedora IS 'Tabela de fornecedoras de peças';
COMMENT ON TABLE categoria IS 'Categorias dos produtos';
COMMENT ON TABLE colecao IS 'Coleções de produtos';
COMMENT ON TABLE produto IS 'Cadastro de produtos da P&B Bijuterias';
COMMENT ON TABLE reposicao IS 'Histórico de reposições de produtos';
