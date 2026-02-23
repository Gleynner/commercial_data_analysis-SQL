
--**************************  Análise Estratégica de Vendas e Precificação com SQL  **************************
/*
Este projeto tem como objetivo realizar uma análise exploratória e estratégica de uma base de dados relacional 
composta por informações de produtos, vendas e preços de concorrentes, utilizando a linguagem SQL como principal 
ferramenta de extração e transformação de dados. A atividade consiste em aplicar consultas estruturadas para 
consolidar métricas de desempenho comercial, avaliar posicionamento de preços, identificar padrões de vendas, 
segmentar produtos por faixa de valor e verificar inconsistências entre bases transacionais e cadastrais.

Por meio da integração entre tabelas, uso de funções de agregação, subconsultas, CTEs e diferentes tipos de JOINs, 
busca-se transformar dados brutos em indicadores relevantes para o negócio, tais como receita total, ticket médio, 
mix de produtos vendidos, desempenho por categoria e análise comparativa com concorrentes. A proposta central é 
demonstrar como técnicas de consulta e modelagem relacional em SQL podem gerar insights estratégicos, apoiando 
decisões orientadas por dados no contexto comercial.
*/





-- ****************************************  QUESTÃO 1  ****************************************
-- Explore o catálogo de produtos, identificando os itens disponíveis e eliminando possíveis 
-- duplicidades, permitindo uma visão consolidada do portfólio de produtos.

SELECT DISTINCT
  nome_produto AS produtos_distintos
FROM produtos;

/*
O trecho de código apresentado realiza uma consulta na tabela produtos com o objetivo de identificar
e retornar apenas os nomes de produtos únicos existentes na base de dados. A instrução SELECT DISTINCT
garante a remoção de valores duplicados, retornando exclusivamente registros distintos da coluna 
nome_produto. Além disso, é aplicado um alias (AS produtos_distintos) para renomear a coluna no 
resultado da consulta, tornando a saída mais descritiva e adequada.

Nesta saída, temos um total de 133 produtos diferentes.
*/





-- ****************************************  QUESTÃO 2  ****************************************
-- Identificação dos produtos de maior valor, destacando os 10 itens mais caros para apoiar 
-- decisões de posicionamento e pricing.

SELECT
  nome_produto,
  marca,
  preco_atual
FROM
  produtos
ORDER BY
  preco_atual DESC
LIMIT 10

/*
O trecho de código realiza uma consulta na tabela produtos com o objetivo de selecionar as colunas
nome_produto, marca e preco_atual, organizando os resultados com base no preço em ordem decrescente
(ORDER BY preco_atual DESC). Essa ordenação posiciona os produtos mais caros no topo da listagem. 
Em seguida, a cláusula LIMIT 10 restringe a saída aos dez primeiros registros, ou seja, aos dez 
produtos com maior preço atual na base de dados. Analiticamente essa consulta é útil para identificar 
os itens de maior valor no portfólio e apoiar análises de posicionamento de preço.
*/




-- ****************************************  QUESTÃO 3  ****************************************
-- Identificar os produtos do catálogo cujo preço ultrapassa R$ 500,00, com o objetivo de mapear 
-- itens de maior valor e apoiar análises comerciais.

SELECT
  nome_produto,
  preco_atual
FROM
  produtos
WHERE
  preco_atual > 500
ORDER BY
  preco_atual DESC

/*
O trecho de código realiza uma consulta na tabela produtos com o objetivo de selecionar os campos
nome_produto e preco_atual, aplicando um filtro condicional por meio da cláusula WHERE, que 
restringe os resultados apenas aos produtos com preço superior a 500. Em seguida, a cláusula 
ORDER BY preco_atual DESC organiza os registros em ordem decrescente de preço, destacando inicialmente
os itens de maior valor dentro do recorte estabelecido. Do ponto de vista analítico, essa consulta 
permite identificar produtos posicionados em uma faixa de preço elevada, sendo útil para análises de 
segmentação e suporte a decisões estratégicas relacionadas à precificação.

Como resposta, temos um total de 15 produtos com valor acima de R$ 500,00.
*/





-- ****************************************  QUESTÃO 4  ****************************************
-- Calcular métricas agregadas de vendas, incluindo o total de transações, a receita total e o 
-- ticket médio por transação.

SELECT
  COUNT(*) AS total_de_vendas,
  ROUND(SUM(preco_unitario * quantidade)::NUMERIC,2) AS receita_total,
  ROUND(AVG(preco_unitario * quantidade)::NUMERIC,2) AS ticket_medio
