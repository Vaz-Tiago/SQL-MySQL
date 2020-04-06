-- operador +

select 1+3 as retorno;

-- operador *

select 3*2 as retorno;

-- operador -

select 5-2 as retorno;

select 2-5 as retorno;

-- operador /

select 15/3 as retorno;

-- operador %
-- retorna apenas o valor inteiro da divisão.

select 12%5 as retorno;

-- combinando operadores

select ((1+4) * (3*3)) / 5 as retorno;

-- script projetando acrescimo de 10% população

SELECT nome_mun, populacao, 
	populacao * 1.10 as pop_projecao
	FROM senso
	WHERE ano = '2014';
    
-- Fatiando o script acima

SELECT nome_mun, populacao,
	populacao*0.10 as acrescimo,
	populacao + populacao*0.10 projecao_pop
FROM senso
WHERE ano = '2014';

-- todos os resultados e a crição de colunas são apenas para fim de consulta
-- nenhum dados foi inserido no banco de dados

/* 	Exemplo da operação mod. 
	Divide o numero 38 por 5.
    Resultando 7 como parte inteira.
    o Modulo retorna o resto da divisão, que é 3;
*/

SELECT 38/5 AS divisao,
	38%5 AS resto;