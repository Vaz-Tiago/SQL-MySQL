-- PROCEDURE IF E REPEAT

-- MAIN (main é como um checkpoint utilizado para loop em repeat, caso a condição não seja
-- satisfeita volta para o main e roda o codigo de novo)

USE curso;

DELIMITER //
CREATE PROCEDURE
	proc_acumula (valor_teto INT)
    MAIN:
    BEGIN
		DECLARE contador INT DEFAULT 0;
        DECLARE soma 	 INT DEFAULT 0;
		-- testando valor menor que 1
		IF valor_teto < 1 THEN
			SELECT 'O valor deve ser maior que zero' AS ERRO;
		LEAVE MAIN;
        END IF;
		REPEAT
			SET contador = contador + 1;
            SET soma = soma + contador;
			UNTIL contador = valor_teto
		END REPEAT;
        SELECT soma;
	END //
DELIMITER ;

CALL proc_acumula(5);
CALL proc_acumula(-1);



-- Exemplo procedure repeat tabuada

DELIMITER //

CREATE PROCEDURE 
	proc_tabuada_r(valor INT)
	MAIN:
	BEGIN
	
	DECLARE contador INT DEFAULT 0;
	DECLARE tabuada INT DEFAULT 0;
	
	IF valor < 0 THEN
		SELECT 'O VALOR DEVE SER MAIOR QUE ZERO' AS ERRO;
		LEAVE MAIN;
	END IF;
	
	REPEAT
		SET tabuada = valor * contador;
        SELECT CONCAT(valor, 'x', contador, '=', tabuada) AS Resultado;
        SET contador = contador + 1;
		UNTIL contador > 10
	END REPEAT;
    
END //

DELIMITER ;

CALL proc_tabuada_r (2);
-- DROP PROCEDURE proc_tabuada_r;


-- EXEMPLO com tabela temporaria para ficar mais fácil a visualização

DELIMITER //
CREATE PROCEDURE
	proc_tabuada_rt (tabuada INT)
    BEGIN
		DECLARE contador INT DEFAULT 0;
        DECLARE resultado INT DEFAULT 0;
        -- criando a tabela temporaria
        CREATE TEMPORARY TABLE temp_tab (res VARCHAR (50));
	REPEAT
		SET contador = contador + 1;
        SET resultado = tabuada * contador;
        -- inserindo registros dentro da tabela temporaria
        INSERT INTO temp_tab
			SELECT CONCAT(tabuada, ' x ', contador, ' = ', resultado) AS RESULTADO;
		UNTIL contador > 9
	END REPEAT;
    -- selecionando os dados da tabela temporaria
    SELECT * FROM temp_tab;
    -- dropando essa tabela
    DROP TEMPORARY TABLE temp_tab;
END //
DELIMITER ;

CALL proc_tabuada_rt(7);

