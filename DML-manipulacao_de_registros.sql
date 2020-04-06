-- DDL -- CRIAÇÃO DA TABELA

USE curso;

CREATE TABLE funcionarios
(
ID INT NOT NULL AUTO_INCREMENT,
nome VARCHAR (50) NOT NULL,
salario DECIMAL (10, 2),
setor VARCHAR (30),
PRIMARY KEY (ID)
);

-- DML SELECT
-- EXEMPLO SELECT

SELECT * FROM funcionarios;

-- Quando utilizado AS, é nomeado um ALIAS, ou seja, a coluna setor vai aparecer como dpto

SELECT ID, nome, setor AS depto FROM funcionarios;

-- DML INSERT

INSERT INTO funcionarios (nome, salario, setor) VALUES
	('Joao', '1000', ''), ('Jose','2000',''), ('Alexandre','3000','');

-- OU (NESSE CASO NAO ADICIONOU O SETOR, NO CASO PREENCHE COMO NULL
-- NO EXEMPLO DE CIMA PREENCHEU COMO CAMPO VAZIO

INSERT INTO funcionarios (nome, salario) VALUES ('Pedro','1000'),('Cleiton','1080');

-- DML UPDATE

UPDATE funcionarios SET salario = 1500
	WHERE id=1;
    
-- OU PODEMOS INCLUIR CALCULOS NO UPDATE
-- NESSE CASO 50% SOBRE O SALARIO ATUAL

UPDATE funcionarios SET salario = salario*1.5
	WHERE ID = '2';
    
    
-- UPDATE COM MAIS DE UM CAMPO

UPDATE funcionarios SET salario = salario*1.5, setor = 'TI'
WHERE id <> '1';

-- DML DELETE

DELETE FROM funcionarios
WHERE ID = '1';

