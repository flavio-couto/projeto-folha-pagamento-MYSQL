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

CREATE PROCEDURE gerar_folha110(p_competencia DATE)

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