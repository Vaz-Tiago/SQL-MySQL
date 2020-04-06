-- funções full-text
-- Ferramenta de pesquisa


-- Criando tabela para exemplo
USE curso;

CREATE TABLE artigo
	(
		id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
		titulo VARCHAR(200),
		corpo TEXT,
		FULLTEXT (titulo, corpo)
	)
ENGINE = InnoDB;


-- inserindo dados
INSERT INTO artigo (titulo, corpo) VALUES
	('MySQL Tutorial','SGBD MYSQL do zero ...'),
    ('Como utilizar bem o MYSQL','Depois que analisamos muito ...'),
    ('Otimizando MySQL','Neste tutorial vamos aprender ...'),
    ('1001 dicas no MySQL','1. Nunca inicie o MySQL como root. 2. ...'),
	('MySQL vs. SQL Server','Nesta comparação vamos ...'),
    ('Segurança no MySQL','Quando configurado corretamente, o MySQL ...');
    

-- retornando
-- select * from artigo;

SET @pesquisa := 'Tutorial';
SELECT * FROM artigo
	WHERE MATCH (titulo,corpo)
		AGAINST (@pesquisa IN NATURAL LANGUAGE MODE);
      
      
SET @pesquisa := 'Tutorial';
SELECT COUNT(*) FROM artigo
	WHERE MATCH (titulo,corpo)
		AGAINST (@pesquisa IN NATURAL LANGUAGE MODE);
        
-- count condiciional
SET @pesquisa := 'Tutorial';
SELECT
	COUNT(IF(MATCH (titulo,corpo)
		AGAINST (@pesquisa IN NATURAL LANGUAGE MODE), 1, NULL))
        AS COUNT
FROM artigo;

-- mostrando a relevancia da busca em cada campo
-- na linha que ele achou as duas palavras da busca ele retorna um score maior da linha que tem
-- apenas a palavra tutorial
SET @pesquisa := 'Tutorial Otimizando';
SELECT id, MATCH(titulo,corpo)
	AGAINST (@pesquisa IN NATURAL LANGUAGE MODE) AS score
FROM artigo;


SET @pesquisa := 'MySQL';
SELECT id, titulo, corpo, MATCH(titulo,corpo)
	AGAINST (@pesquisa IN NATURAL LANGUAGE MODE) AS score
FROM artigo;

SET @pesquisa := 'Quando configurado corretamente, o MySQL';
SELECT id, titulo, corpo, MATCH (titulo,corpo) AGAINST
	(@pesquisa IN NATURAL LANGUAGE MODE) AS score
FROM artigo WHERE MATCH (titulo,corpo) AGAINST
	(@pesquisa IN NATURAL LANGUAGE MODE);