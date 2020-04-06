-- DATA E HORA - MANIPULAÇÃO
-- Verificando a lingua padrão da instalação e alterando para pt_BR
-- Por default o MYSQL utiliza o en_US


-- Verificando a linguagem instalada
SELECT @@lc_time_names;

-- Setando uma nova linguagem
SET lc_time_names = 'pt_BR'; 


-- Verificando TIME_ZONE
SELECT @@global.time_zone; -- Retorna SYSTEM, pois está retornando o time_zone do Sistema

-- Exemplo de fuso-horário:
-- SET @@global.time_zone = '+3:00';

-- Exemplo de time_zone de lugar específico:
-- SET time_zone = 'America/Sao_Paulo';

SELECT @@time_zone;


-- FUNÇÃO DATA E HORA EM PARTES
SELECT 	MONTH(NOW()) MES,
		YEAR(NOW()) ANO,
        DAY(NOW()) DIA,
        HOUR(NOW()) HORA,
        MINUTE(NOW()) MINUTO,
        SECOND(NOW()) SEGUNDO;
        

-- Fracionando a informação de data baseado na informação de um campo
USE sakila;
SELECT	title,
		last_update Ultima_Atualizacao,
        YEAR(last_update) Ano,
        MONTH(last_update) Mes,
        DAY(last_update) Dia,
        HOUR(last_update) Hora,
        MINUTE(last_update) Minuto,
        SECOND(last_update) Segundo
FROM film;


-- PEGANDO AS DIFERENÇAS. OU SEJA, CALCULANDO O TEMPO
-- DATEDIFF - RETORNA A DIFENRENÇA ENTRE AS DATAS SELECIONADAS

-- DIFERENÇA EM DIAS
SELECT	title,
		last_update,
        DATEDIFF(last_update,NOW()) AS Dif
FROM film;

SELECT	title,
		last_update,
        DATEDIFF(NOW(), last_update) AS Dif
FROM film;


-- TIMEDIFF
-- DIFERENÇA EM HORAS
SELECT TIMEDIFF('2019-04-22 07:00:00', now()) DIFERENCA;

USE sakila;
-- SETANDO TODOS OS TIPOS DE DIFERENÇA COM BASER EM UMA ULTIMA ATUALIZACAO DO REGISTRO NA TABELA
-- A INFORMACAO LAST_UPDATE É UMA DATA QUE NOW() QUE FOI GRAVADA EM UM CAMPO DO BD
SELECT title, last_update,
	TIMESTAMPDIFF(YEAR, last_update, NOW()) ano_dif,
	TIMESTAMPDIFF(MONTH, last_update, NOW()) mes_dif,
	TIMESTAMPDIFF(DAY, last_update, NOW()) dia_dif,
	TIMESTAMPDIFF(HOUR, last_update, NOW()) hora_dif,
	TIMESTAMPDIFF(MINUTE, last_update, NOW()) minuto_dif,
	TIMESTAMPDIFF(WEEK, last_update, NOW()) semana_dif
FROM film
LIMIT 5;

