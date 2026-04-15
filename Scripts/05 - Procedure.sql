-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------
/*
Procedure para incluir os funcionários na folha de pagamento, vai usar o ID e uma data para buscar 
o funcionário e trazer o salário dele além das outras informações como adicionais, descontos que
estão em tabelas diferentes.
*/
-- call calcular_folha('2025-05-01')
/** 
SELECT * FROM encargos;
delete from folha_pagamento
where id_folha > 0;
call fecha_ponto('2025-05-01');
call calcular_folha('2025-05-01');
select * from folha_pagamento order by id_funcionario;      
select * from eventos_fixos;      
SELECT * FROM folha_pagamento;
SELECT * FROM eventos_fixos;
SELECT * FROM fechamento_ponto;
SELECT * FROM resumo_ponto;

**/

DELIMITER $$

CREATE PROCEDURE calcular_folha(p_competencia DATE)

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
      plano_saude,
      outros_descontos,
	  inss,
	  irrf,	  
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
      
      -- PLANO DE SAUDE
      plano_saude_,
      
      -- OUTROS DESCONTOS      
      outros_descontos_,     
      
	-- INSS IRRF
      inss_,
      irrf_,
           
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
		  max(CASE WHEN eventof_id between 2 AND 3 then ef.valor else 0 end) as gratificacao_,
		  max(CASE WHEN eventof_id between 4 AND 6 then ef.valor else 0 end) as insalubridade_,
		  f.salario * sum(CASE WHEN eventof_id = 7 then ef.percentual else 0 end) as periculosidade_,      
		  
		  -- PONTO --
		  coalesce(max(fp.valor_he_50), 0) as he_50_,
		  coalesce(max(fp.valor_he_100), 0) as he_100_,
		  coalesce(max(fp.valor_falta), 0) as falta_,
		  
          -- PLANO DE SAUDE --
          
          max(ps.parte_colaborador) as plano_saude_,
          
          -- OUTROS DESCONTOS
          0 as outros_descontos_,
          
		  -- INSS e IRRF --
		  calcula_inss(f.salario + coalesce(sum(ef.valor), 0)) as inss_,
		  calcula_irrf1(f.id_funcionario, f.salario - calcula_inss(f.salario)) as irrf_,
                            
		  -- Totais --
          f.salario + coalesce(sum(ef.valor), 0) + (f.salario * sum(CASE WHEN eventof_id = 7 then ef.percentual else 0 end)) as total_proventos_,
		  calcula_inss(f.salario + coalesce(sum(ef.valor), 0)) + calcula_irrf1(f.id_funcionario, f.salario - calcula_inss(f.salario)) as total_descontos_,
		  f.salario + coalesce(sum(ef.valor), 0) - (calcula_inss(f.salario + coalesce(sum(ef.valor), 0)) + calcula_irrf1(f.id_funcionario, f.salario - calcula_inss(f.salario))) as liquido_,
          
          -- Encargos -- 
          
			-- FGTS
		  round((f.salario + coalesce(sum(ef.valor), 0) + (f.salario * sum(CASE WHEN eventof_id = 7 then ef.percentual else 0 end))) * 
          (select e.percentual from encargos e where e.id_encargo = 1), 2) as fgts_,
          
			-- INSS EMPRESA
		  round((f.salario + coalesce(sum(ef.valor), 0) + (f.salario * sum(CASE WHEN eventof_id = 7 then ef.percentual else 0 end))) * 
          (select e.percentual from encargos e where e.id_encargo = 2), 2) as inss_empresa_,
          
          -- TERCEIROS
		  round((f.salario + coalesce(sum(ef.valor), 0) + (f.salario * sum(CASE WHEN eventof_id = 7 then ef.percentual else 0 end))) * 
          (select e.percentual from encargos e where e.id_encargo = 3), 2) as terceiros_
		  
		  FROM funcionarios f
		  LEFT JOIN  funcionario_eventof fe
		  ON f.id_funcionario = fe.funcionario_id
		  LEFT JOIN eventos_fixos ef
		  ON ef.id_eventof = fe.eventof_id
		  LEFT JOIN fechamento_ponto fp
		  ON f.id_funcionario = fp.id_funcionario
          LEFT JOIN funcionario_plano fps
          ON f.id_funcionario = fps.funcionario_id
          LEFT JOIN plano_saude ps
          ON ps.id_planoS = fps.plano_saude_id
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

