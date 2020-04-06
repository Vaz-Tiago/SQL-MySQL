-- IF
-- Retorna um de dois valores, dependendo da expressão booliana retornar TRUE ou FALSE

SET @A := 45;
SET @B := 40;
SELECT IF(@A>@B, 'TRUE - MAIOR','FALSE - MENOR') RESULTADO;


-- IFNULL
-- CASO O VALOR VERIFICADO SEJA NULO, ELE É SUBSTITUIDO PELO VALOR DESEJADO.
-- SE NÃO FOR NULL, NAO FAZ NADA.

SELECT IFNULL(1,0) RETORNO;
SELECT IFNULL(NULL,0) RETORNO;

-- vazio retorna vazio
SELECT IFNULL('',0) retorno

-- aplicando o exemplo em base de dados
-- para que não seja exibido nulo em relatórios
USE world;
SELECT name, indepyear, IFNULL(indepyear,'COLONIA')
FROM country;


-- NULLIF
-- Caso as informações sejam iguais, ele retorna nulo
-- mesma aplicação do IFNULL, depois do parentese dois parametros, o primeiro a ser pesquisado
-- o segundo a ser definido.
SELECT NULLIF(100,100) retorno;
SELECT NULLIF(100,10) retorno;
SELECT NULLIF('a',10) retorno;
SELECT NULLIF('a','b') retorno;
SELECT NULLIF('abc','abc') retorno;


-- CASE
-- Usando para saber o dia
-- sysdate() é uma função que pega a data do sistema
-- Case = CASO
-- WHEN = QUANDO
-- THEN = ENTÃO
SET @data:= sysdate()-1;
SELECT @data,
	CASE
		WHEN @data = sysdate()		THEN 'HOJE'
        WHEN @data = sysdate()+1	THEN 'AMANHA'
        WHEN @data = sysdate()-1	THEN 'ONTEM'
	END dia;
    
-- aplicando exemplo em base de dados
USE world;
SELECT	a.name, 
		a.population,
        CASE
			WHEN a.population < 1000000		THEN 'POP MENOR QUE 1 MILHAO'
			WHEN a.population >= 1000000	AND 
				 a.population < 50000000	THEN 'POP MAIOR QUE 1 MILHAO E MENOR QUE 50 MILHOES'
			WHEN a.population >= 50000000	AND
				 a.population < 100000000	THEN 'POP MAIOR QUE 50 MILHOES E MENOR QUE 100 MILHOES'
			WHEN a.population > 100000000	THEN 'POP MAIOR QUE 100 MILHOES'
		END demografia
FROM country a
ORDER BY a.continent, a.population DESC;

-- OUTRO EXEMPLO DE CASE
SELECT	COUNT(*) qtd_paises,
		CASE
			WHEN a.population < 1000000		THEN 'POP MENOR QUE 1 MILHAO'
			WHEN a.population >= 1000000	AND 
				 a.population < 50000000	THEN 'POP MAIOR QUE 1 MILHAO E MENOR QUE 50 MILHOES'
			WHEN a.population >= 50000000	AND
				 a.population < 100000000	THEN 'POP MAIOR QUE 50 MILHOES E MENOR QUE 100 MILHOES'
			WHEN a.population > 100000000	THEN 'POP MAIOR QUE 100 MILHOES'
		END demografia
FROM country a
GROUP BY
		CASE
			WHEN a.population < 1000000		THEN 'POP MENOR QUE 1 MILHAO'
			WHEN a.population >= 1000000	AND 
				 a.population < 50000000	THEN 'POP MAIOR QUE 1 MILHAO E MENOR QUE 50 MILHOES'
			WHEN a.population >= 50000000	AND
				 a.population < 100000000	THEN 'POP MAIOR QUE 50 MILHOES E MENOR QUE 100 MILHOES'
			WHEN a.population > 100000000	THEN 'POP MAIOR QUE 100 MILHOES'
		END;


-- Outro exemplo
USE sakila;

SELECT	
	COUNT(*),
	CASE
		WHEN a.length < 60 THEN 'Curta Metragem'
		WHEN a.length < 90 THEN 'Curta Metragem'
		WHEN a.length >= 90 THEN 'Longa Metragem'
	END Metragem
FROM film a
GROUP BY 
	CASE
		WHEN a.length < 60 THEN 'Curta Metragem'
		WHEN a.length < 90 THEN 'Curta Metragem'
		WHEN a.length > 90 THEN 'Longa Metragem'
	END;
    
    
