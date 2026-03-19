-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
/*
Procedure para incluir os funcionários na folha de pagamento, vai usar o ID e uma data para buscar 
o funcionário e trazer o salário dele além das outras informações como adicionais, descontos que
estão em tabelas diferentes.
*/
-- call gerar_folha(1, '2025-05-01')
/** 
SELECT * FROM encargos;
delete from folha_pagamento
where id_folha > 0;
call gerar_folha110('2025-05-01');
select * from folha_pagamento order by id_funcionario;      
select * from eventos_fixos;      
SELECT * FROM folha_pagamento;
SELECT * FROM eventos_fixos;
SELECT * FROM fechamento_ponto;

**/

DELIMITER $$

CREATE PROCEDURE gerar_folha_mensal(p_competencia DATE)

BEGIN
	    
    INSERT INTO folha_pagamento(
	  competencia,
      id_funcionario,
	  salario_base,
	  gratificacao,
      insalubridade,
      periculosidade,
      he_50,
      he_100,
      faltas,
	  inss,
	  irrf,
	  outros_descontos,
	  total_proventos,
	  total_descontos,
	  liquido,
	  fgts,
	  inss_empresa,
	  terceiros)
      
	SELECT
      p_competencia,
      funcionario_,
      salario_,
      
	-- ADICIONAIS
      gratificacao_,
      insalubridade_,
      periculosidade_,      
      
	-- PONTO 
      he_50_,
      he_100_,
      falta_,
      
	-- INSS IRRF
      inss_,
      irrf_,
            
      outros_descontos_,
      
	-- Totais
      total_proventos_,
      total_descontos_,
      liquido_,
      
	-- Encargos
      fgts_,
	  inss_empresa_,
	  terceiros_
      
	FROM 
		(SELECT
		  f.id_funcionario as funcionario_,
		  f.salario as salario_,
		  
		  -- ADICIONAIS --
		  sum(CASE WHEN eventof_id between 2 AND 3 then ef.valor else 0 end) as gratificacao_,
		  sum(CASE WHEN eventof_id between 4 AND 6 then ef.valor else 0 end) as insalubridade_,
		  f.salario * sum(CASE WHEN eventof_id = 7 then ef.percentual else 0 end) as periculosidade_,      
		  
		  -- PONTO --
		  sum(case when fp.id_evento_ponto = 1 then fp.valor else 0 END) as he_50_,
		  sum(case when fp.id_evento_ponto = 2 then fp.valor else 0 END) as he_100_,
		  sum(case when fp.id_evento_ponto = 3 then fp.valor else 0 END) as falta_,
		  
		  -- INSS e IRRF --
		  calcula_inss(f.salario + sum(ef.valor)) as inss_,
		  calcula_irrf1(f.id_funcionario, f.salario - calcula_inss(f.salario)) as irrf_,
          
          0 as outros_descontos_,
          
		  -- Totais --
          f.salario + sum(ef.valor) + (f.salario * sum(CASE WHEN eventof_id = 7 then ef.percentual else 0 end)) as total_proventos_,
		  calcula_inss(f.salario + sum(ef.valor)) + calcula_irrf1(f.id_funcionario, f.salario - calcula_inss(f.salario)) as total_descontos_,
		  f.salario + sum(ef.valor) - (calcula_inss(f.salario + sum(ef.valor)) + calcula_irrf1(f.id_funcionario, f.salario - calcula_inss(f.salario))) as liquido_,
          
          -- Encargos -- 
          
			-- FGTS
		  round((f.salario + sum(ef.valor) + (f.salario * sum(CASE WHEN eventof_id = 7 then ef.percentual else 0 end))) * 
          (select e.percentual from encargos e where e.id_encargo = 1), 2) as fgts_,
          
			-- INSS EMPRESA
		  round((f.salario + sum(ef.valor) + (f.salario * sum(CASE WHEN eventof_id = 7 then ef.percentual else 0 end))) * 
          (select e.percentual from encargos e where e.id_encargo = 2), 2) as inss_empresa_,
          
          -- TERCEIROS
		  round((f.salario + sum(ef.valor) + (f.salario * sum(CASE WHEN eventof_id = 7 then ef.percentual else 0 end))) * 
          (select e.percentual from encargos e where e.id_encargo = 3), 2) as terceiros_
		  
		  FROM funcionarios f
		  join funcionario_eventof fe
		  ON f.id_funcionario = fe.funcionario_id
		  JOIN eventos_fixos ef
		  ON ef.id_eventof = fe.eventof_id
		  LEFT JOIN fechamento_ponto fp
		  ON fp.id_funcionario = f.id_funcionario
          
		  group by f.id_funcionario
		) as tabela_calculo;
      
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

/*
Procedure para fechar o ponto geral
Vai pegar as informações da tabela resumo_ponto_mensal e jogar na fechamento_ponto já fazendo os devidos cálculos.
As informações geradas serão buscadas na procedure e consolidadas na folha de pagamento.
*/
-- select * from resumo_ponto
-- select * from eventos_ponto
-- select * from fechamento_ponto

DELIMITER $$

CREATE PROCEDURE fecha_ponto(p_competencia DATE)

begin 

insert into fechamento_ponto(competencia, id_funcionario, valor_he_50, valor_he_100, valor_falta)

select 
	p_competencia,
	f.id_funcionario,
    round(sum(case when rp.id_evento_ponto = 1 then (rp.quantidade * ((f.salario / 220) * ep.percentual)) else 0 end), 2),
    round(sum(case when rp.id_evento_ponto = 2 then (rp.quantidade * ((f.salario / 220) * ep.percentual)) else 0 end), 2),
    round(sum(case when rp.id_evento_ponto = 3 then (rp.quantidade * (f.salario / 30)) else 0 end), 2)
FROM funcionarios f
join resumo_ponto rp
on rp.id_funcionario = f.id_funcionario
join eventos_ponto ep
on ep.id_evento_ponto = rp.id_evento_ponto
where p_competencia = rp.competencia
group by f.id_funcionario;

END $$

DELIMITER ;

-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
/*
Procedure para recalcular o ponto individual.
Faz basicamente a mesma coisa que a procedure fecha_ponto mas aque servirá para dar um cálculo ou recálculo individual 
*/

DELIMITER $$

CREATE PROCEDURE fecha_ponto_individual(p_idfuncionario int, p_id_evento int, p_competencia date)

BEGIN
		DECLARE v_salario decimal(10,2);
        DECLARE v_quantidade decimal(10,2);
        DECLARE v_valor decimal(10,2);
        
        select salario into v_salario from
        funcionarios
        where id_funcionario = p_idfuncionario;
                
        select quantidade into v_quantidade
        from resumo_ponto rp
        where rp.id_funcionario = p_idfuncionario
        and rp.id_evento_ponto = p_id_evento
        and rp.competencia = p_competencia;
        
        set v_valor = v_quantidade * 10;
        
        insert into fechamento_ponto(competencia, id_funcionario, id_evento_ponto, quantidade, valor)
        values
        (p_competencia, p_idfuncionario, p_id_evento, v_quantidade, v_valor);

END $$


-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
/*
Procedure para incluir um funcionáriro
select * from funcionarios
CALL inclui_funcionario4('Flavio Couto de Matos', '1985-11-12', 'masculino', '2025-10-15', 69000.00, 9, 9, 4)
*/

DELIMITER $$

CREATE PROCEDURE inclui_funcionario(
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