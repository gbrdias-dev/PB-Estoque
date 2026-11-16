-- ============================================================
-- Projeto: P&B Bijuterias
-- Arquivo: 01_ddl_criacao.sql
-- SGBD: PostgreSQL
-- Descrição: Criação das tabelas, restrições e comentários do BD
-- ============================================================

-- 1. Tabela de usuários do sistema
CREATE TABLE IF NOT EXISTS "usuario" (
	"id" SERIAL PRIMARY KEY,
	"nome" VARCHAR(100) NOT NULL,
	"email" VARCHAR(255) NOT NULL UNIQUE,
	"senha" VARCHAR(255) NOT NULL
);

-- 2. Tabela de fornecedores de peças
CREATE TABLE IF NOT EXISTS "fornecedora" (
	"id" SERIAL PRIMARY KEY,
	"nome" VARCHAR(100) NOT NULL,
	"site_fornecedor" VARCHAR(255) NOT NULL,
	"ativo" BOOLEAN NOT NULL DEFAULT TRUE
);

-- 3. Categorias de produtos (pulseira, brinco, colar, etc).
CREATE TABLE IF NOT EXISTS "categoria" (
	"id" SERIAL PRIMARY KEY,
	"nome" VARCHAR(255) NOT NULL
);

-- 4. Tabela de coleções de produtos
CREATE TABLE IF NOT EXISTS "colecao" (
	"id" SERIAL PRIMARY KEY,
	"nome" VARCHAR(255) NOT NULL,
	"ativo" BOOLEAN NOT NULL DEFAULT TRUE
);

-- 5. Tabela de Produtos
CREATE TABLE IF NOT EXISTS "produto" (
	"id" SERIAL PRIMARY KEY,
	"descricao" VARCHAR(500) NOT NULL,
	"id_categoria" INTEGER NOT NULL,
	"id_colecao" INTEGER NOT NULL,
	"id_fornecedora" INTEGER NOT NULL,
	"preco" NUMERIC(10,2) NOT NULL,
	"quantidade" INTEGER NOT NULL DEFAULT 0,
	"url_fornecedor" VARCHAR(255),
	"imagem_produto" VARCHAR(255) NOT NULL,
	"ativo" BOOLEAN NOT NULL DEFAULT TRUE,

	CONSTRAINT "fk_produto_categoria"
		FOREIGN KEY ("id_categoria")
		REFERENCES "categoria"("id")
		ON DELETE RESTRICT,

	CONSTRAINT "fk_produto_colecao"
		FOREIGN KEY ("id_colecao")
		REFERENCES "colecao"("id")
		ON DELETE RESTRICT,

	CONSTRAINT "fk_produto_fornecedora"
		FOREIGN KEY ("id_fornecedora")
		REFERENCES "fornecedora"("id")
		ON DELETE RESTRICT,

	CONSTRAINT "chk_produto_preco"
		CHECK ("preco" > 0),

	CONSTRAINT "chk_produto_quantidade"
		CHECK ("quantidade" >= 0)
);

-- 6. Tabela de registro e reposição
CREATE TABLE IF NOT EXISTS "reposicao" (
	"id" SERIAL PRIMARY KEY,
	"id_produto" INTEGER NOT NULL,
	"valor_compra" NUMERIC(10,2) NOT NULL,
	"id_usuario" INTEGER NOT NULL,
	"data_compra" DATE NOT NULL DEFAULT CURRENT_DATE,
	"quantidade" INTEGER NOT NULL,

	CONSTRAINT "fk_reposicao_produto"
		FOREIGN KEY ("id_produto")
		REFERENCES "produto"("id")
		ON DELETE CASCADE,

	CONSTRAINT "fk_reposicao_usuario"
		FOREIGN KEY ("id_usuario")
		REFERENCES "usuario"("id")
		ON DELETE RESTRICT,

	CONSTRAINT "chk_reposicao_valor"
		CHECK ("valor_compra" > 0),

	CONSTRAINT "chk_reposicao_quantidade"
		CHECK ("quantidade" > 0)
);

-- Índice para consultas por data de compra
CREATE INDEX IF NOT EXISTS "idx_data_compra" 
	ON "reposicao" USING btree ("data_compra");

-- Comentários das tabelas e colunas
COMMENT ON TABLE "usuario" IS 'Tabela de usuário do sistema';
COMMENT ON COLUMN "usuario"."email" IS 'Campo de email, deve ser único pois só é possível ter um único email';

COMMENT ON TABLE "fornecedora" IS 'Tabela de fornecedores de peças';
COMMENT ON COLUMN "fornecedora"."ativo" IS 'Verifica se o fornecedor está ativo ou inativo';

COMMENT ON TABLE "categoria" IS 'Categorias de produtos (pulseira, brinco, colar, etc).';

COMMENT ON TABLE "colecao" IS 'Tabela de coleções de produtos';
COMMENT ON COLUMN "colecao"."nome" IS 'Nome da coleção';
COMMENT ON COLUMN "colecao"."ativo" IS 'Verifica se a coleção está ativa ou inativa';

COMMENT ON TABLE "produto" IS 'Tabela de Produtos';
COMMENT ON COLUMN "produto"."imagem_produto" IS 'Campo que recebe o caminho da imagem do produto criado';
COMMENT ON COLUMN "produto"."ativo" IS 'Verifica se o produto está ativo ou inativo';

COMMENT ON TABLE "reposicao" IS 'Tabela de registro e reposição';
COMMENT ON COLUMN "reposicao"."id" IS 'Identificador da reposição.';
COMMENT ON COLUMN "reposicao"."id_produto" IS 'Produto reposto.';
COMMENT ON COLUMN "reposicao"."valor_compra" IS 'Valor de compra da reposição.';
COMMENT ON COLUMN "reposicao"."quantidade" IS 'Quantidade de produtos repostos.';
