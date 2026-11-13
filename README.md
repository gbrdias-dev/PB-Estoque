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
