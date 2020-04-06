/* 
	TRIGGERS
		São associadas a uma tabela e invocadas atreaves de comandos DML
        Utilizadas em:
        - Verificação de integridade de daddos;
        - Validacao de dados;
        - Rastreamento e registro de LOG;
        - Arquivamento de registros excluidos;
        
        Sintaxe:
        
        CREATE TRIGGER nome timing operacao
			ON name_tbl
				FOR EACH ROW
			DECLARACOES
            
		
        TIMING = BEFORE / AFTER
        OPERACOES = INSERT / UPDATE / DELETE
        
		Definir dados de antes (OLD) e depois (NEW)
			INSERT: Operador NEW.nome_coluna, nos permite verificar o valor enviado para ser inserido em uma coluna de uma tbl
					OLD.nome_coluna não está disponivel, pois como é insert não há reg antigo
			DELETE: Operador OLD.nome_coluna nos permite verificar o valor excluido ou a ser excluido
					NEW.nome_coluna não está disponivel
			UPDATE: Tanto OLD.nome_coluna quanto NEW.nome_coluna estãp disponiveis, antes (BEFORE) ou depois (AFTER) da atualização de uma linha
*/


-- criando tabela pra trigger
CREATE TABLE auditoria_salario
(
	id 				INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_func 		INT,
    salario_antes 	DECIMAL (10,2) NOT NULL,
    salario_depois	DECIMAL (10,2) NOT NULL,
    usuario			VARCHAR (30) NOT NULL,
    data			DATETIME NOT NULL
);

-- analisando dados
SELECT * FROM funcionarios

-- criando trigger com evento apos update na tabela funcionarios

CREATE TRIGGER tg_audit_sal AFTER UPDATE 	-- APOS ACONTECER UM UPDATE
ON funcionarios								-- NA TABELA FUNCIONARIOS
FOR EACH ROW								-- PARA CADA COLUNA
	INSERT INTO auditoria_salario
		(id_func, salario_antes, salario_depois, usuario, data)
        VALUES
        (NEW.id, OLD.salario, NEW.salario, USER(), NOW());
        
-- TESTANDO A TRIGGER 

UPDATE funcionarios SET salario = salario*1.15 WHERE id = '6';

SELECT * FROM auditoria_salario;

SHOW TRIGGERS;


CREATE TABLE cad_material
(
	cod_mat		INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_mat	VARCHAR (50) UNIQUE,
    saldo		INT NOT NULL DEFAULT 0
);

SELECT * FROM cad_material

INSERT INTO cad_material (nome_mat, saldo) VALUES ('GAME', 10);
INSERT INTO cad_material (nome_mat, saldo) VALUES ('SMARTV 42', 5);
INSERT INTO cad_material (nome_mat, saldo) VALUES ('SMARTPHONE', 15);
INSERT INTO cad_material (nome_mat, saldo) VALUES ('NOTEBOOK', 32);
INSERT INTO cad_material (nome_mat, saldo) VALUES ('TABLET', 50);

-- CRIANDO TABLEA ITESN NOTA FISCAL

CREATE TABLE nf_itens
(
	venda	INT,
    cod_mat	INT,
    qtd		INT
);


-- TRIGGER DE ACAO - DEPOIS DE INSERT NA TABELA NF_ITENS
DELIMITER //
CREATE TRIGGER tg_nf_itens_INSERT AFTER INSERT
	ON nf_itens
	FOR EACH ROW
BEGIN
	UPDATE cad_material SET saldo = saldo - NEW.qtd
		WHERE cod_mat = NEW.cod_mat;
END //

-- TRIGGER DE ACAO - DEPOIS DE DELETE NA TABELA NF_ITENS
CREATE TRIGGER tg_nf_itens_DELETE AFTER DELETE
	ON nf_itens
    FOR EACH ROW
BEGIN
	UPDATE cad_material SET saldo = saldo + OLD.qtd
	WHERE cod_mat = OLD.cod_mat;
END //

-- TRIGGER DE ACAO - DEPOIS DE UPDATE NA TBL NF_ITENS]
CREATE TRIGGER tg_nf_itens_UPDATE AFTER UPDATE
	ON nf_itens
    FOR EACH ROW
BEGIN
	UPDATE cad_material SET saldo = saldo + (OLD.qtd - NEW.qtd)
    WHERE cod_mat = OLD.cod_mat;
END //

DELIMITER ;

SHOW TRIGGERS;

-- REALIZANDO OS TESTES
SELECT * FROM cad_material;

-- INSERT

INSERT INTO nf_itens VALUES (1, 1, 3);
INSERT INTO nf_itens VALUES (1, 2, 1);
INSERT INTO nf_itens VALUES (1, 3, 5);

-- UPDATE
UPDATE nf_itens SET qtd = 4
	WHERE venda = '1' 
    AND cod_mat = '1';
    
-- DELETE
DELETE FROM nf_itens
	WHERE venda = '1'
    AND cod_mat = '1';
    


