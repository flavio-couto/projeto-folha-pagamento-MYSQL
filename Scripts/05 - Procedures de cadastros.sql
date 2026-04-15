/* 
----------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------

--- PROCEDURE PARA INCLUIR UM DEPARTAMENTO ---

Inclui um departamento no banco
Faz um INSERT na tabela DEPARTAMENTOS

-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
*/
-- select * from departamentos;

DELIMITER $$

create procedure cadastrar_departamento (p_nome_departamento VARCHAR(100), p_despesa ENUM('direta', 'indireta'))

BEGIN

	INSERT INTO departamentos (nome, despesa)
	VALUES (p_nome_departamento, p_despesa);

END $$

DELIMITER ;

/* 
----------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------

--- PROCEDURE PARA INCLUIR UM CARGO ---

Inclui um cargo no banco
Faz um INSERT na tabela CARGOS

-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
*/
-- select * from cargos

DELIMITER $$

create procedure cadastrar_cargo(p_nome_cargo VARCHAR(150), p_tipo ENUM('estrategico','operacional','tatico'))

BEGIN

	insert into cargos(nome, tipo)
    VALUES
    (p_nome_cargo, p_tipo);    

END $$

DELIMITER ;


/* 
----------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------

--- PROCEDURE PARA INCLUIR UM ENCARGO ---

Inclui um cargo no banco
Faz um INSERT na tabela ENCARGOS

-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
*/
-- select * from encargos

DELIMITER $$

create procedure cadastrar_encargo(p_nome_encargo VARCHAR(100), p_percentual DECIMAL(10,4))

BEGIN

	insert into encargos(nome, percentual)
    VALUES
    (p_nome_encargo, p_percentual);    

END $$

DELIMITER ;

/* 
----------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------

--- PROCEDURE PARA INCLUIR UM EVENTO FIXO ---

Inclui um cargo no banco
Faz um INSERT na tabela EVENTOS_FIXOS

-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
*/
-- select * from eventos_fixos

DELIMITER $$

create procedure cadastrar_eventos_fixos(p_nome_eventof VARCHAR(150), p_valor_eventof DECIMAL(10,2), p_percentual_eventof DECIMAL(10,4), p_tipo ENUM('provento', 'desconto'), p_tipo_calculo ENUM('valor', 'percentual'))

BEGIN

	insert into eventos_fixos(nome, valor, percentual, tipo, tipo_calculo)
    VALUES
    (p_nome_eventof, p_valor_eventof, p_percentual_eventof, p_tipo, p_tipo_calculo);

END $$

DELIMITER ;


/* 
----------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------

--- PROCEDURE PARA INCLUIR UM EVENTO DE PONTO ---

Inclui um cargo no banco
Faz um INSERT na tabela EVENTOS_PONTO

-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
*/
-- select * from eventos_ponto


DELIMITER $$

create procedure cadastrar_eventos_ponto(p_nome_eventop VARCHAR(150), p_percentual DECIMAL(10,2), p_natureza ENUM('provento', 'desconto'), p_tipo ENUM('hora', 'dia'))
BEGIN

	insert into eventos_ponto(nome, percentual, natureza, tipo)
    VALUES
    (p_nome_eventop, p_percentual, p_natureza, p_tipo);

END $$

DELIMITER ;

/* 
----------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------

--- PROCEDURE PARA INCLUIR UM PLANO DE SAUDE ---

Inclui um cargo no banco
Faz um INSERT na tabela PLANO_SAUDE

-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
*/
-- select * from plano_saude


DELIMITER $$

create procedure cadastrar_plano_saude(p_nome_plano VARCHAR(150), p_valor_planos DECIMAL(10,2), p_parte_colaborador DECIMAL(10,2), p_parte_empresa DECIMAL(10,2))
BEGIN

	insert into plano_saude(nome, valor, parte_colaborador, parte_empresa)
    VALUES
    (p_nome_plano, p_valor_planos, p_parte_colaborador, p_parte_empresa);

END $$

DELIMITER ;


/* 
----------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------

--- PROCEDURE PARA INCLUIR UM FUNCIONARIO ---

Inclui um departamento no banco
Faz um INSERT na tabela FUNCIONARIOS

-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
*/
-- select * from funcionarios;

DELIMITER $$

CREATE PROCEDURE cadastrar_funcionario(
p_nome varchar(250), p_nascimento date, p_sexo varchar(30), p_admissao date, p_salario decimal(10,2), p_cargo_id int, p_departamento_id int, p_plano_saude int)

BEGIN 

DECLARE v_demissao date;
DECLARE v_ativo varchar(5);

SET v_demissao = NULL;
SET v_ativo = 'sim';

insert into funcionarios(nome, data_nascimento, sexo, admissao, demissao, salario, ativo, cargo_id, departamento_id, plano_saude_id)
VALUES
(p_nome, p_nascimento, p_sexo, p_admissao, v_demissao, p_salario, v_ativo, p_cargo_id, p_departamento_id, p_plano_saude);

END $$ 

DELIMITER ;