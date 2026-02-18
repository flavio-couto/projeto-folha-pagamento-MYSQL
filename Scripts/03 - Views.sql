-- View Do Funcionário com o nome do cargo e departamento ao invés dos códigos, além de incluir a idade de cada um
CREATE VIEW view_resumo_funcionario AS
select f.nome, TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) AS idade, c.nome as cargo, salario, d.nome as Departamento
from 
	funcionarios f
join cargos c on f.id_cargo = c.id_cargo
join departamentos d on d.id_departamento = f.id_departamento
;

SELECT * FROM view_resumo_funcionario;