-- -----------------------------------------------------------------------------
-- Criando os Departamentos
-- -----------------------------------------------------------------------------

INSERT INTO departamentos(nome, despesa)
values
('RH', 'indireta'),
('DP', 'indireta'),
('Financeiro', 'indireta'),
('Contabilidade', 'indireta'),
('TI', 'indireta'),
('Atendimento', 'direta'),
('Coleta', 'direta'),
('Servicos Gerais', 'direta'),
('Diretoria', 'indireta');

-- -----------------------------------------------------------------------------
-- Criando os cargos
-- -----------------------------------------------------------------------------

INSERT INTO cargos (nome, tipo)
values
('Auxiliar administrativo', 'Operacional'),
('Assistente administrativo', 'Operacional'),
('Analista administrativo', 'Tatico'),
('Atendente', 'Operacional'),
('Coletor', 'Operacional'),
('Copeira', 'Operacional'),
('Aux. Servicos Gerais', 'Operacional'),
('Gerente', 'Estrategico'),
('Diretor', 'Estrategico');


-- -----------------------------------------------------------------------------
-- Inserindo os dados da tabela de encargos (FGTS, Terceiros, INSS Empresa)
-- -----------------------------------------------------------------------------

INSERT INTO encargos (nome, percentual) 
VALUES
('FGTS', 0.08),
('INSS_empresa', 0.20),
('terceiros', 0.0058);


-- -----------------------------------------------------------------------------
-- Inserindo os dados da tabela de INSS - tb_inss
-- -----------------------------------------------------------------------------

INSERT INTO tb_inss (faixa_inicial, faixa_final, aliquota) VALUES
(0, 1500, 7.5),
(1500.01, 3000, 9),
(3000.01, 5000, 12),
(5000.01, 999999, 14);

