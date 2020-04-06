-- Exemplo agora de um LOOp com WHILE

DELIMITER //
CREATE PROCEDURE
	proc_acumula_w(valor_teto INT)
    MAIN:
    BEGIN
		DECLARE contador INT DEFAULT 0;
        DECLARE soma 	 INT DEFAULT 0;
	IF valor_teto < 1 THEN
		SELECT 'O VALOR DEVE SER MAIOR QUE ZERO' AS ERRO;
        LEAVE MAIN;
	END IF;
    WHILE contador < valor_teto DO
		SET contador = contador + 1;
        SET soma = soma + contador;
	END WHILE;
    SELECT soma;
END //

DELIMITER ;

CALL proc_acumula_w(5);