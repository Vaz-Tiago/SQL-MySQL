/*
	ITERATE - 	Usado apenas dentro deestruturas de repetição e significa
				"INICIE O LOOP NOVAMENTE".
                
	ITERATE _ WHILE
    
*/

DELIMITER //
CREATE PROCEDURE proc_mod_par(teto INT)
	MAIN:
	BEGIN
		DECLARE contador INT DEFAULT 0;
		enquanto_par: 
		WHILE contador < teto DO
			SET contador = contador + 1;
			-- resultado será 0 ou 1, 0 imprime e 1 retorna ao inicio
			IF MOD(contador,2) THEN
				ITERATE enquanto_par;
			END IF;
			SELECT CONCAT(contador, ' é um número par, resultado mod ', MOD(contador,2)) AS Valor;
		END WHILE;
	END//
DELIMITER ;

CALL proc_mod_par(15);

-- ITERATE _ LOOP

DELIMITER //

CREATE PROCEDURE proc_acumula_iterate(valor_teto INT)
	main: BEGIN
    
		DECLARE contador INT DEFAULT 0;
        DECLARE soma INT DEFAULT 0;
		
        IF valor_teto < 1 THEN
			SELECT 'O valor deve ser maior que zero' AS ERRO;
            LEAVE main;
		END IF;
        
	teste: LOOP
    
		SET contador = contador + 1;
        SET soma = soma + contador;
        
        IF contador < valor_teto THEN
			ITERATE teste;
		END IF;
        
        LEAVE teste;
        
	END LOOP teste;
	
    SELECT soma;
    
END //

DELIMITER ;

CALL proc_acumula_iterate(2);