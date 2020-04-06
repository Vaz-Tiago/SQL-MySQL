
-- OPERADOR WHERE

SELECT * FROM senso
	WHERE nome_mun = 'Jundiai';

-- OPERADOR AND

SELECT * FROM senso
	WHERE cod_uf = '35'
	AND populacao > 50000
    AND ano = '2014';
    
-- OPERADOR BETWEEN

SELECT * FROM senso
	WHERE cod_uf = '35'
    AND populacao BETWEEN 5000 AND 6000
    AND ano = '2014'
    ORDER BY populacao DESC;
    
-- OPERADOR IN

SELECT * FROM senso
	WHERE cod_uf IN ('35','12')
    AND ano = '2014';
    
-- OPERADOR NOT IN

SELECT * FROM senso
	WHERE cod_uf NOT IN ('35','12')
    AND ano = '2014';
    
-- OPERADOR LIKE LOCALIZANDO PALAVRAS QUE CONTENHAM 'OR' EM QUALQUER LUGAR

SELECT * FROM senso
	WHERE nome_mun LIKE ('%or%')
    AND ano = '2014';
    
-- OPERADOR LIKE QUE CONTENHA A LETRA 'R' NA SEGUNDA POSIÇÃO

SELECT * FROM senso
	WHERE nome_mun LIKE ('_r%')
    AND ano = '2014';
    
-- OPERADOR LIKE QUE INICIA EM "a" E POSSUAM PELO MENOS 3 CARACTERES DE COMPRIMENTO

SELECT * FROM senso
	WHERE nome_mun LIKE 'a_%_%'
    AND ano = '2014';
    

    
-- OPERADOR LIKE QUE INICIA COM "a" E TERMINE COM "o"

SELECT * FROM senso
	WHERE nome_mun LIKE 'a%o'
    AND ano = '2014';
    
-- OPERADOR LIKE TUDO QUE COMEÇA COM "t"

SELECT * FROM senso
	WHERE nome_mun LIKE 't%'
    AND ano = '2014';
    
-- OPERAOR LIKE CORING _

SELECT * FROM senso
	WHERE nome_mun LIKE '_ra%'
    AND ano = '2014';
    
-- OPERADOR NOT  - APENAS MUNICIPIOS QUE NAO COMEÇAM COM "A" E A POPULAÇÃO SEJA MAIOR QUE 40000 PESSOAS

SELECT ano, cod_uf, estado, nome_mun, populacao FROM senso
	WHERE nome_mun NOT LIKE ('A%')
	AND cod_uf = '35'
	AND NOT populacao < 40000
	AND ano = '2014';
    
-- OPERADOR OR (OU)

SELECT * FROM senso
	WHERE nome_mun LIKE ('A%')
    AND (cod_uf = '35' OR cod_uf = '15');
    
-- OPERADOR IS NOT NULL (RETORNA TUDO QUE NÃO É NULO)
-- OU SEJA, TUDO QUE TENHA ALGUM VALOR INSERIDO NO CAMPO REGIÃO

SELECT * FROM senso
	WHERE regiao IS NOT NULL;
    
-- OPERADOR IS NULL

SELECT * FROM senso
	WHERE regiao IS NULL;
    
 -- PREPARANDO CENÁRIO PARA IS NULL
 -- (POIS ALGUNS CAMPOS NÃO ESTÃO NULOS, MAS SIM VAZIOS,
 -- DEIXAR DE PREENCHER UM CAMPO NA TABELA NÃO O TORNA NULO, MAS SIM VAZIO)
 
SELECT * FROM senso
	WHERE regiao = '';
    
UPDATE senso SET regiao = NULL
	WHERE regiao = '';
    
-- REVERTER O E DEIXAR VAZIO E NÃO NULL

UPDATE senso SET regiao = ''
	WHERE regiao IS NULL;
    
-- OPERADOR HAVING
-- CONTADOR DE NUMERO DE CIDADES

SELECT cod_uf, estado, count(*)qtd
    FROM senso
    WHERE ano = '2014'
    GROUP BY cod_uf, estado HAVING count(cod_mun) > 350;
    
-- OPERADOR HAVING NUMERO POPULACIONAL

SELECT cod_uf, estado, count(cod_mun)qtd, sum(populacao)
	FROM senso
    WHERE ano = '2014'
    GROUP BY cod_uf, estado HAVING sum(populacao) > 5000000;