FROM 
  vendas

/*
O trecho de código realiza uma agregação de métricas na tabela vendas com o objetivo de mensurar 
o desempenho comercial da base de dados. A função COUNT(*) calcula o total de registros de vendas, 
representando o volume total de transações realizadas. Em seguida, a expressão 
SUM(preco_unitario * quantidade) calcula a receita bruta total, multiplicando o preço unitário 
pela quantidade vendida em cada transação e somando os resultados. Já a função 
AVG(preco_unitario * quantidade) calcula o ticket médio, isto é, o valor médio por venda. O 
operador ::NUMERIC realiza a conversão explícita para tipo numérico, enquanto a função ROUND(..., 2) 
padroniza os valores monetários com duas casas decimais. Em termos analíticos, essa consulta consolida
indicadores fundamentais de performance — volume, faturamento e ticket médio — servindo como base para 
avaliação estratégica do desempenho de vendas.
*/





-- ****************************************  QUESTÃO 5  ****************************************
-- Avalie os extremos financeiros, identificando maiores e menores vendas e preços unitários.

SELECT
  MAX(preco_unitario * quantidade) AS maior_venda,
  MIN(preco_unitario * quantidade) AS menor_venda,
  MAX(preco_unitario) AS maior_preco_unitario,
  MIN(preco_unitario) AS menor_preco_unitario
FROM 
  vendas

/*
O trecho de código realiza uma análise descritiva dos valores registrados na tabela vendas, com 
foco na identificação de extremos (valores máximos e mínimos). A expressão MAX(preco_unitario * quantidade) 
calcula o maior valor total já registrado em uma venda, enquanto MIN(preco_unitario * quantidade) 
identifica a menor venda em termos de valor financeiro. Além disso, as funções MAX(preco_unitario) e 
MIN(preco_unitario) determinam, respectivamente, o maior e o menor preço unitário praticado na base 
de dados. Do ponto de vista analítico, essa consulta é relevante para compreender a amplitude dos valores 
de transações e identificar possíveis outliers. 

Podemos observar que houve divergência de preços quando comparamos os produtos mais caros da tabela de 
produtos e da tabela de vendas, com valor praticado na venda diferente do valor do preço registrado na 
base de dados de produtos.
*/





-- ****************************************  QUESTÃO 6  ****************************************
-- Analise a diversidade comercial, medindo a quantidade de produtos distintos vendidos e o número 
-- de clientes únicos atendidos.

SELECT
  COUNT(DISTINCT id_produto) AS produtos_diferentes_vendidos,
  COUNT(DISTINCT id_cliente) AS clientes_unicos
FROM 
  vendas

/*
O trecho de código realiza uma análise de diversidade e alcance comercial a partir da tabela vendas. 
A função COUNT(DISTINCT id_produto) calcula a quantidade de produtos distintos que efetivamente 
registraram vendas, permitindo avaliar a amplitude do mix comercializado. Já a função COUNT(DISTINCT id_cliente) 
contabiliza o número de clientes únicos que realizaram compras, mensurando o alcance da base ativa 
de consumidores. Em termos analíticos, essa consulta fornece indicadores estratégicos importantes para 
avaliação de penetração de mercado, diversidade de vendas e nível de engajamento da carteira de clientes.

Em suma, foram vendidos um total de 205 produtos diferentes para um total de 50 clientes únicos.
*/





-- ****************************************  QUESTÃO 7  ****************************************
-- Identifique o nome do produto, sua respectiva categoria e o valor de venda associado, consolidando 
-- essas informações para análise comercial.

SELECT 
  P.nome_produto,
  P.categoria, 
  (V.preco_unitario * V.quantidade) AS valor_da_venda
FROM
  vendas AS V
  INNER JOIN produtos AS P ON (V.id_produto = P.id_produto)


/*
O trecho de código realiza uma integração entre as tabelas vendas (apelidada como V) e produtos 
(apelidada como P) por meio de um INNER JOIN, utilizando como chave de relacionamento o campo 
id_produto. Essa junção garante que apenas registros com correspondência em ambas as tabelas sejam 
retornados, associando cada venda ao respectivo produto cadastrado. A consulta seleciona o nome 
do produto e sua categoria a partir da tabela produtos, além de calcular dinamicamente o valor 
total de cada venda por meio da multiplicação entre preco_unitario e quantidade. Do ponto de vista 
analítico, essa operação é fundamental para enriquecer dados transacionais com atributos dimensionais, 
permitindo análises mais detalhadas por produto e categoria.
*/