-- -----------------------------------------------------------------------------
-- Inserindo os dados dos eventos fixos da folha (Gratificação, insalubridade e Periculosidade
-- -----------------------------------------------------------------------------

INSERT INTO eventos_fixos(nome, valor, percentual, tipo)
VALUES 
('Sem beneficio', 0, 0, 'provento'),
('Gratificacao Dir', 1000.00, 0, 'provento'),
('Gratificacao Ger', 500.00, 0, 'provento'),
('Inssalubridade Min', 162.10, 0, 'provento'),
('Inssalubridade Med', 324.20, 0, 'provento'),
('Inssalubridade Max', 648.40, 0, 'provento'),
('Periculosidade', 0, 0.30, 'provento');

-- -----------------------------------------------------------------------------
-- Inserindo os dados dos eventos fixos da variáveis da folha (Faltas, Hora Extra 50%, Hora Extra 100%, Atrassos)
-- -----------------------------------------------------------------------------

INSERT INTO eventos_ponto(nome, percentual, natureza, tipo)
VALUES 
('Hora Extra 50%', 1.50, 'provento', 'hora'),
('Hora Extra 100%', 2.00, 'provento', 'hora'),
('Falta', NULL, 'desconto', 'dia'),
('Atrasos', NULL, 'desconto', 'hora');


-- -----------------------------------------------------------------------------
-- Inserindo os dados dos planos de saúde (Basico, Intermediario e Premium) // 30% colaborador, 70% empresa
-- -----------------------------------------------------------------------------

INSERT INTO plano_saude(nome, valor, parte_colaborador, parte_empresa)
VALUES 
('Sem plano', 0, 0, 0),
('Basico', 300.00, 90, 210),
('Intermediario', 500.00, 150.00, 350.00),
('Premium', 1000.00, 300.00, 700.00);

-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- Inserindo os dados dos funcionários.
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

INSERT INTO funcionarios (nome, data_nascimento, sexo, admissao, demissao, salario, cargo_id, departamento_id, ativo, plano_saude_id) 
VALUES

-- 2 Diretores (1 e 2)
('Carlos Alberto Silva', '1975-03-12', 'masculino', '2010-01-05', NULL, 18500.00, 9, 9, 'Sim', 4),
('Mariana Souza Leme', '1980-07-22', 'feminino', '2012-05-15', NULL, 17800.00, 9, 9, 'Sim', 4),

-- 8 Gerentes (3 a 10)
('Ricardo Ferreira - Gerente RH', '1985-02-10', 'masculino', '2015-06-01', NULL, 8500.00, 8, 1, 'Sim', 4),
('Fabiana Gomes - Gerente DP', '1988-11-30', 'feminino', '2016-02-10', NULL, 8200.00, 8, 2, 'Sim', 4),
('Roberto Junior - Gerente FIN', '1984-04-22', 'masculino', '2015-09-20', NULL, 9000.00, 8, 3, 'Sim', 4),
('Juliana Castro - Gerente CONT', '1990-07-05', 'feminino', '2018-01-15', NULL, 8800.00, 8, 4, 'Sim', 4),
('Marcos Oliveira - Gerente TI', '1987-03-12', 'masculino', '2017-11-01', NULL, 9500.00, 8, 5, 'Sim', 4),
('Sandra Regina - Gerente ATEND', '1989-12-01', 'feminino', '2019-05-20', NULL, 7500.00, 8, 6, 'Sim', 4),
('Paulo Henrique - Gerente COL', '1983-09-18', 'masculino', '2014-08-10', NULL, 7000.00, 8, 7, 'Sim', 4),
('Luiz Gustavo - Gerente SERV', '1986-06-25', 'masculino', '2016-04-12', NULL, 6800.00, 8, 8, 'Sim', 4),

-- Demais Funcionários (11 a 150)

('Funcionario 11', '1992-01-01', 'masculino', '2021-01-01', NULL, 2100.00, 1, 1, 'Sim', 2),
('Funcionario 12', '1992-02-02', 'masculino', '2021-02-01', NULL, 2800.00, 2, 2, 'Sim', 3),
('Funcionario 13', '1992-03-03', 'masculino', '2021-03-01', NULL, 3500.00, 3, 3, 'Sim', 4),
('Funcionario 14', '1992-04-04', 'feminino', '2021-04-01', '2021-07-05', 2000.00, 4, 4, 'Nao', 3),
('Funcionario 15', '1992-05-05', 'feminino', '2021-05-01', NULL, 1800.00, 5, 5, 'Sim', 3),
('Funcionario 16', '1992-06-06', 'masculino', '2021-06-01', NULL, 1600.00, 6, 6, 'Sim', 2),
('Funcionario 17', '1992-07-07', 'masculino', '2021-07-01', NULL, 1650.00, 7, 7, 'Sim', 2),
('Funcionario 18', '1992-08-08', 'masculino', '2021-08-01', NULL, 2100.00, 1, 8, 'Sim', 2),
('Funcionario 19', '1992-09-09', 'masculino', '2021-09-01', NULL, 2800.00, 2, 9, 'Sim', 3),
('Funcionario 20', '1992-10-10', 'feminino', '2021-10-01', NULL, 3500.00, 3, 1, 'Sim', 4),
('Funcionario 21', '1992-11-11', 'feminino', '2021-11-01', '2022-07-05', 2000.00, 4, 2, 'Nao', 3),
('Funcionario 22', '1992-12-12', 'masculino', '2021-12-01', NULL, 1800.00, 5, 3, 'Sim', 3),
('Funcionario 23', '1993-01-01', 'masculino', '2022-01-01', NULL, 1600.00, 6, 4, 'Sim', 2),
('Funcionario 24', '1993-02-02', 'feminino', '2022-02-01', NULL, 1650.00, 7, 5, 'Sim', 2),
('Funcionario 25', '1993-03-03', 'feminino', '2022-03-01', NULL, 2100.00, 1, 6, 'Sim', 2),
('Funcionario 26', '1993-04-04', 'masculino', '2022-04-01', NULL, 2800.00, 2, 7, 'Sim', 3),
('Funcionario 27', '1993-05-05', 'masculino', '2022-05-01', NULL, 3500.00, 3, 8, 'Sim', 4),
('Funcionario 28', '1993-06-06', 'feminino', '2022-06-01', NULL, 2000.00, 4, 9, 'Sim', 3),
('Funcionario 29', '1993-07-07', 'feminino', '2022-07-01', NULL, 1800.00, 5, 1, 'Sim', 3),
('Funcionario 30', '1993-08-08', 'feminino', '2022-08-01', NULL, 1600.00, 6, 2, 'Sim', 2),
('Funcionario 31', '1993-09-09', 'masculino', '2022-09-01', '2023-07-05', 1650.00, 7, 3, 'Nao', 2),
('Funcionario 32', '1993-10-10', 'masculino', '2022-10-01', NULL, 2100.00, 1, 4, 'Sim', 2),
('Funcionario 33', '1993-11-11', 'feminino', '2022-11-01', NULL, 2800.00, 2, 5, 'Sim', 3),
('Funcionario 34', '1993-12-12', 'masculino', '2022-12-01', NULL, 3500.00, 3, 6, 'Sim', 4),
('Funcionario 35', '1994-01-01', 'feminino', '2023-01-01', NULL, 2000.00, 4, 7, 'Sim', 3),
('Funcionario 36', '1994-02-02', 'masculino', '2023-02-01', '2024-09-05', 1800.00, 5, 8, 'Nao', 3),
('Funcionario 37', '1994-03-03', 'masculino', '2023-03-01', NULL, 1600.00, 6, 9, 'Sim', 2),
('Funcionario 38', '1994-04-04', 'feminino', '2023-04-01', NULL, 1650.00, 7, 1, 'Sim', 2),
('Funcionario 39', '1994-05-05', 'feminino', '2023-05-01', NULL, 2100.00, 1, 2, 'Sim', 2),
('Funcionario 40', '1994-06-06', 'masculino', '2023-06-01', NULL, 2800.00, 2, 3, 'Sim', 3),
('Funcionario 41', '1994-07-07', 'masculino', '2023-07-01', NULL, 3500.00, 3, 4, 'Sim', 4),
('Funcionario 42', '1994-08-08', 'masculino', '2023-08-01', NULL, 2000.00, 4, 5, 'Sim', 3),
('Funcionario 43', '1994-09-09', 'masculino', '2023-09-01', NULL, 1800.00, 5, 6, 'Sim', 3),
('Funcionario 44', '1994-10-10', 'feminino', '2023-10-01', NULL, 1600.00, 6, 7, 'Sim', 2),
('Funcionario 45', '1994-11-11', 'feminino', '2023-11-01', NULL, 1650.00, 7, 8, 'Sim', 2),
('Funcionario 46', '1994-12-12', 'feminino', '2023-12-01', '2024-12-15', 2100.00, 1, 9, 'Nao', 2),
('Funcionario 47', '1995-01-01', 'feminino', '2024-01-01', NULL, 2800.00, 2, 1, 'Sim', 3),
('Funcionario 48', '1995-02-02', 'masculino', '2024-02-01', NULL, 3500.00, 3, 2, 'Sim', 4),
('Funcionario 49', '1995-03-03', 'masculino', '2024-03-01', NULL, 2000.00, 4, 3, 'Sim', 3),
('Funcionario 50', '1995-04-04', 'feminino', '2024-04-01', NULL, 1800.00, 5, 4, 'Sim', 3),
('Funcionario 51', '1995-05-05', 'masculino', '2024-05-01', NULL, 1600.00, 6, 5, 'Sim', 2),
('Funcionario 52', '1995-06-06', 'feminino', '2024-06-01', NULL, 1650.00, 7, 6, 'Sim', 2),
('Funcionario 53', '1995-07-07', 'feminino', '2024-07-01', NULL, 2100.00, 1, 7, 'Sim', 1),
('Funcionario 54', '1995-08-08', 'masculino', '2024-08-01', NULL, 2800.00, 2, 8, 'Sim', 3),
('Funcionario 55', '1995-09-09', 'masculino', '2024-09-01', NULL, 3500.00, 3, 9, 'Sim', 4),
('Funcionario 56', '1995-10-10', 'masculino', '2024-10-01', NULL, 2000.00, 4, 1, 'Sim', 3),
('Funcionario 57', '1995-11-11', 'feminino', '2024-11-01', NULL, 1800.00, 5, 2, 'Sim', 3),
('Funcionario 58', '1995-12-12', 'feminino', '2024-12-01', NULL, 1600.00, 6, 3, 'Sim', 2),
('Funcionario 59', '1996-01-01', 'masculino', '2025-01-01', NULL, 1650.00, 7, 4, 'Sim', 2),
('Funcionario 60', '1996-02-02', 'masculino', '2025-02-01', NULL, 2100.00, 1, 5, 'Sim', 1),
('Funcionario 61', '1996-03-03', 'feminino', '2025-03-01', '2025-05-05', 2800.00, 2, 6, 'Nao', 3),
('Funcionario 62', '1996-04-04', 'feminino', '2025-04-01', NULL, 3500.00, 3, 7, 'Sim', 4),
('Funcionario 63', '1996-05-05', 'feminino', '2025-05-01', NULL, 2000.00, 4, 8, 'Sim', 3),
('Funcionario 64', '1996-06-06', 'masculino', '2025-06-01', NULL, 1800.00, 5, 9, 'Sim', 3),
('Funcionario 65', '1996-07-07', 'masculino', '2025-07-01', NULL, 1600.00, 6, 1, 'Sim', 2),
('Funcionario 66', '1996-08-08', 'feminino', '2025-08-01', NULL, 1650.00, 7, 2, 'Sim', 2),
('Funcionario 67', '1996-09-09', 'masculino', '2025-09-01', NULL, 2100.00, 1, 3, 'Sim', 2),
('Funcionario 68', '1996-10-10', 'feminino', '2025-10-01', NULL, 2800.00, 2, 4, 'Sim', 3),
('Funcionario 69', '1996-11-11', 'masculino', '2025-11-01', NULL, 3500.00, 3, 5, 'Sim', 4),
('Funcionario 70', '1996-12-12', 'feminino', '2025-12-01', NULL, 2000.00, 4, 6, 'Sim', 3),
('Funcionario 71', '1997-01-01', 'masculino', '2021-01-10', NULL, 1800.00, 5, 7, 'Sim', 3),
('Funcionario 72', '1997-02-02', 'masculino', '2021-02-10', '2023-04-15', 1600.00, 6, 8, 'Nao', 2),
('Funcionario 73', '1997-03-03', 'masculino', '2021-03-10', NULL, 1650.00, 7, 9, 'Sim', 2),
('Funcionario 74', '1997-04-04', 'feminino', '2021-04-10', NULL, 2100.00, 1, 1, 'Sim', 1),
('Funcionario 75', '1996-11-20', 'feminino', '2022-01-05', NULL, 2100.00, 1, 6, 'Sim', 2),
('Funcionario 76', '1996-12-20', 'masculino', '2022-02-05', NULL, 2800.00, 2, 7, 'Sim', 3),
('Funcionario 77', '1997-01-20', 'masculino', '2022-03-05', NULL, 3500.00, 3, 8, 'Sim', 4),
('Funcionario 78', '1997-08-08', 'masculino', '2021-08-10', NULL, 1800.00, 5, 5, 'Sim', 3),
('Funcionario 79', '1997-09-09', 'feminino', '2021-09-10', '2023-04-07', 1600.00, 6, 6, 'Nao', 2),
('Funcionario 80', '1997-10-10', 'masculino', '2021-10-10', NULL, 1650.00, 7, 7, 'Sim', 2),
('Funcionario 81', '1997-11-11', 'masculino', '2021-11-10', NULL, 2100.00, 1, 8, 'Sim', 2),
('Funcionario 82', '1997-12-12', 'feminino', '2021-12-10', NULL, 2800.00, 2, 9, 'Sim', 3),
('Funcionario 83', '1998-01-01', 'feminino', '2022-01-15', NULL, 3500.00, 3, 1, 'Sim', 4),
('Funcionario 84', '1998-02-02', 'feminino', '2022-02-15', NULL, 2000.00, 4, 2, 'Sim', 3),
('Funcionario 85', '1998-03-03', 'masculino', '2022-03-15', NULL, 1800.00, 5, 3, 'Sim', 3),
('Funcionario 86', '1998-04-04', 'masculino', '2022-04-15', NULL, 1600.00, 6, 4, 'Sim', 2),
('Funcionario 87', '1998-05-05', 'masculino', '2022-05-15', '2023-04-20', 1650.00, 7, 5, 'Nao', 2),
('Funcionario 88', '1998-06-06', 'feminino', '2022-06-15', NULL, 2100.00, 1, 6, 'Sim', 2),
('Funcionario 89', '1998-07-07', 'masculino', '2022-07-15', NULL, 2800.00, 2, 7, 'Sim', 3),
('Funcionario 90', '1998-08-08', 'masculino', '2022-08-15', NULL, 3500.00, 3, 8, 'Sim', 4),
('Funcionario 91', '1998-09-09', 'masculino', '2022-09-15', NULL, 2000.00, 4, 9, 'Sim', 3),
('Funcionario 92', '1998-10-10', 'feminino', '2022-10-15', NULL, 1800.00, 5, 1, 'Sim', 3),
('Funcionario 93', '1998-11-11', 'feminino', '2022-11-15', NULL, 1600.00, 6, 2, 'Sim', 2),
('Funcionario 94', '1998-12-12', 'masculino', '2022-12-15', '2024-07-10', 1650.00, 7, 3, 'Nao', 2),
('Funcionario 95', '1999-01-01', 'feminino', '2023-01-20', NULL, 2100.00, 1, 4, 'Sim', 1),
('Funcionario 96', '1999-02-02', 'masculino', '2023-02-20', NULL, 2800.00, 2, 5, 'Sim', 3),
('Funcionario 97', '1999-03-03', 'feminino', '2023-03-20', NULL, 3500.00, 3, 6, 'Sim', 4),
('Funcionario 98', '1999-04-04', 'masculino', '2023-04-20', NULL, 2000.00, 4, 7, 'Sim', 3),
('Funcionario 99', '1999-05-05', 'masculino', '2023-05-20', NULL, 1800.00, 5, 8, 'Sim', 3),
('Funcionario 100', '1999-06-06', 'masculino', '2023-06-20', NULL, 1600.00, 6, 9, 'Sim', 2),
('Funcionario 101', '1999-07-07', 'feminino', '2023-07-20', NULL, 1650.00, 7, 1, 'Sim', 2),
('Funcionario 102', '1999-08-08', 'masculino', '2023-08-20', NULL, 2100.00, 1, 2, 'Sim', 1),
('Funcionario 103', '1999-09-09', 'masculino', '2023-09-20', NULL, 2800.00, 2, 3, 'Sim', 3),
('Funcionario 104', '1999-10-10', 'masculino', '2023-10-20', '2024-07-08', 3500.00, 3, 4, 'Nao', 4),
('Funcionario 105', '1999-11-11', 'masculino', '2023-11-20', NULL, 2000.00, 4, 5, 'Sim', 3),
('Funcionario 106', '1999-12-12', 'feminino', '2023-12-20', NULL, 1800.00, 5, 6, 'Sim', 3),
('Funcionario 107', '2000-01-01', 'feminino', '2024-01-05', NULL, 1600.00, 6, 7, 'Sim', 2),
('Funcionario 108', '2000-02-02', 'feminino', '2024-02-05', '2024-07-19', 1650.00, 7, 8, 'Nao', 2),
('Funcionario 109', '2000-03-03', 'masculino', '2024-03-05', NULL, 2100.00, 1, 9, 'Sim', 1),
('Funcionario 110', '2000-04-04', 'masculino', '2024-04-05', NULL, 2800.00, 2, 1, 'Sim', 3),
('Funcionario 111', '2000-05-05', 'masculino', '2024-05-05', NULL, 3500.00, 3, 2, 'Sim', 4),
('Funcionario 112', '2000-06-06', 'masculino', '2024-06-05', NULL, 2000.00, 4, 3, 'Sim', 3),
('Funcionario 113', '2000-07-07', 'masculino', '2024-07-05', '2024-07-18', 1800.00, 5, 4, 'Nao', 3),
('Funcionario 114', '2000-08-08', 'feminino', '2024-08-05', NULL, 1600.00, 6, 5, 'Sim', 2),
('Funcionario 115', '2000-09-09', 'feminino', '2024-09-05', NULL, 1650.00, 7, 6, 'Sim', 2),
('Funcionario 116', '2000-10-10', 'masculino', '2024-10-05', NULL, 2100.00, 1, 7, 'Sim', 2),
('Funcionario 117', '2000-11-11', 'masculino', '2024-11-05', NULL, 2800.00, 2, 8, 'Sim', 3),
('Funcionario 118', '2000-12-12', 'masculino', '2024-12-05', NULL, 3500.00, 3, 9, 'Sim', 4),
('Funcionario 119', '2001-01-01', 'feminino', '2025-01-10', NULL, 2000.00, 4, 1, 'Sim', 3),
('Funcionario 120', '2001-02-02', 'masculino', '2025-02-10', NULL, 1800.00, 5, 2, 'Sim', 3),
('Funcionario 121', '2001-03-03', 'feminino', '2025-03-10', NULL, 1600.00, 6, 3, 'Sim', 2),
('Funcionario 122', '2001-04-04', 'masculino', '2025-04-10', NULL, 1650.00, 7, 4, 'Sim', 2),
('Funcionario 123', '2001-05-05', 'masculino', '2025-05-10', NULL, 2100.00, 1, 5, 'Sim', 2),
('Funcionario 124', '2001-06-06', 'masculino', '2025-06-10', NULL, 2800.00, 2, 6, 'Sim', 3),
('Funcionario 125', '2001-07-07', 'masculino', '2025-07-10', NULL, 3500.00, 3, 7, 'Sim', 4),
('Funcionario 126', '2001-08-08', 'feminino', '2025-08-10', NULL, 2000.00, 4, 8, 'Sim', 3),
('Funcionario 127', '2001-09-09', 'masculino', '2025-09-10', NULL, 1800.00, 5, 9, 'Sim', 3),
('Funcionario 128', '2001-10-10', 'masculino', '2025-10-10', NULL, 1600.00, 6, 1, 'Sim', 2),
('Funcionario 129', '2001-11-11', 'feminino', '2025-11-10', NULL, 1650.00, 7, 2, 'Sim', 2),
('Funcionario 130', '2001-12-12', 'masculino', '2025-12-10', NULL, 2100.00, 1, 3, 'Sim', 2),
('Funcionario 131', '1995-01-15', 'feminino', '2020-05-01', '2024-07-11', 2800.00, 2, 4, 'Nao', 3),
('Funcionario 132', '1995-02-15', 'feminino', '2020-06-01', NULL, 3500.00, 3, 5, 'Sim', 4),
('Funcionario 133', '1995-03-15', 'masculino', '2020-07-01', NULL, 2000.00, 4, 6, 'Sim', 3),
('Funcionario 134', '1995-04-15', 'masculino', '2020-08-01', NULL, 1800.00, 5, 7, 'Sim', 3),
('Funcionario 135', '1995-05-15', 'masculino', '2020-09-01', NULL, 1600.00, 6, 8, 'Sim', 2),
('Funcionario 136', '1995-06-15', 'feminino', '2020-10-01', NULL, 1650.00, 7, 9, 'Sim', 2),
('Funcionario 137', '1995-07-15', 'masculino', '2020-11-01', NULL, 2100.00, 1, 1, 'Sim', 1),
('Funcionario 138', '1995-08-15', 'masculino', '2020-12-01', NULL, 2800.00, 2, 2, 'Sim', 3),
('Funcionario 139', '1995-09-15', 'feminino', '2021-01-01', NULL, 3500.00, 3, 3, 'Sim', 4),
('Funcionario 140', '1995-10-15', 'masculino', '2021-02-01', '2021-10-15', 2000.00, 4, 4, 'Nao', 3),
('Funcionario 141', '1996-01-20', 'feminino', '2021-03-01', NULL, 1800.00, 5, 5, 'Sim', 3),
('Funcionario 142', '1996-02-20', 'masculino', '2021-04-01', NULL, 1600.00, 6, 6, 'Sim', 2),
('Funcionario 143', '1996-03-20', 'masculino', '2021-05-01', NULL, 1650.00, 7, 7, 'Sim', 2),
('Funcionario 144', '1996-04-20', 'feminino', '2021-06-01', NULL, 2100.00, 1, 8, 'Sim', 1),
('Funcionario 145', '1996-05-20', 'masculino', '2021-07-01', NULL, 2800.00, 2, 9, 'Sim', 3),
('Funcionario 146', '1996-06-20', 'masculino', '2021-08-01', NULL, 3500.00, 3, 1, 'Sim', 4),
('Funcionario 147', '1996-07-20', 'feminino', '2021-09-01', NULL, 2000.00, 4, 2, 'Sim', 3),
('Funcionario 148', '1996-08-20', 'masculino', '2021-10-01', NULL, 1800.00, 5, 3, 'Sim', 3),
('Funcionario 149', '1996-09-20', 'feminino', '2021-11-01', NULL, 1600.00, 6, 4, 'Sim', 2),
('Funcionario 150', '1996-10-20', 'masculino', '2021-12-01', NULL, 1650.00, 7, 5, 'Sim', 2);

-- -----------------------------------------------------------------------------
-- Inserindo os dados dos benefícios dos funcionários.
-- -----------------------------------------------------------------------------
-- select * from funcionario_eventof;
INSERT INTO funcionario_eventof(funcionario_id, eventof_id, data_inicio, data_fim)
VALUES

(1, 2, '2010-01-05', NULL),
(2, 2, '2012-05-15', NULL),

(3, 3, '2025-01-01', NULL),
(4, 3, '2025-01-01', NULL),
(5, 3, '2025-01-01', NULL),
(6, 3, '2025-01-01', NULL),
(7, 3, '2025-01-01', NULL),
(8, 3, '2025-01-01', NULL),
(9, 3, '2025-01-01', NULL),
(10, 3, '2025-01-01', NULL),

(14, 4, '2025-01-01', NULL),
(21, 4, '2025-01-01', NULL),
(28, 4, '2025-01-01', NULL),
(35, 4, '2025-01-01', NULL),
(42, 4, '2025-01-01', NULL),
(49, 4, '2025-01-01', NULL),
(56, 4, '2025-01-01', NULL),
(63, 4, '2025-01-01', NULL),
(70, 4, '2025-01-01', NULL),
(84, 4, '2025-01-01', NULL),
(91, 4, '2025-01-01', NULL),
(98, 4, '2025-01-01', NULL),
(105, 4, '2025-01-01', NULL),
(112, 4, '2025-01-01', NULL),
(119, 4, '2025-01-01', NULL),
(126, 4, '2025-01-01', NULL),
(133, 4, '2025-01-01', NULL),
(140, 4, '2025-01-01', NULL),
(147, 4, '2025-01-01', NULL),
(8, 4, '2025-01-01', NULL), -- gerente com 2 beneficios


(15, 5, '2025-01-01', NULL),
(22, 5, '2025-01-01', NULL),
(29, 5, '2025-01-01', NULL),
(36, 5, '2025-01-01', NULL),
(43, 5, '2025-01-01', NULL),
(50, 5, '2025-01-01', NULL),
(57, 5, '2025-01-01', NULL),
(64, 5, '2025-01-01', NULL),
(71, 5, '2025-01-01', NULL),
(78, 5, '2025-01-01', NULL),
(85, 5, '2025-01-01', NULL),
(92, 5, '2025-01-01', NULL),
(99, 5, '2025-01-01', NULL),
(106, 5, '2025-01-01', NULL),
(113, 5, '2025-01-01', NULL),
(120, 5, '2025-01-01', NULL),
(127, 5, '2025-01-01', NULL),
(134, 5, '2025-01-01', NULL),
(141, 5, '2025-01-01', NULL),
(148, 5, '2025-01-01', NULL),
(9, 5, '2025-01-01', NULL), -- gerente com 2 beneficios

(16, 6, '2025-01-01', NULL),
(23, 6, '2025-01-01', NULL),
(30, 6, '2025-01-01', NULL),
(37, 6, '2025-01-01', NULL),
(44, 6, '2025-01-01', NULL),
(51, 6, '2025-01-01', NULL),
(58, 6, '2025-01-01', NULL),
(65, 6, '2025-01-01', NULL),
(72, 6, '2025-01-01', NULL),
(79, 6, '2025-01-01', NULL),
(86, 6, '2025-01-01', NULL),
(93, 6, '2025-01-01', NULL),
(100, 6, '2025-01-01', NULL),
(107, 6, '2025-01-01', NULL),
(114, 6, '2025-01-01', NULL),
(121, 6, '2025-01-01', NULL),
(128, 6, '2025-01-01', NULL),
(135, 6, '2025-01-01', NULL),
(142, 6, '2025-01-01', NULL),
(149, 6, '2025-01-01', NULL),
(10, 6, '2025-01-01', NULL), -- gerente com 2 beneficios

(17, 7, '2025-01-01', NULL),
(24, 7, '2025-01-01', NULL),
(31, 7, '2025-01-01', NULL),
(38, 7, '2025-01-01', NULL),
(45, 7, '2025-01-01', NULL),
(52, 7, '2025-01-01', NULL),
(59, 7, '2025-01-01', NULL),
(66, 7, '2025-01-01', NULL),
(73, 7, '2025-01-01', NULL),
(80, 7, '2025-01-01', NULL),
(87, 7, '2025-01-01', NULL),
(94, 7, '2025-01-01', NULL),
(101, 7, '2025-01-01', NULL),
(108, 7, '2025-01-01', NULL),
(115, 7, '2025-01-01', NULL),
(122, 7, '2025-01-01', NULL),
(129, 7, '2025-01-01', NULL),
(136, 7, '2025-01-01', NULL),
(143, 7, '2025-01-01', NULL),
(150, 7, '2025-01-01', NULL);

-- -----------------------------------------------------------------------------
-- Inserindo os dados da tabela de resumo ponto - resumo_ponto
-- -----------------------------------------------------------------------------
-- select * from resumo_ponto
-- select * from fechamento_ponto
INSERT INTO resumo_ponto(competencia, id_funcionario, id_evento_ponto, quantidade)
VALUES
('2025-05-01', 1, 1, 5.00),
('2025-05-01', 1, 2, 10.00),
('2025-05-01', 10, 3, 4),
('2025-05-01', 15, 1, 10.00),
('2025-05-01', 20, 2, 20.00);
