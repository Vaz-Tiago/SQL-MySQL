-- VIEWS

-- Sintaxe de Criação
USE sakila;

CREATE VIEW v_ator_film
AS
SELECT a.first_name,c.title,c.length AS Duracao
	FROM actor a
		INNER JOIN film_actor b
			ON a.actor_id = b.actor_id
        INNER JOIN film c
			ON b.film_id = c.film_id;
            
            
-- Consultado VIEW
SELECT * FROM v_ator_film;


-- Pode fazer as restrições no resultado da view
SELECT * FROM v_ator_film
	WHERE title='GOODFELLAS SALUTE';
    
    
SELECT first_name, title FROM v_ator_film
WHERE title = 'GOODFELLAS SALUTE';

-- toda a complexidade dos innerjoins já estão na view,
-- fica bem mais simples de fazer as buscas em um sistema quando o BD já faz toda a relação


-- CRIAR VIEW DE OUTRO VIEW
CREATE VIEW v_ator_film_horas
AS
SELECT a.first_name, SUM(a.duracao) minutos,
	SUM(a.duracao)/60 horas
FROM v_ator_film a
GROUP BY a.first_name
ORDER BY 2 DESC;

SELECT * FROM v_ator_film_horas;


-- view de view de novo
CREATE VIEW v_ator_film_concat
AS
SELECT a.first_name,
	GROUP_CONCAT(a.title SEPARATOR ', ') AS Filmes
FROM v_ator_film a
GROUP BY a.first_name;

-- select na view
SELECT * FROM v_ator_film_concat;


-- VIEW com dados Particionados
-- Criação da view com dados de varias tabelas utilizando UNION ALL

-- CRIANDO TABELAS
USE curso;

CREATE TABLE fornc1
	(
		id_fornc INT NOT NULL PRIMARY KEY,
        fornec VARCHAR(50) NOT NULL,
        CONSTRAINT chk_f1 CHECK (id_fornec BETWEEN 1 AND 150)
	);

CREATE TABLE fornc2
	(
		id_fornc INT NOT NULL PRIMARY KEY,
        fornec VARCHAR(50) NOT NULL,
        CONSTRAINT chk_f2 CHECK (id_fornec BETWEEN 151 AND 300)
	);

CREATE TABLE fornc3
	(
		id_fornc INT NOT NULL PRIMARY KEY,
        fornec VARCHAR(50) NOT NULL,
        CONSTRAINT chk_f3 CHECK (id_fornec BETWEEN 301 AND 450)
	);

CREATE TABLE fornc4
	(
		id_fornc INT NOT NULL PRIMARY KEY,
        fornec VARCHAR(50) NOT NULL,
        CONSTRAINT chk_f4 CHECK (id_fornec BETWEEN 451 AND 600)
	);
    

-- inserindo valores
INSERT fornc1 VALUES ('150','CaliforniaCorp');
INSERT fornc1 VALUES ('5','BraziliaLtd');

INSERT fornc2 VALUES ('231','FarEast');
INSERT fornc2 VALUES ('280','NZ');

INSERT fornc3 VALUES ('321','EuroGroup');
INSERT fornc3 VALUES ('442','UKArchip');

INSERT fornc4 VALUES ('475','India');
INSERT fornc4 VALUES ('521','Afrique');


-- CRIANDO VIEW
CREATE VIEW v_fornec_geral
	AS
		SELECT id_fornc, fornec FROM fornc1
        UNION ALL
        SELECT id_fornc, fornec FROM fornc2
        UNION ALL
        SELECT id_fornc, fornec FROM fornc3
        UNION ALL
        SELECT id_fornc, fornec FROM fornc4;

SELECT * FROM v_fornec_geral;


-- DELETE VIEW
DROP VIEW V_fornec_geral;


-- ALTERANDO VIEW
ALTER VIEW v_fornec_geral
	AS
		SELECT 'f1' as origem,id_fornc, fornec FROM fornc1
        UNION ALL
		SELECT 'f2' as origem,id_fornc, fornec FROM fornc2
        UNION ALL
		SELECT 'f3' as origem,id_fornc, fornec FROM fornc3
        UNION ALL
		SELECT 'f4' as origem,id_fornc, fornec FROM fornc4;


-- inserindo mais reguistros para ver a atualizacao autoatica da view
INSERT fornc4 VALUES ('476','Norway');
INSERT fornc4 VALUES ('522','Netherlands');