-- ****************************************  QUESTÃO 8  ****************************************
-- Classificar os produtos em faixas de preço predefinidas, com base no valor de venda, para 
-- segmentação e análise comparativa.

SELECT 
  nome_produto,
  preco_atual,
  CASE
    WHEN preco_atual < 100 THEN 'Economico'
    WHEN preco_atual >= 100 and preco_atual < 300 THEN 'Intermediario'
    WHEN preco_atual >= 300 and preco_atual < 600 THEN 'Superior'
    ELSE 'Premium'
  END AS tipo_de_produto
FROM 
  produtos


/*
O trecho de código realiza uma classificação dos produtos com base em faixas de preço, utilizando 
a estrutura condicional CASE na tabela produtos. Inicialmente, são selecionadas as colunas 
nome_produto e preco_atual. Em seguida, o comando CASE cria uma nova variável categórica denominada 
tipo_de_produto, que segmenta os itens conforme intervalos previamente definidos: produtos com preço
inferior a 100 são classificados como “Econômico”; entre 100 e 299 como “Intermediário”; entre 300 
e 599 como “Superior”; e valores a partir de 600 são classificados como “Premium”.

Do ponto de vista analítico, essa abordagem permite transformar uma variável numérica contínua (preço) 
em uma variável categórica estratégica, facilitando análises de segmentação, comparação de desempenho 
entre categorias de preço e construção de indicadores voltados à estratégia comercial e precificação.
*/





-- ****************************************  QUESTÃO 9  ****************************************
-- Analisar o desempenho por categoria de produto, mensurando volume de vendas (quantidade), 
-- receita total e ticket médio.

SELECT  
  p.categoria,
  COUNT(*) AS quantidade_total,
  ROUND(SUM(v.preco_unitario * v.quantidade)::NUMERIC,2) AS receita_total,
  ROUND(AVG(v.preco_unitario * v.quantidade)::NUMERIC,2) AS media_vendas
FROM
  vendas AS v
  INNER JOIN produtos AS p ON (V.id_produto = P.id_produto)
GROUP BY
  p.categoria
ORDER BY 
  receita_total DESC
LIMIT 10

/*
O trecho de código realiza uma análise agregada de desempenho por categoria de produto, a partir 
da integração entre as tabelas vendas (v) e produtos (p) por meio de um INNER JOIN, utilizando 
id_produto como chave de relacionamento. Essa junção permite associar cada transação à sua respectiva
categoria. Em seguida, a consulta agrupa os dados com GROUP BY p.categoria, possibilitando o cálculo
de métricas consolidadas por categoria. São calculados: a quantidade total de vendas (COUNT(*)), a 
receita total (SUM(preco_unitario * quantidade)) e a média de valor por venda (AVG(preco_unitario * quantidade)), 
sendo os valores monetários convertidos para tipo numérico e arredondados para duas casas decimais. 
Por fim, os resultados são ordenados pela receita_total em ordem decrescente e limitados às dez categorias 
com maior faturamento (LIMIT 10).

Do ponto de vista analítico, essa consulta permite identificar quais categorias apresentam melhor 
desempenho financeiro, apoiando análises estratégicas de mix de produtos e tomada de decisão orientada 
por dados.
*/





-- ****************************************  QUESTÃO 10  ****************************************
-- Aplicar um critério de corte na receita total por categoria, selecionando aquelas com faturamento 
-- acima de R$ 50.000.

SELECT  
  p.categoria,
  ROUND(SUM(v.preco_unitario * v.quantidade)::NUMERIC,2) AS receita_total
FROM
  vendas AS v
  INNER JOIN produtos AS p ON (V.id_produto = P.id_produto)
GROUP BY
  p.categoria
HAVING
  SUM(v.preco_unitario * v.quantidade) > 50000
ORDER BY 
  receita_total DESC
LIMIT 10

/*
O trecho de código realiza uma análise agregada de faturamento por categoria de produto, a partir da 
junção entre as tabelas vendas (v) e produtos (p) por meio de um INNER JOIN, utilizando id_produto como 
chave de relacionamento. Após a integração das bases, os dados são agrupados por p.categoria, permitindo 
o cálculo da receita total de cada categoria por meio da expressão SUM(v.preco_unitario * v.quantidade), 
que representa o faturamento bruto. O resultado é convertido para o tipo numérico e arredondado para duas 
casas decimais, garantindo padronização monetária.

A cláusula HAVING é utilizada para aplicar um filtro após a agregação, selecionando apenas as categorias 
cuja receita total seja superior a 50.000. Em seguida, os resultados são ordenados de forma decrescente 
com base na receita_total, e a cláusula LIMIT 10 restringe a saída às dez categorias mais relevantes dentro 
do critério estabelecido.

Do ponto de vista analítico, essa consulta permite identificar categorias com alto desempenho financeiro, 
funcionando como um mecanismo de segmentação por faturamento e apoiando decisões estratégicas relacionadas 
a priorização comercial, alocação de recursos e análise de rentabilidade.
*/





