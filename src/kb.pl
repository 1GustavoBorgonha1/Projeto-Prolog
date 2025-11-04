% Fatos da TABELA_MENSALIDADE_POR_FAIXA
% formato: mensalidade_faixa(IdadeMin, IdadeMax, ValorBase).
mensalidade_faixa(0, 18, 200.00).
mensalidade_faixa(19, 23, 250.00).
mensalidade_faixa(24, 28, 300.00).
mensalidade_faixa(29, 33, 350.00).
mensalidade_faixa(34, 38, 400.00).
mensalidade_faixa(39, 43, 450.00).
mensalidade_faixa(44, 48, 500.00).
mensalidade_faixa(49, 53, 550.00).
mensalidade_faixa(54, 999, 600.00). % Usando 999 para representar 'Infinity'

% Fatos da TABELA_PROCEDIMENTOS
% formato: procedimento_regra(NomeAtomizado, PercentualCoparticipacao).
% Nota: O 'valor_referencia' do seu JS não é usado no cálculo,
% pois o usuário informa o valor na tela. Vamos manter essa lógica.
procedimento_regra('Consulta Clínica', 0.30).
procedimento_regra('Exame Laboratorial Simples', 0.40).
procedimento_regra('Procedimento de Baixa Complexidade', 0.20).
procedimento_regra('Exame de Imagem', 0.15).

% Fato da REGRAS_FRANQUIA
% formato: limite_coparticipacao(Valor).
limite_coparticipacao(300.00).