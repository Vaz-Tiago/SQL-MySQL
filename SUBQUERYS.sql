

-- SUBQUERYS - SUBCONSULTAS

/*	
	SUBSELECT
Descobrir todos atores que fizeram o filme com seguintes parametros:
film_id = 1 com title= ACADEMY DINOSAUR
conhecer a estrutura das tabelas alvo

*/

USE Sakila;

SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film;

SELECT * FROM actor
	WHERE actor_id IN 
		(SELECT actor_id FROM film_actor WHERE film_id = '1');


-- DESCOBRIR QUAIS FILMES A ATRIZ PENELOPE GUINES FEZ
-- PARAMETRO ACTOR_ID = 1

-- Neste exemplo, dentro da tabela filme não temos os atores que o fizeram,
-- então ele vai exibir o filme_id que está dentro da tabela film_actor onde o id do ator é 1
-- Para que então seja exibido todos os dados do filme do qual foi retornado o que aquele ator fez
SELECT * FROM film
	WHERE film_id IN 
		(SELECT film_id FROM film_actor	WHERE actor_id = '1');


-- FILTRANDO A MESMA CONSULTA PORÉM COM MAIS UM PARAMETRO QUE É O RATING
SELECT * FROM film
	WHERE film_id IN 
		(SELECT film_id FROM film_actor	WHERE actor_id = '1') 
	AND rating='PG';
        
SELECT * FROM film
	WHERE film_id NOT IN 
		(SELECT film_id FROM film_actor	WHERE actor_id = '1') 
	AND rating='PG';
    
    

-- Descobrir quantas cidades tem cada país
SELECT * FROM country;
SELECT * FROM city;

SELECT a.country_id, a.country, 
	(SELECT count(*) FROM city b WHERE a.country_id = b.country_id) AS qtda
FROM country a;
    
-- Entendendo esta query:
-- 1° linha -	São os campos que serão exibidos. No caso o 'a' é o alias da tabela
-- 				Esse alias é definido na 3° linha, e corresponde a tabela country.
-- 2° linha -	Subquery que faz a contagem do numero de cidades em cada país,
-- 				SELECT a contagem de '*' todos FROM city b, no caso o 'b' é o alias
-- 				da tabela city, WHERE (onde) o country_id da tabela 'a' country seja
-- 				igual ao country_id da tabela 'b' city e esse resultado vai ser exibido
-- 				AS (como) a coluna qtda.
-- 3° linha -	Aqui é definida a Tabela que será feita a busca (original, não a subquery)
-- 				e também definido o alias desta tabela



USE world;



-- UTILIZANDO OUTRO BANCO DE DADOS PARA FAZER TESTES.

-- CALCULAR O TOTAL DA POPULACAO DO PAÍS PELA TABELA CIDADE
-- COM SUBSELECT TRAZER O NOME DO PAÍS E FILTRAR POR LINGUAS

SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM countrylanguage;


-- SOLUÇÃO 1
SELECT a.countrycode, sum(a.population) AS total_pop,
	(SELECT name FROM country b WHERE a.countrycode = b.code) AS pais
FROM city a
WHERE a.countrycode IN (SELECT c.countrycode FROM countrylanguage c WHERE language = 'Spanish')
GROUP BY a.countrycode;


-- SOLUÇÃO 2 - MAIS LIMPA, SEMPRE USAR SOLUÇÕES MAIS LIMPAS, SUBSELECT PARA CASOS EXTREMOS
-- AS RELAÇÕES SÃO IMPORTANTE PARA ESSE TIPO DE JUNÇÃO DE DADOS E EXIBIÇÃO
SELECT a.countrycode, SUM(a.population) AS total_pop, b.name
FROM city a
INNER JOIN country b
ON a.countrycode = b.code
INNER JOIN countrylanguage c
ON a.countrycode = c.countrycode
	WHERE language = 'Portuguese'
GROUP BY a.countrycode, b.name;