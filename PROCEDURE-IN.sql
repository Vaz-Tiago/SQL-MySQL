-- PROCEDURE parametro IN
-- sintaxe para deletar: DROP PROCEDURE nome_procedure
-- Faz um SELECT dentro da tabela senso e retorna apenas o valor informado no parametro

DELIMITER //
CREATE PROCEDURE proc_cidade_uf(IN p_uf VARCHAR(2))
	BEGIN
		SELECT DISTINCT nome_mun, populacao, cod_uf
			FROM senso
		WHERE cod_uf = p_uf;
	END //
DELIMITER ;

-- invocando a procedure
CALL proc_cidade_uf(15);

-- invocando a procedure com uma variavel:
SET @var_uf='13';

CALL proc_cidade_uf(@var_uf);


USE curso

-- Criando tabelas para exemplo

CREATE TABLE material
(
	cod_mat INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome	VARCHAR(50) NOT NULL,
    custo 	DECIMAL(10,2) NOT NULL
);

INSERT INTO material (nome, custo) 
	VALUES 
		('XBOX','1500'), ('SMART TV 42','2200'), ('NOTEBOOK','3900'),('SMARTPHONE','2350');

CREATE TABLE estoque
(
	cod_mat	INT NOT NULL,
	qtd		INT NOT NULL,
    FOREIGN KEY (cod_mat) REFERENCES material (cod_mat)
);

INSERT INTO estoque (cod_mat, qtd) VALUES (1,12);
INSERT INTO estoque (cod_mat, qtd) VALUES (2,29);
INSERT INTO estoque (cod_mat, qtd) VALUES (3,33);
INSERT INTO estoque (cod_mat, qtd) VALUES (4,54);


-- Procedure atualiza preço de custo em porcentagem
DELIMITER //
CREATE PROCEDURE proc_ajuste_custo (IN p_cod_mat INT, taxa DECIMAL(10,2))
	BEGIN
		UPDATE material SET custo = custo + custo * taxa / 100
        WHERE cod_mat = p_cod_mat;
	END //
DELIMITER ;

SELECT * FROM material;

CALL proc_ajuste_custo(2,7);


