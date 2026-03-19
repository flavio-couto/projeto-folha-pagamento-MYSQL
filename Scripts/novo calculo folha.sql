select * from eventos_fixos;
 SELECT
      id_funcionario,
      (select ef.valor from eventos_fixos ef where ef.id_eventof = f.id_evento_fixo);
      
      select f.id_funcionario, ef.valor
      from funcionarios f
      join eventos_fixos ef
      ON f.id_evento_fixo = ef.id_eventof;
      
select f.id_funcionario,
coalesce(
	case 
		WHEN f.id_evento_fixo = 2 then ef.valor
		WHEN f.id_evento_fixo = 3 then ef.valor
	end, 0)
from funcionarios f
join eventos_fixos ef
where f.id_evento_fixo = ef.id_eventof;


DELIMITER $$

CREATE FUNCTION calcula_gratificacao(p_id_funcionario INT)
RETURNS decimal(10,2) deterministic
BEGIN

	DECLARE v_gratificacao decimal(10,2);
    
	select
	coalesce(
		case 
			WHEN f.id_evento_fixo = 2 then ef.valor
			WHEN f.id_evento_fixo = 3 then ef.valor
		end, 0) INTO v_gratificacao
	from funcionarios f
	join eventos_fixos ef
	where f.id_evento_fixo = ef.id_eventof and f.id_funcionario = p_id_funcionario;

	return v_gratificacao;
END $$

DELIMITER ;

