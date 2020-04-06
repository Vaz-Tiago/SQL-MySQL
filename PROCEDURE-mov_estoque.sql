-- PROCEDURE NA PRATICA - EXEMPLO MOVIMENTACAO DE ESTOQUE


-- CRIANDO AS TABELAS

USE curso;

CREATE TABLE ztok
(
	cod_mat VARCHAR (20) NOT NULL,
    saldo	DECIMAL (10,2) NOT NULL
);

CREATE TABLE ztok_lote
(
	cod_mat INT,
    lote	VARCHAR (15) NOT NULL,
    saldo	DECIMAL (10,2) NULL,
    FOREIGN KEY (cod_mat) REFERENCES material (cod_mat),
    PRIMARY KEY (cod_mat, lote) -- CHAVE COMPOSTA (mesmo material com varios lotes pode,
								-- porém mesmo material e lote em varias linhas não)
);

CREATE TABLE mov_ztok
(
	transacao 	INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    mov			VARCHAR (1) NOT NULL,
	cod_mat		INT NOT NULL,
    lote		VARCHAR (15) NOT NULL,
    qtd			DECIMAL (10,2) NOT NULL,
    usuario		VARCHAR (30) NOT NULL,
    dt_hr_mov	DATETIME NOT NULL
);

CREATE UNIQUE INDEX ix_ztok1 ON ztok(cod_mat);

ALTER TABLE mov_ztok
	ADD FOREIGN KEY (cod_mat) REFERENCES material (cod_mat);
 


/*
	OBJETIVO. ATUALIZAR OU INSERIR DADOS NA TABELA ZTOK E ZTOK_LOTE E GRAVAR OS DADOS
    NA TABELA MOV_ZTOK GERA A RAZAO DO MOVIMENTO
    AS TABELAS DEVEM MANTER OS SALDOS CONSISTENTES ENTRE ELAS
*/

DELIMITER //

CREATE PROCEDURE proc_atualiza_estoque
					(
						tipo_mov 	VARCHAR(1),
						p_cod_mat 	VARCHAR(50),
                        p_lote 		VARCHAR(15),
                        p_qtd_mov	DECIMAL(10,2)
					)
