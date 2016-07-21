#Critérios de Aceite:
#Não deve aceitar data fim maior que data início
#Somente usuários master podem excluir os registros (não desativados e registros que ainda não estão em uso)
#Quando inserir uma nova jornada/ampliação/redução deve aplicar a regra de atualizar a data fim do registro anterior com a data início declada -1 dia
#Para cadastrar uma ampliação o usuário deve ter uma jornada já cadastrada
#Para cadastrar uma redução o usuário precisa ter uma ampliãção já cadastrada
#O sistema não deve permitir a inserção de dois registros dentro do mesmo período


Feature: Funcionalidade de Cadastro da Jornada, Ampliação e Redução da aba Contratual dentro do cadastro do funcionário.

  Scenario: 1 Cadastrando uma nova jornada com sucesso.
    Given o tipo do usuário é "Docente"
    And insiro uma data de início da "Jornada" maior que a data de "Admissão" do funcionário
    And insiro "Tabela de Referências de Aulas Docente" ativa
    When eu apertar "Salvar"
    Then eu devo ver a nova "Jornada" na listview da "Jornada Contratual"

  Scenario: 2 Cadastrando uma nova jornada com data de início inferior a data de admissão do funcionário.
    Given o tipo do usuário é "Docente"
    And insiro uma data de início da "Jornada" menor que a data de "Admissão" do funcionário
    And insiro "Tabela de Referências de Aulas Docente" ativa
    When eu apertar "Salvar"
    Then eu devo ver uma mensagem informando "Não é possível ter uma jornada antes da contratação da pessoa!"
    But o sistema não deve permitir salvar esse registro

  Scenario: 3 Cadastrando uma ampliação de um professor que preencheu a inscrição e declarou a quantidade.
    Given o funcionário já lançou uma "Nova Jornada"
    And preencheu o campo qntde na "Incrição do Professor" para ampliação com o número 10
    And insiro uma data de início da "Ampliação" maior que a data de início da "Jornada"
    When eu apertar "Adicionar" na seção "Jornada Contratual"
    Then eu devo ver o campo "Data Início" preenchido com a data de início da primeira jornada cadastrada 
    And eu devo ver o campo "Data Fim" preenchido com a data de fim da primeira jornada cadastrada
    And eu devo ver o campo "Jornada" preenchido com a jornada selecionada na primeira jornada cadastrada
    And eu devo ver o campo "Solicitado" preenchido com o número 10

  Scenario: 4 Cadastrando uma ampliação para um cliente que limita a quantidade de ampliação no configurador
    Given o funcionário já lançou uma "Nova Jornada"
    And preencheu o campo qntde na "Incrição do Professor" para ampliação com o número 10
    And insiro uma data de início da "Jornada" maior que a data de "Admissão" do funcionário
    And o configurador do cliente limita ampliação em 20
    When eu atribuir no campo "Autorizado" o número 30
    And clicar em "Salvar"
    Then eu devo ver a seguinte mensagem "Total de Ampliação ultrapassa a quantidade máxima permitida!"
    But o sistema não deve permitir salvar esse registro

  Scenario: 5 Cadastrando uma redução maior que a quantidade de aulas ampliadas anteriormente.
    Given que existe uma "Ampliação" já cadastrada com 10 autorizadas
    When eu for lançar uma "Redução"
    And autorizar 20
    And clicar em "Salvar"
    Then eu devo ve ruma mensagem informando "Para realizar essa operação, é necessário alterar a jornada contratual do funcionário! Utilizando a opção “Nova Jornada”!"
    But o sistema não deve permitir salvar esse registro
  
  Scenario: 6 Inserindo uma segunda Jornada, Ampliação ou Redução para inserir data fim na Jornada anterior.
    Given já existe uma primeira "Jornada" com "Data Início" igual a 10/08/2016
    And "Data Fim" igual a 23/12/2016
    When eu inserir uma nova "Amplicação" com data inicio igual a 22/12/2016
    And sem "Data Fim"
    And clicar em "Salvar"
    Then o sistema deve atualizar a "Data Fim" do primeiro registro para 21/12/2016

  Scenario: 7 Autorizando uma ampliação maior que a quantidade solicitada pelo funcionário.
    Given um funcionario solicitou a quantidade para ampliação igual a 5 na "Incrição do Professor"
    When eu declarar no campo "Autorizado" a quantidade de 10
    And clicar no "Salvar"
    Then eu devo ver uma mensagem informando "O valor autorizado não pode ser maior que o campo “Solicitado”!"
    But o sistema não deve permitir salvar esse registro

  Scenario: 8 Criando uma ampliação/redução em que a quantidade de aulas não corresponda com nenhum registro da tabela de referência de aulas docente.
    Given o funcionário já lançou uma "Nova Jornada"
    When eu inserir uma quantidade de ampliação que faça a soma criar uma jornada que não tenha uma tabela de referencia cadastrada
    And mudar o foco para o próximo campo
    Then eu devo ver uma mensagem "Não há cadastro existente desta jornada na Tabela de referência de Aulas Docente!"
    But o sistema não deve permitir salvar esse registro