
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
Ela faz o cálculo mais complexo conforme a legislação, preciso apenas confirmar se usei o modelo correto pois tem muita informação divergente sobre o novo cálculo do INSSvai buscar na tabela.
Como a alíquota ou é 0 ou é 27.5% eu coloquei o cálculo todo dentro da função, diferente da do INSS que ele busca as alíquotas numa tabela separada.
Quero ajustar na verdade mas não vejo necessidade.
*/

DELIMITER $$

CREATE FUNCTION calcula_irrf5(IDfuncionario INT, valor_apos_desconto_inss DECIMAL(10,2))
	RETURNS decimal(10,2)
    deterministic
    
BEGIN

	declare v_salario DECIMAL(10,2);
    declare v_desconto_irrf DECIMAL(10,2);
    declare v_desconto_sem_redutor DECIMAL(10,2);
    declare v_redutor DECIMAL(10,2);
    declare resultado varchar(500);
        
	select salario
    INTO v_salario
    FROM funcionarios
    WHERE id_funcionario = IDfuncionario;
        
    IF valor_apos_desconto_inss < 5000.00 THEN
		SET v_desconto_irrf = 0;
    ELSE 
		SET v_desconto_sem_redutor = (valor_apos_desconto_inss * 0.275) - 908.75;
		SET v_redutor = 978.62 - (v_salario * 0.133145);
        SET v_desconto_irrf = v_desconto_sem_redutor - v_redutor;
		               
    END IF;
    
    RETURN v_desconto_irrf;
    
END $$

DELIMITER ;

-- ------------------------------------------
-- ------------------------------------------
-- ------------------------------------------

/* 
Função para calcular IRRF
Essa eu tinha feito de forma bruta, se ganha acima de 5.000,00 é aplicado 27,5% se for menos não tem desconto, sei que não funciona assim mas fica pra uma futura melhoria.
Vou deixar de histórico


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

*/