MAIN: BEGIN
	DECLARE cod_erro 		CHAR(5) DEFAULT '00000'; 	-- p/ tratamento de erros
    DECLARE msg 			TEXT;						-- p/ tratamento de erros
    DECLARE rows 			INT;
    DECLARE result 			TEXT;
    DECLARE saldo_estoque 	DECIMAL(10,2) DEFAULT 0;
    DECLARE saldo_lote 		DECIMAL (10,2) DEFAULT 0;
    DECLARE reg_z 			INT DEFAULT 0;				-- verifica se tem ou nao linhas em estoque para o material
    DECLARE reg_zl 			INT DEFAULT 0;				-- verifica se há em estoque lote. (se houver faz uma ação, se não, outra)
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION -- faz verificação de erro e atribui as variaveis.
    BEGIN
		GET DIAGNOSTICS CONDITION 1
        cod_erro = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
	END;
    
    -- verificar se a operação é permitida: tipo do movimento é E(de entrada) ou S(de saída)
    -- e o valor é > que 0;
    
    IF tipo_mov NOT IN ('E', 'S') OR p_qtd_mov < 1 THEN
		SELECT 'Operação invalida ou valor menor que 1' AS ERRO;
        LEAVE MAIN;
	END IF;
    
    -- Verifica se existe cadastro do material fazendo a contagem de linhas retornadas de acordo com o valor de entrada
    IF (SELECT COUNT(*) FROM material WHERE cod_mat = p_cod_mat) = 0 THEN
		SELECT 'Material não existe' AS ERRO;
        LEAVE MAIN;
	END IF;
    
    -- Atribuindo valor do saldo de estoque do material na variavel saldo_estoque
    -- INTO aplica valor DENTRO da varial
    SELECT saldo INTO saldo_estoque FROM ztok
		WHERE cod_mat = p_cod_mat;
    
    -- Atribuindo saldo de estoque do LOTE do material na variavel saldo lote
    SELECT saldo INTO saldo_lote FROM ztok_lote
		WHERE cod_mat = p_cod_mat 
		AND lote = p_lote;
            
	-- verificando se o estoque ficara negativo
	IF tipo_mov = 'S' AND saldo_estoque < p_qtd_mov THEN
		SELECT 'Estoque Negativo, operação cancelada' AS ERRO;
        LEAVE MAIN;
	END IF;
    
    -- verificando de o estoque ficara negativo
    IF tipo_mov = 'S' AND saldo_lote < p_qtd_mov THEN
		SELECT 'Estoque Negativo, operação cancelada' AS ERRO;
        LEAVE MAIN;
	END IF;
    
    
    -- PASSANDO POR TODAS ESSAS CONDIÇÕES, AI SE INICIA A TRANSAÇÃO
    
    START TRANSACTION;

	/*
    Verificando se o material já possui registro na tabela ztok
	SQL_CALC_FOUND_ROWS - calcula a qtd de linhas encontradas na busca
    */
	SELECT SQL_CALC_FOUND_ROWS cod_mat FROM ztok WHERE cod_mat = p_cod_mat;
    SELECT FOUND_ROWS() INTO reg_z; -- atribui as linhas encontradas à variavel
    
	-- verificando se o material tem registro na tabela estoque lote
    SELECT SQL_CALC_FOUND_ROWS cod_mat FROM ztok_lote WHERE cod_mat = p_cod_mat AND lote = p_lote;
    SELECT FOUND_ROWS() INTO reg_zl;
    
	/*
    verificando o tipo do movimento para definir a ação;
	caso de saida, realiza um update, pois obviamente, o material já existe
    */
    IF (tipo_mov = 'S') THEN
		UPDATE ztok SET saldo = saldo - p_qtd_mov
		WHERE cod_mat = p_cod_mat;
    
		UPDATE ztok_lote SET saldo = saldo - p_qtd_mov
        WHERE cod_mat = p_cod_mat
        AND lote = p_lote;
    
		-- tabela de movimento sempre recebe um insert
        INSERT INTO mov_ztok
			(mov, cod_mat, lote, qtd, usuario, dt_hr_mov)
			VALUES
            (tipo_mov, p_cod_mat, p_lote, p_qtd_mov, user(), now());
            
	-- caso MOV ENTRADA e mat EXISTE em ESTOQUE e LOTE
	ELSEIF (tipo_mov = 'E' AND reg_z = 1 AND reg_zl = 1) THEN
		UPDATE ztok SET saldo = saldo + p_qtd_mov
		WHERE cod_mat = p_cod_mat;
		
		UPDATE ztok_lote SET saldo = saldo + p_qtd_mov
		WHERE cod_mat = p_cod_mat
		AND lote = p_lote;
    
		INSERT INTO mov_ztok
			(mov, cod_mat, lote, qtd, usuario, dt_hr_mov)
			VALUES
            (tipo_mov, p_cod_mat, p_lote, p_qtd_mov, user(), now());
            
	-- caso MOV ENTRADA e mat EXISTE em ESTOQUE mas NAO EXISTE em LOTE
	ELSEIF (tipo_mov = 'E' AND reg_z = 1 AND reg_zl = 0) THEN
		UPDATE ztok SET saldo = saldo + p_qtd_mov
        WHERE cod_mat = p_cod_mat;
        
        INSERT INTO ztok_lote
			(cod_mat, lote, saldo)
            VALUES
            (p_cod_mat, p_lote, p_qtd_mov);
		
        INSERT INTO mov_ztok
			(mov, cod_mat, lote, qtd, usuario, dt_hr_mov)
			VALUES
            (tipo_mov, p_cod_mat, p_lote, p_qtd_mov, user(), now());
            
	-- caso o MOV ENTRADA e mat NAO EXISTE tanto em ESTOQUE quanto em LOTE
    ELSEIF (tipo_mov = 'E' AND reg_z = 0 AND reg_zl = 0) THEN
		INSERT INTO ztok
			(cod_mat, saldo)
            VALUES
            (p_cod_mat, p_qtd_mov);
            
		INSERT INTO ztok_lote
			(cod_mat, lote, saldo)
            VALUES
            (p_cod_mat, p_lote, p_qtd_mov);
            
		INSERT INTO mov_ztok
			(mov, cod_mat, lote, qtd, usuario, dt_hr_mov)
			VALUES
            (tipo_mov, p_cod_mat, p_lote, p_qtd_mov, user(), now());
	
    END IF;
    
    -- tratando os erros e exibindo para o usuario
    
    IF cod_erro = '00000' THEN
		GET DIAGNOSTICS rows = ROW_COUNT;
        SET result = CONCAT('Atualização com Sucesso = ', rows);
	ELSE
		SET result = CONCAT('Erro na atualização, error = ', cod_erro,', message = ', msg);
	END IF;
    
    -- retorna o resultado final
    SELECT result;
    
    -- caso de tudo certo, faça as alterações, caso contrario, desfaça tudo
    IF cod_erro = '00000' THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
END//
DELIMITER ;

-- DROP PROCEDURE proc_atualiza_estoque

/* 
	PARAMETROS DE PROCEDURES
PARAM 1 = MOVIMENTO - S de Saida e E de Entrada
PARAM 2 = COD_MATERIAL
PARAM 3 = LOTE
PARAM 4 = QUANTIDADE
*/

CALL proc_atualiza_estoque ('E',2,'ABC',9);

SELECT * FROM ztok;
SELECT * FROM ztok_lote;
SELECT * FROM mov_ztok;
-- consulta de materiais
SELECT * FROM material;
     