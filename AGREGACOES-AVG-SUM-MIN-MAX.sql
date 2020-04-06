USE curso;

-- AVG RETORNA A MÉDIA DOS VALORES EM UM GRUPO. VALORES NULOS SÃO IGNORADOS
SELECT AVG (populacao) AS media FROM senso WHERE ano = '2014';


-- AVG POR ESTADO
-- ORDER BY 2 SIGNIFICA QUE ESTÁ ORDENADO PELO SEGUNDO CAMPO QUE FOI CITADO, NO CASO POPULACAO
SELECT estado, AVG (populacao) FROM senso
WHERE ano = '2014'
GROUP BY estado
ORDER BY 2 DESC;


-- AVG MEDIA POR ESTADO COM SIGLA DO ESTADO
SELECT a.cod_uf, b.sigla_uf, AVG (a.populacao) FROM senso a
INNER JOIN uf b
	ON a.cod_uf = b.cod_uf
WHERE a.ano = '2014'
GROUP BY a.cod_uf, b.sigla_uf
ORDER BY 3 DESC;


-- AVG POR REGIAO
-- AVG MEDIA POR REGIAO
SELECT a.regiao, AVG(a.populacao)
	FROM senso a
	WHERE a.ano = '2014'
    GROUP BY a.regiao;
    
    
-- MIN retorna o valor minimo na expressão, pode ser seguido pela clausula OVER
SELECT MIN(populacao) FROM senso
WHERE ano = '2014';


-- MIN POR ESTADO
SELECT a.estado, MIN(a.populacao) as populacao
	FROM senso a
    WHERE a.ano='2014'
GROUP BY estado
ORDER BY populacao ASC;


-- MIN POR REGIAO
SELECT a.regiao, MIN(populacao)
	FROM senso a
	WHERE a.ano = '2014'
GROUP BY a.regiao


-- MAX - RETORNA O VALOR MAXIMO NA EXPRESSAO (MAIS ALTO)
SELECT MAX(populacao) FROM senso
	WHERE ano = '2014';
    
    
-- MAX POR ESTADO
SELECT cod_uf, estado, MAX(populacao) FROM senso
	WHERE ano = '2014'
GROUP BY estado
ORDER BY 1;    


-- MAX POR SIGLA DE ESTADO USANDO INNER JOIN
SELECT b.sigla_uf, MAX(a.populacao) AS Maximo
	FROM senso a
		INNER JOIN uf b
			ON a.cod_uf = b.cod_uf
WHERE a.ano = '2014'
GROUP BY b.sigla_uf
ORDER BY 2 DESC;


-- SUM POR ESTADO
SELECT cod_uf, SUM(populacao) FROM senso
WHERE ano = '2014'
GROUP BY cod_uf
ORDER BY 2 DESC;


-- SUM POR REGIAO
SELECT b.sigla_uf, SUM(a.populacao) AS SOMA
	FROM senso a
		INNER JOIN uf b
			ON a.cod_uf = b.cod_uf
WHERE a.ano = '2014'
GROUP BY b.sigla_uf
ORDER BY 2 DESC;


-- COUNT - RETORNA O NUMERO DE ITENS DE UM GRUPO
SELECT COUNT(*) FROM senso WHERE estado = 'Sao Paulo' AND ano = '2014';


-- RETORNAR A QUANTIDADE DE CIDADES QUE FORAM PESQUISADAS POR ANO
SELECT a.ano, COUNT(*) qtd_cidades FROM senso a
GROUP BY a.ano;


-- RETORNAR QUANTIDADE DE ESTADOS UTILIZANDO DISTINCT
-- legal pois conta apenas os que sao diferentes
SELECT COUNT(DISTINCT cod_uf) FROM senso;


-- COUNT por estado
SELECT estado, COUNT(*) FROM senso
WHERE ano = '2014'
GROUP BY estado
ORDER BY 2 DESC;


-- COUNT POR REGIAO
SELECT regiao, COUNT(*) FROM senso
WHERE ano = '2014'
GROUP BY regiao
ORDER BY 2 DESC;


-- USANDO VARIAS FUNÇOES DE AGREGAÇÃO
SELECT	AVG(populacao)	AS Media,
		MIN(populacao)	AS Minimo,
        MAX(populacao)	AS Maximo,
        SUM(populacao)	AS Total,
        COUNT(*) 		AS Quantidade
	FROM senso
WHERE ano = '2014';