-- ****************************************  QUESTÃO 11  ****************************************
-- Identificar os produtos cujo preço unitário esteja acima da média geral de preços da base de dados.

SELECT 
  nome_produto,
  categoria,
  preco_atual
FROM 
  produtos
WHERE
  preco_atual > (SELECT AVG(preco_atual) FROM produtos)
ORDER BY
  preco_atual DESC


/*
O trecho de código realiza uma análise comparativa de preços dentro da própria tabela produtos. Inicialmente, 
são selecionadas as colunas nome_produto, categoria e preco_atual. A cláusula WHERE aplica um filtro baseado 
em uma subconsulta (SELECT AVG(preco_atual) FROM produtos), que calcula a média geral de preços da base. Dessa 
forma, a consulta retorna apenas os produtos cujo preço atual esteja acima da média global. Por fim, os resultados 
são organizados em ordem decrescente de preço (ORDER BY preco_atual DESC), destacando os itens com maior valor 
dentro desse grupo.

Do ponto de vista analítico, essa consulta permite identificar produtos posicionados acima do preço médio do 
portfólio, sendo útil para análises de segmentação e avaliação de estratégia de precificação.
*/





-- ****************************************  QUESTÃO 12  ****************************************
-- Realizar uma análise comparativa de preços, avaliando quais produtos apresentam valor acima da média 
-- dos concorrentes, com o objetivo de apoiar decisões de posicionamento e estratégia comercial.

WITH preco_medio_concorrentes AS(
SELECT  -- media de preço dos concorrentes
  id_produto,
  AVG(preco_concorrente) AS media_concorrentes
FROM
  preco_competidores
GROUP BY  
  id_produto
)
SELECT    -- meus de preços 
  p.id_produto,
  p.preco_atual,
  ROUND(pc.media_concorrentes::numeric,2) AS media_concorrentes,
  (ROUND((p.preco_atual - pc.media_concorrentes)::NUMERIC,2)) AS diferenca_do_preco_para_concorrente
FROM 
  produtos p
  INNER JOIN preco_medio_concorrentes pc ON (p.id_produto = pc.id_produto)
ORDER BY
  diferenca_do_preco_para_concorrente DESC

/*
O trecho de código utiliza uma Common Table Expression (CTE), definida pela cláusula WITH, para 
estruturar a análise comparativa de preços em duas etapas. Na primeira etapa, a CTE preco_medio_concorrentes 
calcula a média de preço praticada pelos concorrentes para cada id_produto, a partir da tabela 
preco_competidores, utilizando a função AVG(preco_concorrente) com agrupamento por produto (GROUP BY id_produto). 
Essa etapa consolida o benchmark de mercado por item.

Na etapa principal da consulta, os dados da tabela produtos (p) são integrados à CTE por meio de 
um INNER JOIN, relacionando os registros pelo campo id_produto. São então selecionados o identificador 
do produto, o preço atual praticado pela empresa e a média de preços dos concorrentes (arredondada 
para duas casas decimais). Além disso, é calculada a diferença entre o preço atual e a média dos 
concorrentes, também arredondada, criando um indicador direto de posicionamento competitivo. Por fim, 
os resultados são ordenados de forma decrescente com base nessa diferença, destacando inicialmente os 
produtos com maior desvio positivo em relação ao mercado.

Do ponto de vista analítico, essa consulta permite avaliar o posicionamento de preço frente à concorrência, 
identificar produtos com possível sobrepreço ou subpreço e apoiar decisões estratégicas de precificação 
orientadas por dados de mercado.
*/





-- ****************************************  QUESTÃO 13  ****************************************
-- Identificar registros de vendas associados a produtos não cadastrados na base de produtos.

SELECT
  p.id_produto AS id_tab_produtos,
  v.id_produto AS id_tab_vendas,
  p.nome_produto,
  SUM(v.quantidade * v.preco_unitario) AS receita
