% --- INÍCIO DO ARQUIVO: src/rules.pl ---

:- dynamic obs/1.
:- use_module(library(lists)). % Para usar sum_list

% É esta regra que o 'main.pl' está tentando chamar.
% Tradução de 'processarBeneficiario'
% O resultado será: resultado(Mensalidade, CopartFinal, CustoTotal)
meta(resultado(Mensalidade, CopartFinal, CustoTotal)) :-
    % 1. Validação (como 'validarBeneficiario')
    valida_dados,
    
    % 2. Calcula Mensalidade (como 'calcularMensalidade')
    calcula_mensalidade(Mensalidade),
    
    % 3. Calcula Coparticipação Bruta (como o 'map' + 'reduce')
    calcula_coparticipacao_bruta(CopartBruta),
    
    % 4. Aplica Limite (como o 'Math.min')
    aplica_limite_coparticipacao(CopartBruta, CopartFinal),
    
    % 5. Calcula Custo Total
    CustoTotal is Mensalidade + CopartFinal.

% --- REGRAS DE VALIDAÇÃO (R1, R2) ---
% (Tradução de 'validarBeneficiario')
% R1: Verifica se a idade é positiva
valida_dados :- 
    obs(idade(Idade)), Idade > 0, !.
% R2: Se a regra R1 falhar, esta roda e falha, mostrando uma mensagem
valida_dados :- 
    format("~n[Erro] Idade inválida. Abortando.~n"), !, fail.

% --- REGRAS DE CÁLCULO (R3, R4, R5, R6, R7, R8, R9) ---

% R3: Encontra a mensalidade pela idade (Tradução de 'calcularMensalidade')
calcula_mensalidade(Mensalidade) :-
    obs(idade(Idade)),
    mensalidade_faixa(Min, Max, Mensalidade),
    Idade >= Min, Idade =< Max, !.
% R4: Failsafe se a idade não for encontrada
calcula_mensalidade(0.0). 

% R5: Calcula a soma de todas as coparticipações (Tradução do 'reduce')
calcula_coparticipacao_bruta(CopartBruta) :-
    % Encontra todos os custos individuais e os coloca em uma lista
    findall(CustoCopart, 
            obs_custo_copart(CustoCopart), 
            ListaCustos),
    sum_list(ListaCustos, CopartBruta). % Soma a lista

% R6: Helper para encontrar o custo de UM procedimento (Tradução do 'map')
obs_custo_copart(CustoCopart) :-
    obs(procedimento(Nome, Valor)),
    calcula_custo_procedimento(Nome, Valor, CustoCopart).

% R7: Calcula o custo de um procedimento (Tradução de 'calcularCustoProcedimento')
calcula_custo_procedimento(Nome, Valor, CustoCopart) :-
    procedimento_regra(Nome, Percentual), !,
    CustoCopart is Valor * Percentual.
% R8: Failsafe se o procedimento não for encontrado na 'kb.pl'
calcula_custo_procedimento(_, _, 0.0).

% R9: Aplica o limite de R$300,00 (Tradução do 'Math.min' com a franquia)
aplica_limite_coparticipacao(CopartBruta, CopartFinal) :-
    limite_coparticipacao(Limite),
    CopartFinal is min(CopartBruta, Limite).