-- POR ESTADO
SELECT estado,
	AVG(populacao)	AS Media,
    MIN(populacao)	AS Minima,
    MAX(populacao)	AS Maxima,
    SUM(populacao)	AS Total,
    COUNT(*)		AS Cidades
    FROM senso
WHERE ano = '2014'
GROUP BY estado
ORDER BY 1;


-- Selecionar a cidade com maior populacao de cada estado
-- Nesse caso foi utilizado uma subselect para manter a integridade dos dados.
-- O subselect foi feito na mesma tabela, com um alias difente e separou os mais altos,
-- Depois tudo foi colocado em ordem pelo primeiro select
SELECT a.estado, a.nome_mun, a.populacao
	FROM
		(
			SELECT b.estado, MAX(b.populacao) AS populacao FROM senso b
            WHERE b.ano = '2014'
            GROUP BY b.estado
		) b
	JOIN senso a
		ON a.estado = b.estado
        AND a.populacao = b.populacao
WHERE a.ano = '2014'
ORDER BY a.populacao DESC;

-- Selecionar a cidade com maior populacao de cada estado
SELECT a.estado, a.nome_mun, a.populacao
	FROM
		(
			SELECT b.estado, MIN(b.populacao) AS populacao FROM senso b
            WHERE b.ano = '2014'
            GROUP BY b.estado
		) b
	JOIN senso a
		ON a.estado = b.estado
        AND a.populacao = b.populacao
WHERE a.ano = '2014'
ORDER BY a.populacao DESC;

-- STDDEV restorna o desvio padrão estatistico de todos os valores da expressão
SELECT STDDEV(populacao) FROM senso
WHERE ano = '2014';


-- STDDEV_POP retorna o desvio padrao estatistico para a populacao de todos os valores
-- na expressao especificada
SELECT STDDEV_POP(populacao) from senso;


-- COMPARANDO CRESCIMENTO POP DAS CIDADES REF 2010 A 2014
SELECT	a.nome_mun,
		a.populacao AS senso_2010,
        b.populacao AS senso_2014,
        (100/a.populacao) * (b.populacao)-100 AS Percentural
FROM senso a
INNER JOIN senso b
	ON a.cod_mun = b.cod_mun
WHERE a.ano = '2010' AND b.ano = '2014'
ORDER BY 4 DESC;


-- Comparando crescimento por estado 2010 a 2014
SELECT	a.estado,
		SUM(a.populacao) AS Senso_2010,
        SUM(b.populacao) AS senso_2014,
        (100/SUM(a.populacao)) * (SUM(b.populacao))-100 AS Percentual
FROM senso a
	INNER JOIN senso b
		ON a.cod_mun = b.cod_mun
WHERE a.ano = '2010' AND b.ano = '2014'
GROUP BY a.estado
ORDER BY a.estado;


-- VAR_POP Retorna a variancia estatistica de todos os valores da expressão específica
SELECT VAR_POP(populacao) FROM senso
WHERE ano = '2014';


-- VAR_POP com GROUP BY
SELECT estado, VAR_POP(populacao) FROM senso
GROUP BY estado;


-- VAR_SAMP Retorna a variancia estatistica de todos os valores da expressão específica
SELECT VAR_SAMP(populacao) FROM senso
WHERE ano = '2014';


-- VAR_SAMP com GROUP BY
SELECT estado, VAR_SAMP(populacao) FROM senso
GROUP BY estado;


-- FUNCAO CONCAT - Junta varios campos em uma unica coluna
-- No exemple abaixo vamos separar os continentes, e na outra coluca a populacao de cada um de seus
-- paises separados por um caracter de nossa escolha
USE world;
SELECT 	Continent, 
		GROUP_CONCAT(DISTINCT Population ORDER BY Population DESC SEPARATOR ';') AS Grupo
	FROM country
GROUP BY Continent;


-- Para ficar mais claro utilizaremos o comando com nomes:
-- Agregando informações de maneira pratica
SELECT 	Continent, 
		GROUP_CONCAT(DISTINCT Region ORDER BY Region DESC SEPARATOR ';') AS Grupo
	FROM country
GROUP BY Continent;


-- GROUP BY WITH ROLLUP
-- ROLLUP na ultima linha exibe o tatal de registro pesquisados.
USE curso;
SELECT a.estado, COUNT(*) FROM senso a
WHERE ano = '2014'
GROUP BY a.estado DESC WITH ROLLUP;