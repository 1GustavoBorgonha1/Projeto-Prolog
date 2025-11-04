% Força o Prolog a usar a codificação UTF-8 para ler e escrever.
:- set_prolog_flag(encoding, utf8).

% Esta linha carrega todos os outros arquivos.
:- ['kb.pl','rules.pl', 'ui.pl', 'explain.pl'].

% Predicado inicial
start :-
    banner,
    menu.

% Mostra o banner com os nomes dos desenvolvedores
banner :-
    format("~n=== Sistema Especialista - Cálculo de Plano de Saúde (Lógica) ===~n"),
    format("Desenvolvido por: Vitor Hugo Tavares e Gustavo Borgonha~n~n").

% Menu principal
menu :-
    format("1) Executar consulta~n2) Sair~n> "),
    read(Opt),
    ( Opt = 1 -> 
        run_case, 
        menu
    ; Opt = 2 -> 
        format("Saindo...~n")
    ; 
        format("Opcao invalida.~n"), 
        menu 
    ).

% Orquestra a execução de um único caso
run_case :-
    cleanup,                % Limpa a memória ANTES de coletar novos dados
    coletar_observacoes,    % Agora limpamos ANTES de coletar novos dados
    ( meta(Result) ->       
        explicar(Result),   
        format("~nRESULTADO FINAL: ~w~n", [Result])
    ; 
        format("~nNao foi possivel gerar um resultado. Revise as regras ou entradas.~n")
    ).