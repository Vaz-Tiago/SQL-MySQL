/* 
TRATANDO ERRO EM PROCEDURES

	DECLARE erro SMALLINT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro = 1;

	depois apenas um IF pode para checar o valor da variavel e redirecionar o usuario
TABELA PARA TESTE

Nesse caso o erro nçao ocorreu, o registro foi adicionado com sucesso porem cortado ao numero limite de caracteres
magina que eu preciso olhar para o teclado para difirar.
claro que ocorre afubs errs mas pq o meu dedo eh gordo
*/

CREATE TABLE cad_cli 
(
	cod_cli 	INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    nome_cli 	VARCHAR (20) NOT NULL,
    PRIMARY KEY (cod_cli)
);

-- CRIANDO EXEMPLO DE PROCEDURE PARA TRATAR O ERRO

DELIMITER //

CREATE PROCEDURE
	proc_trata_exc (IN var_nome_cli VARCHAR(100), OUT resposta VARCHAR(50))
	
    SALVAR: BEGIN
		-- define 0 como valor padrao da variavel
        DECLARE excecao SMALLINT DEFAULT 0;
        -- define 1 como valor da variavel em caso de erro
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET excecao = 1;
        -- inicia transacao
        START TRANSACTION;
		-- inserindo valores
		INSERT INTO cad_cli (cod_cli, nome_cli) VALUES (NULL, var_nome_cli);
		-- checando erro com IF
		IF excecao = 1 THEN
			SET resposta = 'Erro ao gravar dados';
			ROLLBACK;
			LEAVE SALVAR;
		ELSE
			SET resposta = 'Salvo com sucesso';
			COMMIT;
		END IF;
        
	END //
    
DELIMITER ;

-- TESTE OK
CALL proc_trata_exc('Tiago',@resposta);
SELECT @resposta;

SELECT * FROM cad_cli;

-- TESTE ERRO
CALL proc_trata_exc('Maria da Silva Rodrigues Alvarenga de Souza Costa Santos', @resposta);
SELECT @resposta;



