#TESTE EXPLORATÓRIO > UTF8
#http://svrdev001/carloscarucce/utf8test/gpdgestao/

	Feature: Cadastro de classe comum.
	 Scenario: Cadastrando uma classe multisseriada para o ano de 2016,
	 	Given que já existe uma "Matriz Curricular" ativa
	 	When eu preencher todos os campos obrigatórios
	 	And clicar em "Salvar"
	 	Then eu devo ver na minha tela a seguinte mensagem "Registro inserido com sucesso!"
	 	And o novo registro deve ser salvo
	 	#PASSOU

	Feature: Cadastro de jornada contratual dentro do cadastro do funcionário.
	 Scenario: Cadastrando uma nova jornada com data de início inferior a data de admissão do funcionário.
	 	Given o tipo do usuário é "Docente"
   	 	And insiro uma data de início da "Jornada" menor que a data de "Admissão" do funcionário
    	And insiro "Tabela de Referências de Aulas Docente" ativa
    	When eu apertar "Salvar"
    	Then eu devo ver uma mensagem informando "Não é possível ter uma jornada antes da contratação da pessoa!"
    	But o sistema não deve permitir salvar esse registro
    	#PASSOU

	Feature: Validação de CPF no cadastro de funcionário.
	 Scenario:

