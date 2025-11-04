# 👨‍⚕️ Sistema Especialista de Cálculo de Plano de Saúde (Prolog)

Projeto desenvolvido para a disciplina **Linguagem de Programação e Paradigmas** — Prof. Esp. Ademar Perfoll Junior.

Este projeto é uma "tradução" de um sistema de cálculo de plano de saúde (originalmente feito em JavaScript funcional) para o paradigma de **Programação Lógica** usando SWI-Prolog.

## 👥 Desenvolvedores

* **Vitor Hugo Tavares** 
* **Gustavo Borgonha** 

## 🎯 Objetivo do Projeto

O objetivo é desenvolver um sistema especialista em Prolog que calcula o custo mensal total de um beneficiário de plano de saúde. O sistema utiliza uma base de fatos e regras lógicas para inferir o preço final, combinando a mensalidade base (por idade) com a coparticipação (calculada sobre os procedimentos utilizados).

## 🧠 Funcionamento (Programação Lógica)

O sistema é dividido em módulos, seguindo a arquitetura sugerida, onde cada arquivo tem uma responsabilidade clara:

* **`src/kb.pl` (Base de Conhecimento):**
    Contém os **fatos** imutáveis do sistema. Funciona como nosso banco de dados, definindo:
    * `mensalidade_faixa/3`: O preço da mensalidade para cada faixa de idade (ex: `mensalidade_faixa(0, 18, 200.00).`).
    * `procedimento_regra/2`: O percentual de coparticipação para cada procedimento (ex: `procedimento_regra('Consulta Clínica', 0.30).`).
    * `limite_coparticipacao/1`: O teto máximo de coparticipação (ex: `limite_coparticipacao(300.00).`).

* **`src/rules.pl` (Motor de Inferência):**
    Contém as **regras de negócio** (o "cérebro") que deduzem um resultado. Ele usa os fatos do `kb.pl` e os fatos dinâmicos do `ui.pl` para calcular:
    * `calcula_mensalidade/1`: Encontra a mensalidade correta para a idade do beneficiário.
    * `calcula_coparticipacao_bruta/1`: Encontra o percentual de cada procedimento, calcula o custo e soma todos eles (`findall/3` + `sum_list/2`).
    * `aplica_limite_coparticipacao/2`: Garante que a soma bruta não ultrapasse o limite de R$ 300,00.
    * `meta/1`: A regra principal que orquestra todos os cálculos acima e retorna o `resultado(Mensalidade, CopartFinal, CustoTotal)`.

* **`src/ui.pl` (Interface do Usuário):**
    Responsável por interagir com o usuário.
    * `coletar_observacoes/0`: Faz as perguntas no console (Nome, Idade, Procedimentos).
    * `assertz/1`: Usa `assertz/1` para salvar as respostas do usuário como fatos dinâmicos (`obs(idade(21)).`, `obs(procedimento('Consulta Clínica', 80)).`).
    * `cleanup/0`: Usa `retractall/1` para limpar a memória antes de uma nova consulta.

* **`src/main.pl` (Orquestrador):**
    Inicia o sistema e controla o fluxo principal.
    * Carrega todos os outros módulos (`.pl`).
    * Exibe o `banner` e o `menu`.
    * Chama `cleanup`, `coletar_observacoes`, `meta/1` e `explicar/1` na ordem correta.

* **`src/explain.pl` (Explicação):**
    Cumpre o requisito de explicar *por que* o resultado foi gerado. Ele reconsulta os fatos (`obs/1`) e recalcula os valores parciais para imprimir a trilha de decisão para o usuário.

## ⚙️ Instalação e Configuração

1.  **Instalar o SWI-Prolog:** Baixe e instale a versão estável mais recente do [SWI-Prolog](https://www.swi-prolog.org/download/stable).
2.  **Clonar o Repositório:**
    ```bash
    git clone https://github.com/1GustavoBorgonha1/Projeto-Prolog.git
    ```

## 🚀 Como Executar

O sistema **deve** ser iniciado a partir da pasta raiz do projeto para que os caminhos dos arquivos (`src/main.pl`) funcionem.

1.  Abra seu Terminal (CMD, PowerShell, Bash, etc.).
2.  Navegue com `cd` até a pasta raiz do seu projeto (a pasta que *contém* o diretório `src/`):
    ```bash
    # Exemplo:
    cd "C:\Users\Gustavo\Desktop\prolog Projeto"
    ```
3.  Inicie o interpretador SWI-Prolog digitando:
    ```bash
    swipl
    ```
4.  Dentro do Prolog (no prompt `?-`), carregue o arquivo principal:
    ```prolog
    ?- ['src/main.pl'].
    ```
    *O Prolog deve responder `true`.*

5.  Inicie o sistema:
    ```prolog
    ?- start.
    ```
    *O menu será exibido.*
