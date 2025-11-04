% Explica o resultado, mostrando a trilha de regras
explicar(resultado(Mensalidade, CopartFinal, CustoTotal)) :-
    % Busca os fatos da memória
    obs(nome(Nome)),
    obs(idade(Idade)),
    
    format("~n[Explicacao do Calculo para: ~w (Idade: ~w)]~n", [Nome, Idade]),
    format("- Regra 'calcula_mensalidade' (Idade ~w): R$ ~w~n", [Idade, Mensalidade]),
    
    format("~n- Regra 'calcula_coparticipacao_bruta' (Soma dos procedimentos):~n"),
    % Loop forçado para imprimir todos os procedimentos
    explica_procedimentos,
    
    calcula_coparticipacao_bruta(CopartBruta),
    limite_coparticipacao(Limite),
    format("~n- Soma Bruta da Coparticipação: R$ ~w~n", [CopartBruta]),
    format("- Regra 'aplica_limite_coparticipacao' (Limite de R$ ~w): R$ ~w~n", [Limite, CopartFinal]),
    
    format("~n- REGRA FINAL 'meta' (Mensalidade + Copart. Final): R$ ~w~n", [CustoTotal]).

% Predicado auxiliar para imprimir todos os procedimentos
% Usa 'fail' para forçar o backtracking e encontrar todos os fatos 'obs(procedimento...)'
explica_procedimentos :-
    obs(procedimento(Nome, Valor)),
    calcula_custo_procedimento(Nome, Valor, CustoCopart),
    format("  - Procedimento: ~w (Valor R$~w) -> Copart R$~w~n", [Nome, Valor, CustoCopart]),
    fail. % Falha para buscar o próximo
explica_procedimentos :- true. % Sucesso quando não há mais procedimentos