:- dynamic obs/1. % Fatos temporários sobre a consulta

% Coleta os dados do beneficiário (como em 'handleAddBeneficiario')
coletar_observacoes :-
    format("~n--- Dados do Beneficiário ---~n"),
    format("Nome: "),
    read(Nome), assertz(obs(nome(Nome))),
    
    format("Idade: "),
    read(Idade), assertz(obs(idade(Idade))),
    
    format("~n--- Procedimentos Utilizados ---~n"),
    coletar_procedimentos. % Inicia o loop de coleta de procedimentos

% Loop recursivo para adicionar procedimentos (como em 'handleAddProcedimento')
coletar_procedimentos :-
    format("Adicionar procedimento? (s/n): "),
    read(Resp),
    ( Resp == s ->
        format("Nome ('Consulta Clínica', 'Exame de Imagem', ...): "),
        read(ProcNome),
        format("Valor do Procedimento (R$): "),
        read(ProcValor),
        
        % Salva o procedimento na memória
        assertz(obs(procedimento(ProcNome, ProcValor))),
        coletar_procedimentos % Chama a si mesmo para adicionar outro
    ;
        format("~nColeta finalizada. Processando...~n")
    ).

% Limpa a memória após a consulta (como no exemplo 'Triagem TI') [cite: 148]
cleanup :-
    retractall(obs(_)).