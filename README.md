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
- Criar uma tabela de ausencias ou afastamentos pra poder proporcionalizar as coisas;
- Histórico salarial (pendente - não sei se vou conseguir, deixar pro futuro)
- Tabela de ponto diário e procedure para jogar para o resumo

- Separar insalubridade de Gratificação de Periculosidade, criar uma tabela pra cada, vai melhorar o select da folha
- Voltei o modelo da procedure de calculo de folha para adicionais ao inves de beneficios separados, mas futuramente separar com COALESCE
- Criar Views (Resumo do ponto, Mapa benefícios)


- ESSA É MUITO IMPORTANTE MAS ACHO QUE FICA PRO FINAL, AO INVES DE FAZER O CALCULO DA FOLHA VIA 'CURSOR' (ENTENDER MELHOR O QUE É ISSO DEPOIS), FAZER A INCLUSÃO VIA INSERT, CHAT TINHA ME SUGERIDO NÃO SABIA COMO FAZER E NÃO QUERIA QUE ELE ME RESPONDESSE COMO FARIA MAS ESSE PROJETO TEM ABERTO MINHA MENTE E ACHO QUE SEI COMO FAREI ISSO AGORA, MAS SERÁ UM POUCO TRABALHOSO E CONFUSO ENTÃO FAREI MAIS PARA O FINAL, QUANDO JÁ ESTIVER COM A MAIORIA DAS FUNÇÕES CRIADAS E TUDO RODANDO MELHOR.

## 🔄 CONCLUÍDOS

- Refatoração da Tabela eventos_fixos (antiga fixos_folha), modelo horizontal para vertical- OK
- Simulação de encargos (FGTS, INSS empresa) - OK
- Cálculo progressivo completo de IRRF - OK
- Rafazer o insert de funcionários colocando o código dos eventos fixos e do plano de saúde - OK
- Criar uma tabela intermediária (Funcionário X Plano de Saúde) - OK
- Incluir inteligencia para faltas na procedure do fechamento de ponto - OK
- Ajustar a procedure do cálculo de folha para adaptar a criação das novas tabelas intermediárias do plano de saúde e eventos fixos - OK
- Criar todas as procedures para inclusão no banco - OK


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
- Tabela Eventos_ponto - 25/02/2026
- Tabela Resumo_ponto - 25/02/2026
- Tabela Fechamento_ponto - 25/02/2026
- Tabela funcionario_plano - 13/04/2026


**** PROCEDURES ****

- gerar_folha() - 17/02/2026
- calcular_folha() - 13/04/2026 - Atualizada para atender a tabela intermediária do plano de saúde
- fecha_ponto_individual() - 25/02/2026
- fecha_ponto() - 26/02/2026
- cadastrar_funcionario(), cadastrar_cargo(), cadastrar_departamento() - 15/04/2026
- cadastrar_eventos_fixos(), cadastrar_eventos_ponto() - 15/04/2026
- cadastrar_plano_saude(), cadastrar_encargo() - 15/04/2026


**** Funções ****

- calcula_irrf(p_salario DECIMAL(10,2))
- calcula_inss(p_salario DECIMAL(10,2))


*******************************************
------ APRENDIZADOSSSSSSSSSSSSSSSSSS ------
*******************************************

já tinha estudado bastante via cursos da Alura ou outros, sempre vi vários conceitos, conseguia ler ali o código, entender o que ele estava fazendo, saber alterar o que fosse necessário mas se pedisse pra eu fazer muitas vezes travava, tinha uma idéia na cabeça do que fazer mas sempre sem entender direito e esse projeto tem me feito aprender de vez várias coisas que acho que não esqueço mais, por que realmente aprendi, segue alguns deles:

- Quando criar uma tabela? 
    No início do projeto já travei um pouco pensando como faria para incluir o sexo no cadastro do colaborador, precisaria criar uma tabela ali com o id 1 e 2 (masculino e feminino), foi quando aprendi sobre o ENUM, como disse já tinha visto várias vezes mas não entendia bm em quais casos usaria e agora consigo compreender, se não forem muitas opções, se fore, opções ali que não vão "crecer" pode ser usado um ENUM, isso serviu para outras coisas que pensava em criar uma tabela separado como o tipo de cargo (Operacional, Tático, Estratégico), para o tipo de despesa (direta ou indireta) e mais alguns.

- Relacionamento N:N
    Outro conceito já visto bastante mas que não estava totalmente compreendido até agora e consegui entender. Fiz um curso recente sobre modelagem e vi que lá falava sobre o perigo de um relacionamento N:N, na minha cabeça tinha guardado só, "sempre evitar isso" mas no projeto percebi que ele é extremamento necessário no caso das tabelas intermediárias para consolidar informações

- Tabelas intemediárias 
    Descobri que fugia muito dessas tabelas, tinha um certo medo de incluir elas pois não entendia também muito a necessidade, hoje já consegui perceber que certas coisas não dá pra fazer sem uma tabela intermediárias, seja por boas práticas ou por escalabilidade ou por boas práticas, ela são parte importante do projeto pro ponto, pros benefícios

- Procedure
    Já tinha feito umas 3 ou 4 nos cursos entendo ali o que estava sendo escrito, o que estava fazendo mas como disse se pedisse pra eu fazer até sabia o que deveria ser feito mas não conseguia traduzir em código, hoje entendo bem a estrutura dela, no caso de declarar as variavéis, setar as variáveis de diversas formas (através de select, um IF ou um cálculo qualquer) e depois inserilas na tabela correspondente, tem usado elas pra fechar o ponto, e principalmente pro cálculo da folha.

- Insert Select
    Ele é fantástico também, no começo do projeto tinha desenrolado a procedure pra calcular a folha mas não sabia como executar pra todos os funcionários, quando precisei do chatgpt pra fazer uma procedure pra fazer um looping na minha via cursor, mas já me informando que aquilo não seria uma boa prática e que eu poderia fazer um insert select praquilo, no momento deixei de lado pois tinha acabo de conseguir fazer dar certo mas depois de alguns dias resolvi tentar, a folha de pagamento é o coração do projeto precisava ajustar isso o mais breve possível antes que ficasse muito complexo e depois fosse mais difícil ainda pra alterar, nisso tenho aprendido bastante sobre insert select e seu potencial, basicamente todas as procedures que tinha feito viraram insert select, mantenho a procedure pra se for necessário dar um cálculo individual 

- Subquery


---

Projeto em evolução contínua 🚀
