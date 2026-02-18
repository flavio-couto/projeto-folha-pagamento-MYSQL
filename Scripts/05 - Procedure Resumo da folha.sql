-- SELECT * FROM folha_pagamento;
-- SELECT * FROM resumo_folha;
-- call gera_resumo_folha('2025-05-01');



DELIMITER $$

-- Essa procedure contem os mesmos campos que a Folha de Pagamento mas aqui ela vai trazer o total (SUM)
-- de todas as colunas da tabela (salario, adicionais, descontos, impostos), tendo assim um resumo dela.

CREATE PROCEDURE gera_resumo_folha(
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