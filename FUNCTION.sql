-- FUNÇÕES


-- Criando uma função simples para que seja retornado o valor da multiplicação a * b
USE curso;

-- DELIMITER // FUNÇÃO //
-- Toda função deve estar dentro do DELIMITER, pois dessa maneira
-- os ';' que estiverem sendo escritos não finalizam a sentença
-- depois de terminar, tem que voltar o delimiter ao padrão que é ;
DELIMITER //
CREATE FUNCTION fn_teste(a DECIMAL(10,2),b INT) -- define os parametros que serão recebidos
RETURNS INT -- define o tipo de dado que será retornado
RETURN a*b; -- o que será retornado
//

-- invocando função
SELECT fn_teste(2, 3);


CREATE TABLE produtos
	(
		id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        nome_prod VARCHAR(50) NOT NULL,
        preco_unit DECIMAL (10,2)
	);
    
INSERT INTO produtos (nome_prod, preco_unit)
	VALUES
		('XBOX','1500,99'),
		('SMART TV 49','3199,99'),
		('NOTEBOOK','4200,99');

SELECT * FROM produtos;


-- Criar Função para calcular total do preço x qtd
DELIMITER //
CREATE FUNCTION fn_total(preco DECIMAL(10,2), qtd INT)
RETURNS DECIMAL(10,2)
RETURN CAST(qtd * preco AS DECIMAL(10,2));
//


-- invocando função
SET @qtd:=3;
SET @id	:=1;

SELECT nome_prod, @qtd quantidade, preco_unit, fn_total(preco_unit,@qtd) Total_Compras
FROM produtos
WHERE id = @id;


-- Criando função para trazer a primeira letra maiuscula e o restante minuscula
DELIMITER //
CREATE FUNCTION fn_initcap (nome VARCHAR(50))
RETURNS VARCHAR(50)
RETURN CONCAT( -- abre o CONCAT com as funcões UPPER e LOWER
			UPPER(SUBSTRING(nome,1,1)), -- aplicando o upper na primeira letra
            LOWER(SUBSTRING(nome,2,50)) -- aplicando o lower no restante
            ); -- fechando o CONCAT
//

-- invocando a função
SELECT nome_prod, fn_initcap(nome_prod) FROM produtos;


-- Criando função de Boas Vindas
DELIMITER //
CREATE FUNCTION fn_boas_vindas (usuario VARCHAR(50))
RETURNS VARCHAR(50)
RETURN CONCAT('Olá ', usuario,' Seja Bem Vindo');
//

-- invocando função
SELECT fn_boas_vindas(user());



USE sakila;

DELIMITER //
CREATE FUNCTION fn_filmes_ator (id_ator INT)
RETURNS INT
BEGIN -- Utiliza o Begin pq o RETURN tem uma complexidade que exige várias linhas e pontos de fechamento
	DECLARE qtd INT; 			-- Declarando uma variavel qtd
	SELECT COUNT(*) INTO qtd	-- Colocando o retorno de COUNT dentro da variavel qtd
	FROM film_actor				-- Tabela que será feito o SELECT
	WHERE actor_id = id_ator;	-- Condição do filtro, que é passado via paramentro da FUNÇÃO
	RETURN qtd;					-- Retorna a variavel que recebeu toda a informação
END;
//

-- invocando a FUNÇÃO
SELECT fn_filmes_ator(1);


-- CRIANDO TABELA PARA TESTE
USE curso;

CREATE TABLE avaliacao
	(
		aluno VARCHAR(10),
		nota1 INT,
		nota2 INT,
		nota3 INT,
		nota4 INT
	);

INSERT INTO avaliacao VALUES ('Paul', 5, 2, 3, 4);
INSERT INTO avaliacao VALUES ('Mary', 10, 9, 10, 10);

-- Criando a função para calcular a média

DELIMITER //
CREATE FUNCTION fn_media (nome VARCHAR(10))
	RETURNS FLOAT
	BEGIN
		DECLARE N1,N2,N3,N4 INT; -- DECLARANDO VÁRIAS VARIAVEIS DO MESMO TIPO EM UMA LINHA
        DECLARE MED FLOAT;
        SELECT nota1, nota2, nota3, nota4 INTO N1,N2,N3,N4	-- ATRIBUINDO VALORES AS VARIAVEIS
			FROM avaliacao WHERE aluno = nome;				-- DE ONDE VEM OS DADOS
        SET MED = (N1+N2+N3+N4)/4;							-- SETA O VALOR DA VARIAVEL MED
        RETURN MED;
	END;
//

-- MOSTRANDO A MÉDIA DOS ALUNOS
-- Exemplo de function super aplicavel em qualquer sistema, pois o usuario só
-- digita o nome do aluno e retorna o valor inteiro
SELECT fn_media('Mary');
SELECT fn_media('Paul');


-- Criando função que simula aumento de salário;
DELIMITER //
CREATE FUNCTION fn_simula_aumento (salario DECIMAL(10,2), pct DECIMAL(10,2))
	RETURNS DECIMAL(10,2)
	BEGIN
		RETURN salario + salario * pct /100;
	END;
//
DELIMITER ; -- Forçado o delimiter padrão

-- invocando função
SELECT fn_simula_aumento(2000, 50);


-- QUANTIDADE DE CIDADES POR ESTADO
DELIMITER //
CREATE FUNCTION fn_cidades (p_uf VARCHAR(2), p_ano INT)
RETURNS INT
BEGIN
	DECLARE qtd INT;
    SELECT COUNT(*) INTO qtd FROM senso
		WHERE cod_uf = p_uf AND ano = p_ano;
	RETURN qtd;
END;
//
DELIMITER ;

-- invocando a função performance horrivel
SELECT DISTINCT estado, fn_cidades(cod_uf, 2014) FROM senso
WHERE ano = '2014';

-- criando index para melhorar a resposta
CREATE INDEX ix_senso1 ON senso(cod_uf, ano);
