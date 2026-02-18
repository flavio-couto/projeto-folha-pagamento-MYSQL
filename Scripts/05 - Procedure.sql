
-- Procedure para incluir os funcionários na folha de pagamento
DELIMITER $$

CREATE PROCEDURE gerar_folha (
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
    DECLARE v_cargo DECIMAL(10,2);

    SELECT salario, id_cargo
    INTO v_salario, v_cargo
    FROM funcionarios
    WHERE id_funcionario = p_funcionario;

    IF v_cargo between 4 and 7 then
        SET v_adicionais = 350;
	else
		SET v_adicionais = 0;
	END IF;
    
    SET v_total_proventos = v_salario + v_adicionais;
    SET v_inss = calcula_inss(v_salario + v_adicionais); -- v_salario * 0.08;
    SET v_irrf = calcula_irrf(v_total_proventos - v_inss);
    SET v_outros_descontos = 0; -- Criar algo para isso    
    SET v_total_descontos = v_inss + v_irrf + v_outros_descontos;
    SET v_liquido = v_total_proventos - v_total_descontos;

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
        liquido   
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
        v_liquido        
    );
END $$

DELIMITER ;
-- 

