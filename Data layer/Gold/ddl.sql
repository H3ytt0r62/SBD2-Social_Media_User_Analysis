-- Criação do schema DW (caso não exista)
CREATE SCHEMA IF NOT EXISTS DW;

-- Comentário no schema
COMMENT ON SCHEMA DW IS 'Camada GOLD - Dados prontos para análise e relatórios';