-- PROCEDURA COM REPETIÇÃO LOOP
DELIMITER //

CREATE PROCEDURE
	proc_tabuada_l(tabuada INT)
    
    BEGIN
    
		DECLARE contador INT DEFAULT 0;
        DECLARE resultado INT DEFAULT 0;
        CREATE TEMPORARY TABLE temp_tab (res VARCHAR(50));
        
	loop_tabuada: LOOP
    
		SET contador = contador + 1;
        SET resultado = tabuada * contador;
        INSERT INTO temp_tab
			SELECT  CONCAT(tabuada, ' x ', contador, ' = ', resultado) AS resultado;
            
        IF contador > 9 THEN
			LEAVE loop_tabuada;
		END IF;
        
	END LOOP loop_tabuada;
    
    SELECT * FROM temp_tab;
    DROP TEMPORARY TABLE temp_tab;
    
END //

DELIMITER ;

CALL proc_tabuada_l(5);
DROP PROCEDURE proc_tabuada_l;