-- FUNÇÕES DATA E HORA

-- CURDATE()
-- EXIBE A DATA DO SISTEMA
SELECT CURDATE();

-- CURRENT_TIME()
-- EXIBE A HORA DO SISTEMA
SELECT CURRENT_TIME();

-- NOW()
-- EXIBE A DATA E HORA DO SISTEMA
SELECT NOW();


-- CRIAR TABELA DE EXEMPLO
CREATE TABLE audit_log
	(
		id INT NOT NULL AUTO_INCREMENT,
        acao VARCHAR(50),
        data DATE,
        hora time,
        PRIMARY KEY(id)
	);

INSERT INTO audit_log (acao,data,hora) VALUES ('Cadastro', CURDATE(), CURRENT_TIME());
INSERT INTO audit_log (acao,data,hora) VALUES ('Atualização', CURDATE(), CURRENT_TIME());

SELECT * FROM audit_log;

UPDATE audit_log SET hora = CURRENT_TIME()
WHERE id = '1';