FROM 
  produtos p
  RIGHT JOIN vendas v ON (p.id_produto = v.id_produto)
WHERE 
  p.id_produto IS NULL
GROUP BY  
  id_tab_produtos, id_tab_vendas
ORDER BY
  receita DESC

/*
O trecho de código realiza uma análise de consistência entre as tabelas produtos (p) e vendas (v) com 
o objetivo de identificar transações associadas a produtos que não possuem cadastro correspondente. Para 
isso, é utilizado um RIGHT JOIN, garantindo que todos os registros da tabela vendas sejam preservados 
no resultado, mesmo quando não houver correspondência na tabela produtos.

A consulta também calcula a receita gerada por esses registros por meio da expressão 
SUM(v.quantidade * v.preco_unitario), agregando o valor financeiro por identificador de produto presente 
na tabela de vendas. O GROUP BY organiza os resultados por produto, e o ORDER BY receita DESC classifica 
os casos em ordem decrescente de impacto financeiro.

Do ponto de vista analítico, essa consulta é fundamental para auditoria e qualidade de dados, pois permite 
identificar inconsistências entre bases dimensionais e transacionais, mensurar o impacto financeiro dessas 
divergências e apoiar processos de governança e correção de dados.
*/



-- ****************************************  QUESTÃO 14  ****************************************
-- Identificar os produtos cadastrados que não possuem registros de venda na base transacional.

SELECT
  p.id_produto,
  p.nome_produto,
  p.categoria,
  p.preco_atual,
  COUNT(v.id_venda) AS total_de_vendas
FROM 
  produtos p
  LEFT JOIN vendas v ON (p.id_produto = v.id_produto)
GROUP BY  
  p.id_produto, p.nome_produto, p.categoria, p.preco_atual
HAVING
  COUNT(v.id_venda) = 0
ORDER BY
  p.preco_atual DESC


/*
O trecho de código realiza uma análise de desempenho de portfólio com o objetivo de identificar 
produtos cadastrados que não registraram nenhuma venda. Para isso, utiliza-se um LEFT JOIN entre 
as tabelas produtos (p) e vendas (v), garantindo que todos os produtos sejam mantidos no resultado, 
mesmo que não possuam correspondência na tabela de vendas.

Em seguida, a cláusula GROUP BY agrupa os registros por produto, permitindo a aplicação da função 
COUNT(v.id_venda) para contabilizar o número de vendas associadas a cada item. A cláusula 
HAVING COUNT(v.id_venda) = 0 atua como filtro pós-agregação, selecionando exclusivamente os produtos 
que não possuem registros de venda. Por fim, os resultados são ordenados em ordem decrescente de 
preço (ORDER BY p.preco_atual DESC), priorizando os itens de maior valor dentro desse grupo.

Sob a perspectiva analítica, essa consulta é relevante para avaliar giro de estoque, eficiência 
do mix de produtos e possíveis problemas de posicionamento ou demanda, além de apoiar decisões 
estratégicas relacionadas à descontinuação, reprecificação ou ações promocionais.
*/





-- ****************************************  CONCLUSÃO  ****************************************
/*
Este projeto demonstrou a aplicação prática da linguagem SQL como ferramenta central para exploração, 
tratamento e análise de dados estruturados, evidenciando sua relevância tanto do ponto de vista técnico 
quanto estratégico. A utilização de comandos como SELECT, WHERE, GROUP BY, HAVING, ORDER BY, funções de 
agregação (SUM, AVG, COUNT, MAX, MIN), subconsultas e Common Table Expressions (CTEs) permitiu transformar 
dados brutos em informações consolidadas e orientadas à tomada de decisão. Além disso, a aplicação de 
diferentes tipos de JOINs possibilitou a integração entre tabelas dimensionais e transacionais, reforçando 
conceitos fundamentais de modelagem relacional e integridade de dados.

Sob a perspectiva de negócio, as análises desenvolvidas permitiram avaliar desempenho de vendas, receita, 
ticket médio, posicionamento de preços, comparação com concorrentes, identificação de produtos sem giro 
e detecção de inconsistências cadastrais. Esses insights são diretamente aplicáveis à gestão comercial, 
estratégia de precificação, otimização do mix de produtos e governança de dados.

Dessa forma, o projeto evidencia como o uso da linguagem SQL, aliado à compreensão de métricas e indicadores 
de negócio, é essencial para extrair valor estratégico dos dados, apoiar decisões baseadas em evidências e 
fortalecer a atuação da Ciência de Dados no contexto corporativo.
*/

