/*
Segundo cenário
1000 contas
*/


-- Populando a tabela
INSERT INTO tb_account (id_, balance) 
    SELECT 
        generate_series(1, 700),  -- 700 contas criadas (70% tipo 1)
        (random() * 100000000)::numeric(15, 2);  -- Valores aleatórios para saldo
        
INSERT INTO tb_account (id_, type_, balance) 
    SELECT 
        generate_series(701, 1000),  -- 300 contas criadas (30% tipo 2)
        2,  -- Conta tipo 2
        (random() * 100000000)::numeric(15, 2);  -- Valores aleatórios para saldo
