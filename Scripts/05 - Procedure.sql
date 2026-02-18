-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
/*
Procedure para incluir os funcionários na folha de pagamento, vai usar o ID e uma data para buscar 
o funcionário e trazer o salário dele além das outras informações como adicionais, descontos que
estão em tabelas diferentes.
*/

DELIMITER $$

CREATE PROCEDURE gerar_folha(
    IN p_funcionario INT,
    IN p_competencia DATE
)
BEGIN
    DECLARE v_salario DECIMAL(10,2);
    DECLARE v_adicionais DECIMAL(10,2);
    DECLARE v_outros_descontos DECIMAL(10,2);
    DECLARE v_inss DECIMAL(10,2);
    DECLARE v_irrf DECIMAL(10,2);
    DECLARE v_total_proventos DECIMAL(10,2);
    DECLARE v_total_descontos DECIMAL(10,2);
    DECLARE v_liquido DECIMAL(10,2);
    DECLARE v_cargo INT;
    DECLARE v_fgts DECIMAL(10,2);
    DECLARE v_inss_empresa DECIMAL(10,2);
    DECLARE v_terceiros DECIMAL(10,2);
    
    DECLARE v_gratificacao DECIMAL(10,2);
    DECLARE v_insalubridade DECIMAL(10,2);
    DECLARE v_plano_saude DECIMAL(10,2);

	-- Aqui vai começar a 'SETAR' as variáveis, umas serão por SELECT, outras pelo IF, e outras através du funções que são chamadas como inss e irrf, outras apenas atribuida um valor direto.
    SELECT salario, id_cargo
    INTO v_salario, v_cargo
    FROM funcionarios
    WHERE id_funcionario = p_funcionario;
    
	SELECT gratificacao, insalubridade, plano_saude 
    INTO v_gratificacao, v_insalubridade, v_plano_saude
    FROM fixos_folha
    where id_evento = 1;

    --
    -- Se o colaborador for atendendente, coletor, copeira ou serviços gerais ele terá direito à insalubridade. 
    -- Se ele for gerente terá direito à metade da gratificação e se for diretor a gratificação integral.
    --
    IF v_cargo between 4 and 7 then
        SET v_adicionais = v_insalubridade;
	elseif v_cargo = 8 then
		SET v_adicionais = v_gratificacao / 2;
	elseif v_cargo = 9 then
		SET v_adicionais = v_gratificacao;
	else
		SET v_adicionais = 0;
	END IF;
    
    SET v_total_proventos = v_salario + v_adicionais;
    SET v_inss = calcula_inss(v_salario + v_adicionais);
    SET v_irrf = calcula_irrf(v_total_proventos - v_inss);
    
--
-- Outros descontos no momento é só para o plano de saúde. Depedendo do cargo pagará: diretores: 100% / gerentes: 50% / analista e assistente: 33,33% / demais funções: 25%
-- 
    IF v_cargo between 2 and 3 then
        SET v_outros_descontos = v_plano_saude / 3;
    elseif (v_cargo between 4 and 7) or v_cargo = 1 then
        SET v_outros_descontos = v_plano_saude / 4;
	elseif v_cargo = 8 then
		SET v_outros_descontos = v_plano_saude / 2;
	elseif v_cargo = 9 then
		SET v_outros_descontos = v_plano_saude;
	else
		SET v_outros_descontos = 0;
	END IF;
        
    SET v_total_descontos = v_inss + v_irrf + v_outros_descontos;
    SET v_liquido = v_total_proventos - v_total_descontos;
    SET v_fgts = v_total_proventos * 0.08;
    SET v_inss_empresa = v_total_proventos * 0.20;   
    SET v_terceiros = v_total_proventos * 0.058;   

    INSERT INTO folha_pagamento (
        competencia,
        id_funcionario,
        salario_base,
        adicionais,
        inss,
        irrf,
        outros_descontos,
        total_proventos,
        total_descontos,
        liquido,
        fgts,
        inss_empresa,
        terceiros
    )
    VALUES (
        p_competencia,
        p_funcionario,
        v_salario,
        v_adicionais,
        v_inss,
        v_irrf,
        v_outros_descontos,
        v_total_proventos,
        v_total_descontos,
        v_liquido,
        v_fgts,
        v_inss_empresa,
        v_terceiros
);

END $$

DELIMITER ;

-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- Essa procedure contem os mesmos campos que a Folha de Pagamento mas aqui ela vai trazer o total (SUM)
-- de todas as colunas da tabela (salario, adicionais, descontos, impostos), tendo assim um resumo dela.

DELIMITER $$

CREATE PROCEDURE gerar_resumo_folha(
	IN competencia_ DATE
    )
BEGIN
    DECLARE v_competencia DATE;
    DECLARE v_salario_base DECIMAL(10,2);
    DECLARE v_adicionais DECIMAL(10,2);
	DECLARE v_valor_inss DECIMAL(10,2);
    DECLARE v_irrf DECIMAL(10,2);
    DECLARE v_outros_descontos DECIMAL(10,2);
    DECLARE v_total_proventos DECIMAL(10,2);
    DECLARE v_total_descontos DECIMAL(10,2);
    DECLARE v_liquido DECIMAL(10,2);
    DECLARE v_valor_fgts DECIMAL(10,2);
    DECLARE v_valor_inss_empresa DECIMAL(10,2);
    DECLARE v_valor_terceiros DECIMAL(10,2);    
    
    SELECT 
		competencia,
		SUM(salario_base),
        SUM(adicionais), 
        SUM(inss),
        SUM(irrf),
        SUM(outros_descontos),
        SUM(total_proventos),
        SUM(total_descontos),
        SUM(liquido),
        SUM(fgts),
        SUM(inss_empresa),
        SUM(terceiros)
    INTO
        v_competencia,
        v_salario_base,
        v_adicionais,
        v_valor_inss,
        v_irrf,
        v_outros_descontos,
        v_total_proventos,
        v_total_descontos,
        v_liquido,
        v_valor_fgts,
        v_valor_inss_empresa,
        v_valor_terceiros        
	FROM
		folha_pagamento f
	WHERE competencia = competencia_
    GROUP BY competencia;
    
    INSERT INTO resumo_folha(competencia, t_salario_base, t_adicionais, t_inss, t_irrf, t_outros_descontos, t_total_proventos, t_total_descontos, t_liquido, t_fgts, t_inss_empresa, t_terceiros)
    VALUES
	(v_competencia, v_salario_base, v_adicionais, v_valor_inss, v_irrf, v_outros_descontos, v_total_proventos, v_total_descontos, v_liquido, v_valor_fgts, v_valor_inss_empresa, v_valor_terceiros);    
END$$

DELIMITER ;

-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- Essa última procedure confesso que o chatgpt que fez, não sabia como usar a minha procedura de 
-- gerar a folha de forma automatizada aí ele criou esse looping pra rodar pra todos os funcionários
-- cadastrados

DELIMITER $$

CREATE PROCEDURE gerar_folha_mensal (IN p_competencia DATE)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_funcionario INT;

    DECLARE cursor_func CURSOR FOR
        SELECT id_funcionario FROM funcionarios;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cursor_func;

    read_loop: LOOP
        FETCH cursor_func INTO v_funcionario;

        IF done THEN
            LEAVE read_loop;
        END IF;

        CALL gerar_folha(v_funcionario, p_competencia);

    END LOOP;

    CLOSE cursor_func;
END $$

DELIMITER ;
