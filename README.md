# Sistema de Folha de Pagamento (Projeto SQL)

Projeto autoral desenvolvido para praticar modelagem relacional, procedures, funções e análises em SQL.

## 🎯 Objetivo
Simular um sistema simplificado de folha de pagamento contendo:
- Cadastro de Funcionários
- Departamentos e Cargos
- Geração automática de folha via Procedure
- Cálculo de INSS e IRRF
- Análises salariais e demográficas

## 🛠 Tecnologias
- MySQL
- SQL (Views, Procedures, Functions)

## 📊 Análises Desenvolvidas até o momento
- Média salarial geral
- Média salarial por departamento
- Média salarial por cargo
- Distribuição por departamento cargo
- Distribuição por cargo
- Análise por tipo de despesa
- Distribuição por sexo
- Criação de View com nome do cargo e departamento além da idade calculada
- Mapa do Plano de Saúde


## 🔄 Próximas etapas


- Melhorar cálculo dos impostos patronais, talvez criar sua própria tabela e seu procedure, ver se dá pra juntar já no cálculo da folha geral
- Ajustar a procedure do cálculo de folha para adaptar a criação das novas tabelas do plano de saúde e eventos fixos;
- Criar uma tabela de ausencias ou afastamentos pra poder proporcionalizar as coisas;
- Histórico salarial (pendente - não sei se vou conseguir, deixar pro futuro)


- ESSA É MUITO IMPORTANTE MAS ACHO QUE FICA PRO FINAL, AO INVES DE FAZER O CALCULO DA FOLHA VIA 'CURSOR' (ENTENDER MELHOR O QUE É ISSO DEPOIS), FAZER A INCLUSÃO VIA INSERT, CHAT TINHA ME SUGERIDO NÃO SABIA COMO FAZER E NÃO QUERIA QUE ELE ME RESPONDESSE COMO FARIA MAS ESSE PROJETO TEM ABERTO MINHA MENTE E ACHO QUE SEI COMO FAREI ISSO AGORA, MAS SERÁ UM POUCO TRABALHOSO E CONFUSO ENTÃO FAREI MAIS PARA O FINAL, QUANDO JÁ ESTIVER COM A MAIORIA DAS FUNÇÕES CRIADAS E TUDO RODANDO MELHOR.

## 🔄 CONCLUÍDOS

- Refatoração da Tabela eventos_fixos (antiga fixos_folha), modelo horizontal para vertical- OK
- Simulação de encargos (FGTS, INSS empresa) - OK 
- Cálculo progressivo completo de IRRF - OK;
- Rafazer o insert de funcionários colocando o código dos eventos fixos e do plano de saúde - OK;


**** TABELAS ****

- Tabela Cargos - 16/02/2026
- Tabela Departamentos - 16/02/2026
- Tabela Funcionarios - 16/02/2026
- Tabela Folha_Pagamento - 17/02/2026
- Tabela Tb_inss - 17/02/2026
- Tabela Resumo_folha - 18/02/2026
- Tabela Fixos_Folha - 18/02/2026 (Substituída pela tabela 'eventos_fixos')
- Tabela Eventos_fixos - 19/02/2026
- Tabela Plano_saude - 19/02/2026

**** PROCEDURES ****

- Procedure gerar_folha(id_funcionario, competencia) - 17/02/2026
- Procedure gerar_folha_mensal(competencia) - 17/02/2026

**** Funções ****

- calcula_irrf(p_salario DECIMAL(10,2))
- calcula_inss(p_salario DECIMAL(10,2))


---

Projeto em evolução contínua 🚀
