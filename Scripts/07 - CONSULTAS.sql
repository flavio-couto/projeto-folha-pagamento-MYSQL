-- consultas

/* 
Enquanto modela, pense:
Como vou calcular turnover?
Como vou calcular absenteísmo?
Como vou calcular custo total da folha?
Como vou calcular média salarial por departamento?
--
Isso permite análises como:
Distribuição por nível hierárquico
Média salarial por tipo
Proporção estratégico vs operacional
*/
select * from funcionários;

-- Média Salarial da empresa
select avg(salario) as 'Média Salarial' from funcionarios;

-- Média salarial por departamento e contagem de funcionários
select d.nome, round(avg(salario),2) as 'Média Salarial', count(id_funcionario) as 'Total Funcionários' from funcionarios f
join departamentos d on f.id_departamento = d.id_departamento
group by d.nome
order by d.nome;

-- Média salarial por Cargo e contagem de funcionários
select c.nome as Cargo, round(avg(salario),2) as 'Média Salarial', count(id_funcionario) as 'Total Funcionários' from funcionarios f
join cargos c on c.id_cargo = f.id_cargo
group by c.nome
order by c.nome;

-- Média por tipo de despesa (Direta ou Indireta) e contagem de funcionários
select d.despesa, round(avg(salario),2) as 'Média Salarial', count(id_funcionario) as 'Total Funcionários' from funcionarios f
join departamentos d on d.id_departamento = f.id_departamento
group by d.despesa;

-- ANALISE POR SEXO

-- Contagem de homens e mulheres
select f.sexo, count(sexo)
from funcionarios f
group by f.sexo;

-- Contagem de homens e mulheres
select f.sexo, count(sexo) as total, concat(round(((select count(sexo) / (select count(*) from funcionarios) * 100)),2),"%") as percentual
from funcionarios f
group by f.sexo;

-- Contagem de homens e mulheres por Departamento
select d.nome as departamento, f.sexo, count(sexo)
from funcionarios f
join departamentos d on d.id_departamento = f.id_departamento
group by d.nome, f.sexo;

-- Contagem de homens e mulheres por Cargo
select c.nome as Cargo, f.sexo, count(sexo)
from funcionarios f
join cargos c on c.id_cargo = f.id_cargo
group by c.nome, f.sexo;

-- Turnover (usando demissão)
-- Distribuição por tipo de cargo
-- Custo total da folha

