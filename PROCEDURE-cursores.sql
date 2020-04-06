/*
	CURSORES
		são areas compostas por linhas e colunas em memória que servem para armazenar o resultado de uma consulta (SELECT)
        que retorna 0 ou mais linhas
        
        sintaxe:
        
        DECLARE cursor_name CURSOR FOR SELECT_STATEMENT;
			OPEN cursor_name;
				FETCH cursor_name INTO lista de variaveis;
			CLOSE cursor_name;
		DELCARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
        
		isto é util para colocar o resultado de uma busca em varias variaveis,
        onde cada coluna recebe uma variavel
*/

-- exemplo

DELIMITER //
CREATE PROCEDURE proc_campeonato (INOUT classificacao VARCHAR(4000))
BEGIN
	DECLARE p_final 	INTEGER DEFAULT 0; -- utilizada para definir que acabou a lista de times
    DECLARE p_time		VARCHAR(100) DEFAULT '';
    DECLARE p_pontos	VARCHAR(100) DEFAULT '';
    DECLARE p_posicao	VARCHAR(100) DEFAULT 1;
    DECLARE p_acum		INTEGER DEFAULT 0;
    DECLARE p_situa		VARCHAR(100);
    
    -- DECLARANDO UM CURSOR PARA TIME CURSOR
    DECLARE time_cursor CURSOR FOR
		SELECT nometime, pontos FROM campeonato ORDER BY pontos DESC;
	
    -- DELCARE NOT FOUND HANDLER
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET p_final = 1;
    
    
    -- criando uma tbl temporaria dentro da proc para armazenar as infos
    
    CREATE TEMPORARY TABLE lista_camp
    (
		posicao INT,
        time	VARCHAR (150),
        pontos	INT,
        p_acum	INT,
        situacao VARCHAR(100)
    );
    
    OPEN time_cursor;
    
		loop_campeonato: LOOP
		
			FETCH time_cursor INTO p_time, p_pontos;
			
			IF p_final = 1 THEN
				LEAVE loop_campeonato;
			END IF;
		
			
			IF p_posicao <= 6 THEN
				SET p_situa = 'LIBERTADORES';
			ELSEIF p_posicao <= 8 THEN
				SET p_situa = 'PRE-LIBERTADORES';
			ELSEIF p_posicao <= 12 THEN
				SET p_situa = 'SUL-AMERICANA';
			ELSEIF p_posicao <= 16 THEN
				SET p_situa = '';
			ELSEIF p_posicao >=17 THEN
				SET p_situa = 'REBAIXADO';
			END IF;
			
			-- acumulando pontos
			SET p_acum = p_acum + p_pontos;
			-- insert na table temp
			INSERT INTO lista_camp VALUES (p_posicao, p_time, p_pontos,p_acum,p_situa);
			
			SET p_posicao = p_posicao + 1;
        
        END LOOP loop_campeonato;
        
	CLOSE time_cursor;
    
    SELECT * FROM lista_camp;
    
    DROP TEMPORARY TABLE lista_camp;
    
END //

DELIMITER ;

SET @classificacao = '';
CALL proc_campeonato (@classificacao);
SELECT @classificacao;
