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