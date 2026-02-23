# 📈 Análise Estratégica de Vendas e Precificação com SQL

## 📌 Visão Geral

Este projeto tem como objetivo realizar uma análise estratégica de dados comerciais utilizando SQL, com foco em desempenho de vendas, posicionamento de preços e análise competitiva.

A partir de uma base de dados relacional composta por informações de produtos, vendas e preços de concorrentes, foram desenvolvidas consultas estruturadas para transformar dados brutos em indicadores estratégicos de negócio.

O projeto demonstra como a linguagem SQL pode ser aplicada para consolidar métricas, integrar tabelas transacionais e dimensionais, identificar inconsistências e gerar insights relevantes para tomada de decisão orientada por dados.

## 🎯 Objetivos Estratégicos

- Avaliar o desempenho geral de vendas (volume, receita e ticket médio)

- Analisar performance por categoria de produto

- Identificar produtos com preço acima da média do portfólio

- Comparar preços internos com a média de concorrentes

- Classificar produtos por faixa de preço

- Detectar produtos sem vendas

- Identificar vendas associadas a produtos não cadastrados

- Avaliar impacto financeiro de inconsistências cadastrais


## Database Structure

O projeto foi desenvolvido a partir de três tabelas principais:

🔹 produtos

Contém informações cadastrais dos produtos:

- id_produto
- nome_produto
- categoria
- marca
- preco_atual
- data_criacao

🔹 vendas

Base transacional contendo:

- id_venda
- data_venda
- id_cliente
- id_produto
- canal_venda
- quantidade
- preco_unitario

🔹 preco_competidores

Tabela de benchmark competitivo:

- id_produto
- nome_concorrente
- preco_concorrente
- data_coleta

A modelagem relacional permite integrar dimensões (produtos) e fatos (vendas), viabilizando análises consolidadas.
