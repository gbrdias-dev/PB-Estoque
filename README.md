# P&B Bijuterias — Sistema de Controle de Estoque (Banco de Dados)

Repositório dedicado à modelagem, criação e manipulação do banco de dados para o sistema de gestão de estoque e catálogo da **P&B Bijuterias**. O projeto contempla desde a documentação técnica até os scripts SQL estruturados para definição de esquema (DDL), carga inicial de dados (DML) e consultas operacionais/relatórios (DQL).

---

## 📂 Estrutura do Projeto

O repositório está organizado da seguinte forma:

```text
PB_Estoque/
├── documentacao/
│   └── Documentacao_Tecnica_PB_Bijuterias.pdf  # Especificações técnicas, regras de negócio e modelagem (MER/DER)
└── scripts/
    ├── 01_ddl_criacao.sql                      # Criação das tabelas, chaves primárias, estrangeiras e constraints
    ├── 02_dml_insercao.sql                     # População inicial do banco com dados para testes e catálogo
    └── 03_sql_consultas.sql                    # Queries para relatórios de estoque, vendas e buscas no catálogo
```

# 🛠️ Tecnologias Utilizadas
Banco de Dados Relacional: SQL (compatível com PostgreSQL / MySQL)

Documentação: Modelagem Conceitual, Lógica e Física

# Como Executar os Scripts
Para configurar o banco de dados em seu ambiente local, execute os scripts localizados na pasta scripts/ exatamente na ordem numérica abaixo:

1. Criação da Estrutura (DDL)
Cria o esquema do banco de dados, incluindo tabelas de produtos, categorias, movimentações de estoque e restrições de integridade.

```
Bash
psql -U seu_usuario -d nome_do_banco -f scripts/01_ddl_criacao.sql
```

2. Inserção de Dados (DML)
Insere os registros iniciais (categorias, peças de bijuteria, quantidades em estoque, etc.) para viabilizar testes e validação do sistema.

```
Bash
psql -U seu_usuario -d nome_do_banco -f scripts/02_dml_insercao.sql
```

3. Consultas e Relatórios (DQL)
Contém consultas prontas para verificação de saldo de estoque, listagem de produtos por categoria, peças com estoque baixo e histórico de movimentações.

```
Bash
psql -U seu_usuario -d nome_do_banco -f scripts/03_sql_consultas.sql
```

(Nota: Caso utilize um cliente gráfico como DBeaver, pgAdmin ou MySQL Workbench, basta abrir os arquivos na sequência 01 -> 02 -> 03 e executá-los).

📄 Documentação Técnica
Todos os detalhes arquiteturais, dicionário de dados, diagramas de Entidade-Relacionamento e regras de negócio aplicadas ao controle de peças da P&B Bijuterias encontram-se detalhados no documento:

📘 Documentação Técnica - P&B Bijuterias

👨‍💻 Autor
Desenvolvido por Gabriel Dias

🔗 GitHub
