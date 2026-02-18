
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
/* 
Função para calcular INSS
Ela vai buscar na tabela de INSS (tb_inss) a aliquota filtrando o salario que foi informado se está entre o valor minimo e calor maximo de cada faixa, 
depois faz o cáluclo do salário * a alíquota 
*/

DELIMITER $$

CREATE FUNCTION calcula_inss(p_salario DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_aliquota DECIMAL(5,2);
    DECLARE v_valor DECIMAL(10,2);

    SELECT aliquota
    INTO v_aliquota
    FROM tb_inss
    WHERE p_salario BETWEEN faixa_inicial AND faixa_final
    LIMIT 1;

    SET v_valor = p_salario * (v_aliquota / 100);

    RETURN v_valor;
END $$

DELIMITER ;

-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
/* 
Função para calcular IRRF
Fiz de forma bruta, se ganha acima de 5.000,00 é aplicado 27,5% se for menos não tem desconto, sei que não funciona assim mas fica pra uma futura melhoria.
*/

DELIMITER $$

CREATE FUNCTION calcula_irrf(p_salario DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_valor_irrf DECIMAL(10,2);

    IF p_salario < 5000 then
		SET v_valor_irrf = 0;
	ELSE
		SET v_valor_irrf = p_salario * 0.275;
	end if;

    RETURN v_valor_irrf;
END $$

DELIMITER ;